import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart'; // To navigate to MyHomePage
import '../widgets/swipe_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const Color primaryText = Color(0xFF2D2D36); // Dark slate/navy
    const Color backgroundGray = Color(0xFFF9F9FC); // Off-white/light gray
    const Color brandYellow = Color(0xFFFFC502);

    return Scaffold(
      backgroundColor: backgroundGray,
      body: Column(
        children: [
          // Top Curved Section
          Container(
            height: size.height * 0.55,
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
                      .animate()
                      .fade(duration: 800.ms)
                      .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuart),
                  const SizedBox(height: 30),

                  // Icons Row
                  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.local_pizza_outlined,
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
                      .animate(delay: 200.ms)
                      .fade(duration: 800.ms)
                      .scale(
                        begin: const Offset(0.8, 0.8),
                        curve: Curves.easeOutBack,
                      ),
                ],
              ),
            ),
          ),

          // Bottom Text Section
          Expanded(
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
                          fontSize: 42,
                          fontWeight: FontWeight.w800,
                          color: primaryText,
                          letterSpacing: -0.5,
                          height: 1.1,
                        ),
                      )
                      .animate(delay: 400.ms)
                      .fade(duration: 600.ms)
                      .slideX(begin: -0.1, end: 0, curve: Curves.easeOutQuart),

                  const SizedBox(height: 16),

                  Text(
                        "Explore the best local restaurants and get your favorite food delivered to your door.",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: const Color(0xFF6C757D),
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                      .animate(delay: 500.ms)
                      .fade(duration: 600.ms)
                      .slideX(begin: -0.1, end: 0, curve: Curves.easeOutQuart),

                  const Spacer(),

                  // Swipe Button
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child:
                        SwipeButton(
                              onComplete: () {
                                Future.delayed(
                                  const Duration(milliseconds: 300),
                                  () {
                                    Navigator.of(context).pushReplacement(
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (
                                              context,
                                              animation,
                                              secondaryAnimation,
                                            ) => const MyHomePage(
                                              title: 'Grab Eats Home',
                                            ),
                                        transitionsBuilder:
                                            (
                                              context,
                                              animation,
                                              secondaryAnimation,
                                              child,
                                            ) {
                                              return FadeTransition(
                                                opacity: animation,
                                                child: child,
                                              );
                                            },
                                        transitionDuration: const Duration(
                                          milliseconds: 800,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            )
                            .animate(delay: 700.ms)
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
        ],
      ),
    );
  }
}
