import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import 'check_table_screen.dart';
import 'skip_search_screen.dart';

class SmarterDiningScreen extends StatelessWidget {
  const SmarterDiningScreen({super.key});

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
          // The morphing yellow block
          Align(
            alignment: Alignment.topCenter,
            child: const SizedBox() // Dummy widget
                .animate()
                .custom(
              duration: 1200.ms,
              curve: Curves.easeInOutCubic,
              builder: (context, value, child) {
                // value 0.0 to 1.0
                double startHeight = size.height * 0.55;
                double targetHeight = 160;
                
                double startWidth = size.width;
                double targetWidth = 160;
                
                double startBottomRadius = size.width * 0.4;
                double targetRadius = 80;
                
                double currentHeight = lerpDouble(startHeight, targetHeight, value)!;
                double currentWidth = lerpDouble(startWidth, targetWidth, value)!;
                double currentBottomRadius = lerpDouble(startBottomRadius, targetRadius, value)!;
                double currentTopRadius = lerpDouble(0, targetRadius, value)!;
                
                double targetTopMargin = size.height * 0.35 - 80; 
                double currentTopMargin = lerpDouble(0, targetTopMargin, value)!;

                return Container(
                  margin: EdgeInsets.only(top: currentTopMargin),
                  width: currentWidth,
                  height: currentHeight,
                  decoration: BoxDecoration(
                    color: brandYellow,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(currentBottomRadius),
                      bottomRight: Radius.circular(currentBottomRadius),
                      topLeft: Radius.circular(currentTopRadius),
                      topRight: Radius.circular(currentTopRadius),
                    ),
                  ),
                  child: value > 0.6
                      ? Center(
                          child: Icon(
                            Icons.lunch_dining_outlined, // Hamburger icon
                            size: 65,
                            color: const Color(0xFF2D2D2D)
                                .withOpacity(((value - 0.6) * 2.5).clamp(0.0, 1.0)),
                          ),
                        )
                      : const SizedBox.shrink(),
                );
              },
            ),
          ),

          // Text content
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: size.height * 0.35 + 110),
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Smarter Dining Starts Here",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 32, // Adjusted slightly to fit the longer title
                      fontWeight: FontWeight.w700,
                      color: primaryText,
                      letterSpacing: -0.5,
                      height: 1.1,
                    ),
                  )
                      .animate(delay: 500.ms)
                      .fade(duration: 600.ms)
                      .slideX(begin: 0.1, end: 0, curve: Curves.easeOutQuart),
                  const SizedBox(height: 16),
                  Text(
                    "Discover nearby dining spots, check live occupancy, and walk straight to your perfect table — no waiting, no wandering.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: const Color(0xFF6C757D),
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                      .animate(delay: 700.ms)
                      .fade(duration: 600.ms)
                      .slideX(begin: 0.1, end: 0, curve: Curves.easeOutQuart),
                ],
              ),
            ),
          ),

          // Bottom navigation buttons
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeOutBack,
                            builder: (context, value, child) {
                              return Row(
                                children: List.generate(4, (index) {
                                  bool isActive = index == 2;
                                  bool isPrevious = index == 1;
                                  
                                  double width = 12.0;
                                  Color color = Colors.grey.shade300;
                                  
                                  if (isActive) {
                                    width = lerpDouble(12.0, 32.0, value)!;
                                    color = Color.lerp(Colors.grey.shade300, brandYellow, value)!;
                                  } else if (isPrevious) {
                                    width = lerpDouble(32.0, 12.0, value)!;
                                    color = Color.lerp(brandYellow, Colors.grey.shade300, value)!;
                                  }

                                  return Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    width: width,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: color,
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) =>
                                      const SkipSearchScreen(),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(1.0, 0.0),
                                        end: Offset.zero,
                                      ).chain(CurveTween(curve: Curves.easeOutQuart)).animate(animation),
                                      child: child,
                                    );
                                  },
                                  transitionDuration: const Duration(milliseconds: 800),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: brandYellow,
                              ),
                              child: const Icon(
                                Icons.arrow_forward_rounded,
                                color: Color(0xFF2D2D2D),
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ).animate(delay: 900.ms).fade(duration: 600.ms).slideY(
                            begin: 0.2,
                            end: 0,
                            curve: Curves.easeOutBack,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Dynamic back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 24,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const CheckTableScreen(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(-1.0, 0.0),
                          end: Offset.zero,
                        ).chain(CurveTween(curve: Curves.easeOutQuart)).animate(animation),
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
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Color(0xFF2D2D2D),
                  size: 24,
                ),
              ),
            ).animate(delay: 300.ms).fade(duration: 400.ms).slideX(begin: -0.2, end: 0, curve: Curves.easeOutQuart),
          ),
        ],
      ),
    );
  }
}
