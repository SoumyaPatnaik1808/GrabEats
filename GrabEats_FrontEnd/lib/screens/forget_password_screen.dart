import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryText = Color(0xFF2D2D36);
    const Color backgroundGray = Color(0xFFF9F9FC);
    const Color brandYellow = Color(0xFFFFC502);
    const Color fieldGray = Color(0xFFF1F1F5);
    const Color labelGray = Color(0xFF6C757D);

    return Scaffold(
      backgroundColor: backgroundGray,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top circular back button
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Color(0xFF2D2D2D),
                    size: 24,
                  ),
                ),
              ).animate().fade(duration: 400.ms).slideX(begin: -0.2, end: 0, curve: Curves.easeOutQuart),

              const SizedBox(height: 32),

              // Title
              Text(
                "Reset Password",
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: primaryText,
                  letterSpacing: -0.5,
                  height: 1.1,
                ),
              ).animate().fade(delay: 100.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 12),

              // Subtitle
              Text(
                "Enter your email address and we'll send you a link to reset your password.",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: labelGray,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ).animate().fade(delay: 200.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 40),

              // Email Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "EMAIL ADDRESS",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: labelGray,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: fieldGray,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "julian@curated.com",
                        hintStyle: GoogleFonts.inter(
                          color: Colors.grey.shade400,
                          fontSize: 15,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.alternate_email, color: Colors.grey.shade400, size: 20),
                      ),
                    ),
                  ),
                ],
              ).animate().fade(delay: 300.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 40),

              // Reset button
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: brandYellow,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: brandYellow.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Send Reset Link",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: primaryText,
                    ),
                  ),
                ),
              ).animate().fade(delay: 400.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),

            ],
          ),
        ),
      ),
    );
  }
}
