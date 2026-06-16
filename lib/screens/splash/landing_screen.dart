import 'package:flutter/material.dart';

import '../landlord/auth/landlord.dart';
import '../tanants/auth/tanat_login.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top illustration area
              SizedBox(
                height: 320,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background city silhouette
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: CustomPaint(
                        size: const Size(double.infinity, 180),
                        painter: _CitySkylinePainter(),
                      ),
                    ),
                    // Sofa illustration placeholder
                    Positioned(
                      bottom: 20,
                      child: Container(
                        width: 260,
                        height: 140,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0E6D8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.weekend_rounded,
                          size: 80,
                          color: Color(0xFFC87941),
                        ),
                      ),
                    ),
                    // Logo at top
                    Positioned(
                      top: 24,
                      child: Column(
                        children: [
                          const Icon(
                            Icons.house_rounded,
                            size: 52,
                            color: Color(0xFFC87941),
                          ),
                          const SizedBox(height: 4),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Stay',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1A1A2E),
                                  ),
                                ),
                                TextSpan(
                                  text: 'Connect',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFFC87941),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            'Find. Connect. Stay.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF8A8A9A),
                              letterSpacing: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Tagline
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    Text(
                      'Bringing landlords and\ntenants together.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A2E),
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Find the right place or the right\ntenant, easily and securely.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8A8A9A),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Role selection
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'I want to join as',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Tenant card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _RoleCard(
                  label: 'Tenant',
                  subtitle: 'Find a place to live',
                  backgroundColor: const Color(0xFFECEBF8),
                  avatarColor: const Color(0xFF7B6FD0),
                  icon: Icons.person_rounded,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const TenantLoginPage(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              // Landlord card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _RoleCard(
                  label: 'Landlord',
                  subtitle: 'List your property\nand find tenants',
                  backgroundColor: const Color(0xFFF5EDDF),
                  avatarColor: const Color(0xFFC87941),
                  icon: Icons.person_2_rounded,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const LandlordLoginPage(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 28),

              // Terms
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(fontSize: 12, color: Color(0xFF8A8A9A)),
                    children: [
                      TextSpan(text: 'By continuing, you agree to our '),
                      TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(
                          color: Color(0xFFC87941),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(text: ' and a '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: Color(0xFFC87941),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Home indicator
              Container(
                width: 120,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String label;
  final String subtitle;
  final Color backgroundColor;
  final Color avatarColor;
  final IconData icon;
  final VoidCallback onTap;

  const _RoleCard({
    required this.label,
    required this.subtitle,
    required this.backgroundColor,
    required this.avatarColor,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: avatarColor.withOpacity(0.2),
              child: Icon(icon, color: avatarColor, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF8A8A9A),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: avatarColor,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}

class _CitySkylinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFF0E6D8);
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.5);
    path.lineTo(size.width * 0.05, size.height * 0.5);
    path.lineTo(size.width * 0.05, size.height * 0.3);
    path.lineTo(size.width * 0.12, size.height * 0.3);
    path.lineTo(size.width * 0.12, size.height * 0.45);
    path.lineTo(size.width * 0.2, size.height * 0.45);
    path.lineTo(size.width * 0.2, size.height * 0.2);
    path.lineTo(size.width * 0.27, size.height * 0.2);
    path.lineTo(size.width * 0.27, size.height * 0.4);
    path.lineTo(size.width * 0.35, size.height * 0.4);
    path.lineTo(size.width * 0.35, size.height * 0.25);
    path.lineTo(size.width * 0.42, size.height * 0.25);
    path.lineTo(size.width * 0.42, size.height * 0.5);
    path.lineTo(size.width * 0.55, size.height * 0.5);
    path.lineTo(size.width * 0.55, size.height * 0.35);
    path.lineTo(size.width * 0.62, size.height * 0.35);
    path.lineTo(size.width * 0.62, size.height * 0.15);
    path.lineTo(size.width * 0.68, size.height * 0.15);
    path.lineTo(size.width * 0.68, size.height * 0.4);
    path.lineTo(size.width * 0.75, size.height * 0.4);
    path.lineTo(size.width * 0.75, size.height * 0.28);
    path.lineTo(size.width * 0.82, size.height * 0.28);
    path.lineTo(size.width * 0.82, size.height * 0.45);
    path.lineTo(size.width * 0.9, size.height * 0.45);
    path.lineTo(size.width * 0.9, size.height * 0.38);
    path.lineTo(size.width, size.height * 0.38);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CitySkylinePainter oldDelegate) => false;
}