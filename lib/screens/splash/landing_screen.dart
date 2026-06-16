import 'package:flutter/material.dart';
import '../landlord/auth/landlord.dart';
import '../tanants/auth/tanat_login.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0A00),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Hero image background
          Image.asset(
            'assets/images/hero.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),

          // Dark overlay for readability
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x66000000),
                  Color(0xAA000000),
                ],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // Logo + brand
                  Column(
                    children: [
                      CustomPaint(
                        size: const Size(90, 80),
                        painter: _HouseLogoPainter(),
                      ),
                      const SizedBox(height: 12),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Stay',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: 'Connect',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFFC87941),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Find. Connect. Stay.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFFDDCCBB),
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 48),

                  // Tagline
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        Text(
                          'Bringing landlords and\ntenants together.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 1.3,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Find the right place or the right\ntenant, easily and securely.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFCCBBAA),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Role label
                  const Text(
                    'I want to join as',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Tenant card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _RoleCard(
                      label: 'Tenant',
                      subtitle: 'Find a place to live',
                      icon: Icons.person_outline_rounded,
                      accentColor: const Color(0xFFC87941),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const TenantLoginPage(),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Landlord card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _RoleCard(
                      label: 'Landlord',
                      subtitle: 'List your property\nand find tenants',
                      useCustomIcon: true,
                      accentColor: const Color(0xFFC87941),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const LandlordLoginPage(),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 36),

                  // Terms
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFBBAA99),
                        ),
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
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Role Card ─────────────────────────────────────────────────────────────────

class _RoleCard extends StatelessWidget {
  final String label;
  final String subtitle;
  final IconData? icon;
  final bool useCustomIcon;
  final Color accentColor;
  final VoidCallback onTap;

  const _RoleCard({
    required this.label,
    required this.subtitle,
    this.icon,
    this.useCustomIcon = false,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.white.withOpacity(0.25),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Avatar circle
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accentColor.withOpacity(0.2),
                border: Border.all(
                  color: accentColor.withOpacity(0.6),
                  width: 1.5,
                ),
              ),
              child: useCustomIcon
                  ? Center(
                child: CustomPaint(
                  size: const Size(30, 30),
                  painter: _BuildingIconPainter(color: accentColor),
                ),
              )
                  : Icon(icon, color: accentColor, size: 28),
            ),

            const SizedBox(width: 16),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.65),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Chevron
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accentColor.withOpacity(0.2),
              ),
              child: Icon(
                Icons.chevron_right_rounded,
                color: accentColor,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── House Logo Painter ────────────────────────────────────────────────────────

class _HouseLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFC87941)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double cx = size.width / 2;

    // Roof
    final roofPath = Path()
      ..moveTo(cx, 4)
      ..lineTo(size.width - 6, size.height * 0.42)
      ..lineTo(6, size.height * 0.42)
      ..close();
    canvas.drawPath(roofPath, paint);

    // Walls
    final wallPath = Path()
      ..moveTo(12, size.height * 0.42)
      ..lineTo(12, size.height - 4)
      ..lineTo(size.width - 12, size.height - 4)
      ..lineTo(size.width - 12, size.height * 0.42);
    canvas.drawPath(wallPath, paint);

    final personPaint = Paint()
      ..color = const Color(0xFFC87941)
      ..style = PaintingStyle.fill;

    // Left person
    canvas.drawCircle(
      Offset(cx - 13, size.height * 0.58),
      5,
      personPaint,
    );
    final leftBodyPath = Path()
      ..moveTo(cx - 22, size.height - 8)
      ..quadraticBezierTo(
        cx - 13, size.height * 0.72,
        cx - 4, size.height - 8,
      );
    canvas.drawPath(leftBodyPath, paint..style = PaintingStyle.stroke);

    // Right person
    canvas.drawCircle(
      Offset(cx + 13, size.height * 0.58),
      5,
      personPaint,
    );
    final rightBodyPath = Path()
      ..moveTo(cx + 4, size.height - 8)
      ..quadraticBezierTo(
        cx + 13, size.height * 0.72,
        cx + 22, size.height - 8,
      );
    canvas.drawPath(rightBodyPath, paint..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(_HouseLogoPainter oldDelegate) => false;
}

// ── Building Icon Painter ─────────────────────────────────────────────────────

class _BuildingIconPainter extends CustomPainter {
  final Color color;
  const _BuildingIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Main building body
    canvas.drawRect(
      Rect.fromLTWH(4, size.height * 0.35, size.width - 8, size.height * 0.65),
      paint,
    );

    // Roof triangle
    final roofPath = Path()
      ..moveTo(size.width / 2, 2)
      ..lineTo(size.width - 4, size.height * 0.35)
      ..lineTo(4, size.height * 0.35)
      ..close();
    canvas.drawPath(roofPath, paint);

    // Windows
    final windowSize = size.width * 0.12;
    for (final w in [
      Offset(size.width * 0.25, size.height * 0.48),
      Offset(size.width * 0.62, size.height * 0.48),
      Offset(size.width * 0.25, size.height * 0.68),
      Offset(size.width * 0.62, size.height * 0.68),
    ]) {
      canvas.drawRect(
        Rect.fromCenter(center: w, width: windowSize, height: windowSize),
        fillPaint,
      );
    }

    // Door
    canvas.drawRect(
      Rect.fromLTWH(
        size.width / 2 - windowSize * 0.7,
        size.height * 0.75,
        windowSize * 1.4,
        size.height * 0.25,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(_BuildingIconPainter oldDelegate) => false;
}