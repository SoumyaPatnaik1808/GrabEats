import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'welcome_screen.dart';
import '../models/favorites_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showSyntheticDialog(BuildContext context, String title, String info) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF111111),
                  ),
                ).animate().fade().slideY(begin: 0.2, end: 0),
                const SizedBox(height: 16),
                Text(
                  info,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ).animate(delay: 100.ms).fade().slideY(begin: 0.2, end: 0),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC502),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                    ),
                    child: Text(
                      "Close",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111111),
                      ),
                    ),
                  ),
                ).animate(delay: 200.ms).fade().slideY(begin: 0.2, end: 0),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFavoritesDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Favorite Restaurants",
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF111111),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ValueListenableBuilder<Set<String>>(
                    valueListenable: FavoritesManager().favoritesNotifier,
                    builder: (context, favorites, _) {
                      if (favorites.isEmpty) {
                        return Center(
                          child: Text(
                            "No favorite restaurant",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: favorites.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final String title = favorites.elementAt(index);
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9F9FB),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.restaurant,
                                  color: Color(0xFFFFC502),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    title,
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF111111),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    FavoritesManager().toggleFavorite(title);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC502),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                    ),
                    child: Text(
                      "Close",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111111),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const Color backgroundGray = Color(0xFFF9F9FB);
    const Color primaryText = Color(0xFF111111);

    return Scaffold(
      backgroundColor: backgroundGray,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: primaryText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Grab Eats",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: const Color.fromARGB(255, 0, 0, 0), // Dark golden text
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: const Color(0xFF1E293B),
              child: const Icon(
                Icons.person,
                color: Color(0xFFFFC502),
                size: 18,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                // Yellow background curved section
                Container(
                  height: 350,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFE5B000), Color(0xFFD49C00)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      // Avatar with edit button
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              image: const DecorationImage(
                                image: NetworkImage(
                                  'https://i.pravatar.cc/150?u=a',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -6,
                            right: -6,
                            child: GestureDetector(
                              onTap: () => _showSyntheticDialog(
                                context,
                                "Edit Profile",
                                "Upload a new photo, or update your username right from this screen!",
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Color(0xFF6B5000),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ).animate().scale(
                        duration: 500.ms,
                        curve: Curves.easeOutBack,
                      ),

                      const SizedBox(height: 16),
                      Text(
                            "Soumya Patnaik",
                            style: GoogleFonts.inter(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          )
                          .animate(delay: 100.ms)
                          .fade()
                          .slideY(begin: 0.2, end: 0),
                      const SizedBox(height: 4),
                      Text(
                            "patnaiksoumya20@gmail.com",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          )
                          .animate(delay: 200.ms)
                          .fade()
                          .slideY(begin: 0.2, end: 0),
                    ],
                  ),
                ),

                // Floating Action Cards
                Positioned(
                  bottom: -60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildActionCard(
                          context,
                          title: "My Orders",
                          subtitle: "Track & reorder",
                          icon: Icons.receipt_long,
                          iconColor: const Color(0xFFD4A000),
                          bgColor: const Color(0xFFFFF6E0),
                          onTap: () => _showSyntheticDialog(
                            context,
                            "My Orders",
                            "Here are your last 5 orders. You can quickly re-order any of your favorite meals or track a currently arriving delivery!",
                          ),
                        ).animate(delay: 500.ms).fade().slideY(begin: 0.3, end: 0),
                        const SizedBox(width: 16),
                        _buildActionCard(
                              context,
                              title: "Favorite\nRestaurants",
                              subtitle: "Your top picks",
                              icon: Icons.favorite,
                              iconColor: const Color(0xFFC73D3D),
                              bgColor: const Color(0xFFFFEDED),
                              onTap: () => _showFavoritesDialog(context),
                            )
                            .animate(delay: 600.ms)
                            .fade()
                            .slideY(begin: 0.3, end: 0),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 90), // Spacing for floating cards
            // Account Settings List
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      top: 24,
                      bottom: 8,
                    ),
                    child: Text(
                      "ACCOUNT SETTINGS",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade500,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  _buildListTile(
                    Icons.person,
                    "Personal Information",
                    () => _showSyntheticDialog(
                      context,
                      "Personal Information",
                      "Manage your First Name, Last Name, Gender, and Birthday. Keep your profile up to date for personalized deals!",
                    ),
                  ),
                  Divider(color: Colors.grey.shade100, height: 1),
                  _buildListTile(
                    Icons.account_balance_wallet,
                    "Payment Methods",
                    () => _showSyntheticDialog(
                      context,
                      "Payment Methods",
                      "You currently have 2 cards linked (Visa ending in 1234, Mastercard ending in 8890). Tap here to add Apple Pay or Google Pay.",
                    ),
                  ),
                  Divider(color: Colors.grey.shade100, height: 1),
                  _buildListTile(
                    Icons.notifications,
                    "Notifications",
                    () => _showSyntheticDialog(
                      context,
                      "Notifications",
                      "Toggle your email and push notifications. Never miss a limited-time discount or order status update!",
                    ),
                  ),
                  Divider(color: Colors.grey.shade100, height: 1),
                  _buildListTile(
                    Icons.settings,
                    "Settings",
                    () => _showSyntheticDialog(
                      context,
                      "Settings",
                      "Adjust your language preferences, dark/light mode functionality, app permissions, and more.",
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ).animate(delay: 700.ms).fade().slideY(begin: 0.1, end: 0),

            const SizedBox(height: 24),

            // Logout Button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                      (r) => false,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.logout,
                          color: Color(0xFFA52A2A),
                          size: 22,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Logout",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFA52A2A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ).animate(delay: 800.ms).fade().slideY(begin: 0.1, end: 0),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    final double cardWidth = (MediaQuery.of(context).size.width - 48 - 16) / 2;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF111111),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Row(
            children: [
              Icon(icon, color: Colors.grey.shade700, size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF111111),
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
