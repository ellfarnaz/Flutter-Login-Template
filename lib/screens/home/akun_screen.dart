import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'SlidePageRoute.dart';
import 'package:google_fonts/google_fonts.dart';

class AkunScreen extends StatelessWidget {
  const AkunScreen({super.key});

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color(0xFF4285F4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              children: [
                // Profile Section
                Container(
                  width: 200,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color(0xFFB3CEFA),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Profile Grid
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFFB3CEFA),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 1,
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(
                            4,
                            (index) => Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF5F93CF),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Name
                      Text(
                        'Farel Naufal A',
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // University
                      Text(
                        'Universitas Teknologi Yogyakarta',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Menu Section
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Material(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          _buildMenuItem(
                            context: context,
                            icon: Icons.manage_accounts,
                            iconColor: Colors.blue,
                            title: 'Kelola Akun',
                            onTap: () {
                              Navigator.of(context)
                                  .push(SlidePageRoute(page: ProfileScreen()));
                            },
                            isFirstItem: true,
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            context: context,
                            icon: Icons.notifications_active,
                            iconColor: Colors.orange,
                            title: 'Notifikasi',
                            onTap: () =>
                                _showSnackBar(context, 'Notifikasi clicked'),
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            context: context,
                            icon: Icons.privacy_tip,
                            iconColor: Colors.green,
                            title: 'Privacy Policy',
                            onTap: () => _showSnackBar(
                                context, 'Privacy Policy clicked'),
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            context: context,
                            icon: Icons.description,
                            iconColor: Colors.purple,
                            title: 'Terms of Service',
                            onTap: () => _showSnackBar(
                                context, 'Terms of Service clicked'),
                            isLastItem: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Color(0xFFB3CEFA),
      indent: 16,
      endIndent: 16,
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
    bool isFirstItem = false,
    bool isLastItem = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFF5F93CF),
            ),
          ],
        ),
      ),
    );
  }
}
