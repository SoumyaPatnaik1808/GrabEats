import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'restaurant_details_screen.dart';
import 'profile_screen.dart';
import '../models/favorites_manager.dart';

class DashboardScreen extends StatefulWidget {
  final String username;
  const DashboardScreen({super.key, this.username = 'Soumya'});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  bool _isInitilized = false;
  final ScrollController _scrollController = ScrollController();
  late AnimationController _entranceController;
  late Animation<double> _entranceAnimation;

  @override
  void initState() {
    super.initState();
    
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _entranceAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeInOutCubic,
    );

    // Trigger the animation shortly after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() {
            _isInitilized = true;
          });
          _entranceController.forward();
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const Color brandYellow = Color(0xFFFFC502);
    const Color backgroundGray = Colors.white; // Updated to white as per user feedback
    const Color primaryText = Color(0xFF111111);

    return Scaffold(
      backgroundColor: backgroundGray,
      body: Stack(
        children: [
          // Content below the header (Restaurants list)
          if (_isInitilized)
            Positioned.fill(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 380.0, bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Restaurant cards
                    _buildRestaurantCard(
                      'Appetite Resto Cafe',
                      'Service options: Reservations required · All you can eat · Happy-hour food',
                      10,
                      500,
                    ),
                    const SizedBox(height: 16),
                    _buildRestaurantCard(
                      'Amoore Fusion Kitchen',
                      'Service options: All you can eat · Vegetarian options · Live music',
                      7,
                      500,
                    ),
                    const SizedBox(height: 16),
                    _buildRestaurantCard(
                      'The Golden Plate',
                      'Service options: Dine-in · Takeaway · No delivery',
                      5,
                      1200,
                    ),
                    const SizedBox(height: 16),
                    _buildRestaurantCard(
                      'Spice Symphony',
                      'Service options: Outdoor seating · Vegan options · Free Wi-Fi',
                      14,
                      850,
                    ),
                    const SizedBox(height: 16),
                    _buildRestaurantCard(
                      'Ocean Bites Seafood',
                      'Service options: Has outdoor seating · Serves great cocktails',
                      2,
                      2100,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ).animate().fade(duration: 800.ms, delay: 600.ms).slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuart),
            ),

          // Animated Top Section & "Hi" Text merged into an AnimatedBuilder for SILKY smooth scroll
          AnimatedBuilder(
            animation: Listenable.merge([_entranceController, _scrollController]),
            builder: (context, child) {
              double scroll = _scrollController.hasClients ? _scrollController.offset : 0.0;
              double ratio = _entranceAnimation.value;
              
              // Entrance animation goes 0.0 (fullscreen) to 1.0 (370 height)
              double baseHeight = size.height - ((size.height - 370.0) * ratio);
              
              // Apply native flawless scroll shrinking mapping 1:1, clamped to min height 0
              double currentHeight = (baseHeight - scroll).clamp(0.0, size.height);
              
              // Fade out the yellow header as we scroll
              double yellowOpacity = (1.0 - (scroll / 200.0)).clamp(0.0, 1.0);

              // Calculate Text Trajectories flawlessly without setState jitter
              double startTextTop = (size.height / 2) - 20;
              double endTextTop = 55.0;
              double currentTextTop = startTextTop + (endTextTop - startTextTop) * ratio;
              // Stagnant text position when scrolling

              double startTextLeft = (size.width / 2) - 80;
              double endTextLeft = 24.0;
              double currentTextLeft = startTextLeft + (endTextLeft - startTextLeft) * ratio;
              
              double fontSize = 32.0 - ((32.0 - 22.0) * ratio);

              return Stack(
                children: [
                  // Persistent white background for the text and profile icon, 
                  // to cover the scrolling list items as they scroll under it.
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 110.0,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),

                  // Yellow Background Header
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: currentHeight,
                    child: Opacity(
                      opacity: yellowOpacity,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          color: brandYellow,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                            bottomRight: Radius.circular(100),
                          ),
                        ),
                        child: _isInitilized
                            ? Stack(
                                children: [
                                  // Explore text with deeper scroll parallax mapping
                                  Positioned(
                                    top: 140 - (scroll * 0.6),
                                    left: 0,
                                    right: 0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Explore',
                                          style: GoogleFonts.inter(
                                            fontSize: 48,
                                            fontWeight: FontWeight.w800,
                                            color: primaryText,
                                            height: 1.1,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Explore the restaurants near you',
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: primaryText.withOpacity(0.8),
                                          ),
                                        ),
                                      ],
                                    ).animate().fade(duration: 800.ms, delay: 600.ms).slideY(begin: 0.2, end: 0),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ),

                  // "Hi, Username !" Text
                  Positioned(
                    top: currentTextTop,
                    left: currentTextLeft,
                    child: Text(
                      "Hi, ${widget.username} !",
                      style: GoogleFonts.inter(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w800,
                        color: primaryText,
                      ),
                    ),
                  ),
                  
                  // Stagnant Profile image
                  if (_isInitilized)
                    Positioned(
                      top: 45,
                      right: 20,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ProfileScreen()),
                          );
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue.shade200,
                          child: const Icon(Icons.person, color: Colors.blueAccent),
                        ).animate().fade(duration: 600.ms, delay: 500.ms).scaleXY(begin: 0.8, end: 1.0),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantCard(String title, String subtitle, int seats, int distanceMeters) {
    return _RestaurantCard(
      title: title,
      subtitle: subtitle,
      seats: seats,
      distanceMeters: distanceMeters,
    );
  }
}

class _RestaurantCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final int seats;
  final int distanceMeters;
  final String description;

  const _RestaurantCard({
    required this.title,
    required this.subtitle,
    required this.seats,
    required this.distanceMeters,
    this.description = "A fantastic place providing curated dining experiences with top-notch service and exquisite cuisine. Reserve your table instantly and enjoy every occasion.",
  });

  @override
  State<_RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<_RestaurantCard> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Color brandYellow = Color(0xFFFFC502);
    const Color primaryText = Color(0xFF111111);

    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.fastOutSlowIn,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: brandYellow,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: primaryText,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.subtitle,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: primaryText.withOpacity(0.7),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${widget.seats} seats available',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: primaryText,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Icon(Icons.location_on, size: 14, color: primaryText),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.distanceMeters}m',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: primaryText.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder<Set<String>>(
                  valueListenable: FavoritesManager().favoritesNotifier,
                  builder: (context, favorites, _) {
                    final isLiked = favorites.contains(widget.title);
                    return GestureDetector(
                      onTap: () {
                        FavoritesManager().toggleFavorite(widget.title);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4.0),
                        color: Colors.transparent,
                        child: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          size: 24,
                          color: isLiked ? Colors.red : primaryText,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            // Expanded detail section
            AnimatedSize(
              duration: const Duration(milliseconds: 350),
              curve: Curves.fastOutSlowIn,
              alignment: Alignment.topCenter,
              child: _isExpanded
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16),
                        Divider(color: Colors.black.withOpacity(0.1)),
                        const SizedBox(height: 12),
                        Text(
                          widget.description,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: primaryText.withOpacity(0.85),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => RestaurantDetailsScreen(restaurantName: widget.title),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryText, // Black button
                            foregroundColor: Colors.white, // White text
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            elevation: 0,
                          ),
                          child: Text(
                            "Explore Now",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(width: double.infinity, height: 0),
            ),
          ],
        ),
      ),
    );
  }
}
