import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'welcome_screen.dart';
import 'dashboard_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late int _secondsRemaining;
  final List<TextEditingController> _otpControllers = List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    _secondsRemaining = 59;
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(Duration.zero, () async {
      while (_secondsRemaining > 0) {
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          setState(() {
            _secondsRemaining--;
          });
        }
      }
    });
  }

  void _resendOtp() {
    setState(() {
      _secondsRemaining = 59;
      for (var controller in _otpControllers) {
        controller.clear();
      }
    });
    _startTimer();
  }

  void _handleOtpInput(String value, int index) {
    if (value.length == 1 && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  String _getOtp() {
    return _otpControllers.map((controller) => controller.text).join();
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

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
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const WelcomeScreen(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
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
                "Verify Email",
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
                "We've sent a verification code to your email",
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

              const SizedBox(height: 12),

              // Email display
              Text(
                widget.email,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: brandYellow,
                  fontWeight: FontWeight.w600,
                ),
              )
                  .animate()
                  .fade(delay: 250.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 40),

              // OTP label
              Text(
                "VERIFICATION CODE",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: labelGray,
                  letterSpacing: 1.0,
                ),
              )
                  .animate()
                  .fade(delay: 300.ms, duration: 400.ms),

              const SizedBox(height: 16),

              // OTP input fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => SizedBox(
                    width: 70,
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      onChanged: (value) => _handleOtpInput(value, index),
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: '0',
                        hintStyle: GoogleFonts.inter(
                          color: Colors.grey.shade300,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 18),
                        filled: true,
                        fillColor: fieldGray,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: primaryText,
                      ),
                    ),
                  ).animate(delay: (300 + (index * 50)).ms).fade(duration: 400.ms).slideY(begin: 0.1, end: 0),
                ),
              ),

              const SizedBox(height: 40),

              // Timer and resend
              Center(
                child: Column(
                  children: [
                    Text(
                      "Code expires in",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: labelGray,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "00:${_secondsRemaining.toString().padLeft(2, '0')}",
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: _secondsRemaining <= 10 ? Colors.red : brandYellow,
                      ),
                    )
                        .animate()
                        .scaleXY(begin: 1.0, end: 1.05, duration: 500.ms, delay: 300.ms),
                    const SizedBox(height: 16),
                    if (_secondsRemaining == 0)
                      InkWell(
                        onTap: _resendOtp,
                        child: Text(
                          "Didn't receive code? Resend",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: brandYellow,
                          ),
                        ),
                      )
                          .animate()
                          .fade(duration: 300.ms)
                          .slideY(begin: 0.1, end: 0)
                    else
                      Text(
                        "Didn't receive code?",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: labelGray,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                  ],
                ),
              )
                  .animate()
                  .fade(delay: 500.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 40),

              // Verify button
              InkWell(
                onTap: () {
                  final otp = _getOtp();
                  if (otp.length == 4) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const DashboardScreen()),
                      (route) => false,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a valid OTP'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
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
                  .fade(delay: 600.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),
            ],
          ),
        ),
      ),
    );
  }
}
