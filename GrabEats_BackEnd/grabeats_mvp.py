import os
import time
import json
import cv2
from google import genai
import firebase_admin
from firebase_admin import credentials, db
from PIL import Image
from dotenv import load_dotenv

# ==========================================
# ⚙️ 1. CONFIGURATION & PRESETS
# ==========================================
load_dotenv(override=True)
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")
FIREBASE_DB_URL = os.getenv("FIREBASE_DB_URL")
CAMERA_URL = os.getenv("CAMERA_URL")
print(f"🔑 SYSTEM BOOT: Using API Key starting with [{GEMINI_API_KEY[:5]}] and ending in [{GEMINI_API_KEY[-4:]}]")
# Edge Node Presets (Change these if running on a different laptop/venue)
VENUE_ID = "Canteen_01"
VENUE_DETAILS = {
    "name": "VSSUT Main Canteen",
    "location": "Burla Campus",
    "theme_color": "0xFF0000",
    "status": "LIVE"
}

# ==========================================
# 🔌 2. SYSTEM INITIALIZATION
# ==========================================
print("🔌 Initializing Systems...")
# Initialize Gemini (NEW SDK)
client = genai.Client(api_key=GEMINI_API_KEY)
# Initialize Firebase
try:
    cred = credentials.Certificate("firebase_key.json")
    firebase_admin.initialize_app(cred, {
        'databaseURL': FIREBASE_DB_URL
    })
    print("✅ Firebase Realtime DB Connected Successfully.")
except Exception as e:
    print(f"❌ Firebase Error: {e}")
    exit()

# ==========================================
# 🚀 3. THE MAIN EXECUTION LOOP
# ==========================================
def analyze_and_push():
    IP_CAMERA_URL = CAMERA_URL
    while True:
        try:
            print(f"[{time.strftime('%H:%M:%S')}] 📸 Capturing frame...")
            cap = cv2.VideoCapture(IP_CAMERA_URL)
            if not cap.isOpened():
                print("❌ Camera Error: Could not open webcam.")
                exit()
            ret, frame = cap.read()
            cap.release()
            if not ret:
                print("⚠️ Failed to grab frame from camera. Retrying in 5s...")
                time.sleep(5)
                continue

            # Convert CV2 frame (BGR format) to PIL Image (RGB format) for Gemini
            rgb_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            pil_img = Image.fromarray(rgb_frame)
            save_path = f"latest_capture_{int(time.time())}.jpg"
            pil_img.save(save_path)

            print("🧠 Sending to Gemini AI for analysis...")
            # Strict prompt to force pure JSON output and prevent markdown formatting
            prompt = """
            Analyze this image of a seating area.
            Count the total number of physical seats/chairs visible.
            Count how many of those seats are currently occupied by a person or object.
            Return ONLY a valid JSON object in this exact format:
            {"total_seats": 4, "occupied_seats": 1}
            Do not include markdown tags, code blocks, or any other text.
            """

            # Execute API Call (NEW SDK)
            response = client.models.generate_content(
                model='gemini-2.5-flash',
                contents=[prompt, pil_img]
            )
            raw_output_text = response.text
            # Clean response just in case Gemini includes Markdown code blocks
            cleaned_response = raw_output_text.replace('```json', '').replace('```', '').strip()
            
            # Parse the JSON data
            data = json.loads(cleaned_response)
            total = data.get("total_seats", 0)
            occ = data.get("occupied_seats", 0)
            vacant = total - occ

            print(f"📊 AI Result -> Total: {total} | Occupied: {occ} | Vacant: {vacant}")

            # Push live data to Realtime Database
            print(f"☁️ Pushing to RTDB Node: restaurants/{VENUE_ID}...")
            
            # Create a reference to the specific restaurant node
            ref = db.reference(f'restaurants/{VENUE_ID}')
            
            payload = {
                **VENUE_DETAILS, 
                "total_seats": total,
                "occupied_seats": occ,
                "vacant_seats": vacant,
                # RTDB doesn't have SERVER_TIMESTAMP the same way, so we use a standard Unix timestamp
                "last_active": int(time.time() * 1000) 
            }
            
            # overwrite the node with the fresh data
            ref.set(payload)
            print("✅ SUCCESS: Realtime Database Updated!\n")

        except json.JSONDecodeError:
            print(f"⚠️ Error: Gemini returned invalid JSON format. Raw output: {response.text}")
        except Exception as e:
            print(f"⚠️ Unexpected Error: {e}")

        # Wait 30 seconds before next capture to prevent API throttling and database spam
        print("⏳ Waiting 20 seconds...\n")
        time.sleep(20)

if __name__ == "__main__":
    try:
        analyze_and_push()
    except KeyboardInterrupt:
        # Clean shutdown when you press Ctrl+C
        print("\n🛑 System Shutting Down...")
        cv2.destroyAllWindows()
        print("👋 Goodbye.")