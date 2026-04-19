import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import 'check_table_screen.dart';
import 'register_screen.dart';

import '../widgets/squeeze_next_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const Color primaryText = Color(0xFF2D2D36);
    const Color backgroundGray = Color(0xFFF9F9FC);
    const Color brandYellow = Color(0xFFFFC502);

    return Scaffold(
      backgroundColor: backgroundGray,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: size.height * 0.45,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                          "Welcome",
                          style: GoogleFonts.inter(
                            fontSize: 36,
                            fontWeight: FontWeight.w500,
                            color: primaryText,
                            letterSpacing: -0.5,
                            height: 1.0,
                          ),
                        )
                        .animate(delay: 1800.ms)
                        .fade(duration: 600.ms)
                        .slideX(
                          begin: -0.1,
                          end: 0,
                          curve: Curves.easeOutQuart,
                        ),

                    const SizedBox(height: 16),

                    Text(
                          "Explore the best local restaurants and get your favorite food delivered to your door.",
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: const Color(0xFF6C757D),
                            height: 1.5,
                            fontWeight: FontWeight.w200,
                          ),
                        )
                        .animate(delay: 2000.ms)
                        .fade(duration: 600.ms)
                        .slideX(
                          begin: -0.1,
                          end: 0,
                          curve: Curves.easeOutQuart,
                        ),

                    const Spacer(),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child:
                          Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: List.generate(4, (index) {
                                      return Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: index == 0
                                              ? brandYellow
                                              : Colors.grey.shade300,
                                        ),
                                      );
                                    }),
                                  ),
                                  SqueezeNextButton(
                                    onNavigate: () {
                                      Navigator.of(context).pushReplacement(
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation, secondaryAnimation) => const CheckTableScreen(),
                                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                            return FadeTransition(opacity: animation, child: child);
                                          },
                                          transitionDuration: const Duration(milliseconds: 800),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )
                              .animate(delay: 2200.ms)
                              .fade(duration: 600.ms)
                              .slideY(
                                begin: 0.3,
                                end: 0,
                                curve: Curves.easeOutBack,
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child:
                Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: brandYellow,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(size.width * 0.4),
                          bottomRight: Radius.circular(size.width * 0.4),
                        ),
                      ),
                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 30),
                            Text(
                                  "Grab Eats",
                                  style: GoogleFonts.poppins(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w800,
                                    color: primaryText,
                                    letterSpacing: -1,
                                  ),
                                )
                                .animate(delay: 1200.ms)
                                .fade(duration: 800.ms)
                                .slideY(
                                  begin: 0.2,
                                  end: 0,
                                  curve: Curves.easeOutQuart,
                                ),
                            const SizedBox(height: 30),

                            Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.chair_alt_outlined,
                                      size: 50,
                                      color: Colors.black.withOpacity(0.12),
                                    ),
                                    const SizedBox(width: 30),
                                    Icon(
                                      Icons.lunch_dining_outlined,
                                      size: 50,
                                      color: Colors.black.withOpacity(0.12),
                                    ),
                                    const SizedBox(width: 30),
                                    Icon(
                                      Icons.restaurant_outlined,
                                      size: 50,
                                      color: Colors.black.withOpacity(0.12),
                                    ),
                                  ],
                                )
                                .animate(delay: 1500.ms)
                                .fade(duration: 800.ms)
                                .scale(
                                  begin: const Offset(0.8, 0.8),
                                  curve: Curves.easeOutBack,
                                ),
                          ],
                        ),
                      ),
                    )
                    .animate(delay: 400.ms)
                    .custom(
                      duration: 1000.ms,
                      curve: Curves.easeInOutCubic,
                      builder: (context, value, child) {
                        return SizedBox(
                          height: size.height - (size.height * 0.45 * value),
                          child: child,
                        );
                      },
                    ),
          ),

          // Skip Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 24,
            child:
                InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const RegisterScreen(),
                            transitionsBuilder:
                                (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
                                  return SlideTransition(
                                    position:
                                        Tween<Offset>(
                                              begin: const Offset(1.0, 0.0),
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
                            transitionDuration: const Duration(
                              milliseconds: 800,
                            ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          "Skip",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF2D2D36),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                    .animate(delay: 600.ms)
                    .fade(duration: 400.ms)
                    .slideX(begin: 0.2, end: 0, curve: Curves.easeOutQuart),
          ),
        ],
      ),
    );
  }
}
