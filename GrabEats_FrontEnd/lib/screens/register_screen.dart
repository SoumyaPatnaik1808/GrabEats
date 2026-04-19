import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'welcome_screen.dart';
import 'login_screen.dart';
import 'dashboard_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
              // Top circular close button
              InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const WelcomeScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                return SlideTransition(
                                  position:
                                      Tween<Offset>(
                                            begin: const Offset(-1.0, 0.0),
                                            end: Offset.zero,
                                          )
                                          .chain(
                                            CurveTween(
                                              curve: Curves.easeOutQuart,
                                            ),
                                          )
                                          .animate(animation),
                                  child: child,
                                );
                              },
                          transitionDuration: const Duration(milliseconds: 800),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: brandYellow,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Color(0xFF2D2D2D),
                        size: 24,
                      ),
                    ),
                  )
                  .animate()
                  .fade(duration: 400.ms)
                  .slideX(begin: -0.2, end: 0, curve: Curves.easeOutQuart),

              const SizedBox(height: 32),

              // Title
              Text(
                    "Create Account",
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: primaryText,
                      letterSpacing: -0.5,
                      height: 1.1,
                    ),
                  )
                  .animate()
                  .fade(delay: 100.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 12),

              // Subtitle
              Text(
                    "Join the Grab Eats family and get the premium dining experince",
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: labelGray,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                  .animate()
                  .fade(delay: 200.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 32),

              // Continue with Google button
              _buildSocialButton(
                context,
                "Continue with Google",
                "lib/assets/google_logo.png",
                Colors.blue.shade600,
                Colors.transparent,
                primaryText,
              )
                  .animate()
                  .fade(delay: 250.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 12),

              // Continue with Apple button
              _buildSocialButton(
                context,
                "Continue with Apple",
                null,
                Colors.black,
                Colors.transparent,
                primaryText,
                isApple: true,
              )
                  .animate()
                  .fade(delay: 300.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 34),

              // Divider with "OR" text
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "OR",
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade400,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ).animate().fade(delay: 350.ms, duration: 400.ms),

              const SizedBox(height: 32),

              // Fields
              _buildField(
                    "FULL NAME",
                    "e.g. Julian Black",
                    Icons.person_outline,
                    fieldGray,
                    labelGray,
                  )
                  .animate()
                  .fade(delay: 400.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 24),

              _buildField(
                    "EMAIL ADDRESS",
                    "julian@curated.com",
                    Icons.alternate_email,
                    fieldGray,
                    labelGray,
                  )
                  .animate()
                  .fade(delay: 450.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 40),

              // Verify Email button
              InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const DashboardScreen()),
                    (route) => false,
                  );
                },
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
                        "Verify Email",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: primaryText,
                        ),
                      ),
                    ),
                  )
                  .animate()
                  .fade(delay: 550.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 40),

              // Login text
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const LoginScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                        transitionDuration: const Duration(milliseconds: 600),
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.inter(fontSize: 14, color: labelGray),
                      children: [
                        const TextSpan(text: "Already have an account? "),
                        TextSpan(
                          text: "Login",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            color: const Color(
                              0xFF98710B,
                            ), // Darker yellow/brown text
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ).animate().fade(delay: 650.ms, duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    String hint,
    IconData icon,
    Color bg,
    Color labelGray, {
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
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
            color: bg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.inter(
                color: Colors.grey.shade400,
                fontSize: 15,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              border: InputBorder.none,
              suffixIcon: Icon(icon, color: Colors.grey.shade400, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(
    BuildContext context,
    String text,
    String? imagePath,
    Color iconColor,
    Color backgroundColor,
    Color textColor, {
    bool isApple = false,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
          (route) => false,
        );
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
          border: (backgroundColor == Colors.white || backgroundColor == Colors.transparent)
              ? Border.all(
                  color: Colors.grey.shade300,
                  width: 1.2,
                )
              : null,
          boxShadow: backgroundColor == Colors.transparent
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isApple)
              Icon(
                Icons.apple,
                size: 24,
                color: iconColor,
              )
            else if (imagePath != null)
              // Provided Google asset
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(2),
                child: Image.asset(
                  imagePath,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              )
            else
              // Fallback: simple G-style marker
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      'G',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.blue.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(width: 12),
            Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
