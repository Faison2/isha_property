import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../landlord/auth/landlord_login.dart';
import '../tanants/auth/tanat_login.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _logoSlide;
  late Animation<Offset> _taglineSlide;
  late Animation<Offset> _cardsSlide;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnim = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _logoSlide = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));
    _taglineSlide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
    ));
    _cardsSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
    ));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF1A0A00),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Hero image
          Image.asset(
            'assets/images/hero.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),

          // Multi-layer overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.35, 0.65, 1.0],
                colors: [
                  Color(0x99000000),
                  Color(0x44000000),
                  Color(0x77000000),
                  Color(0xCC000000),
                ],
              ),
            ),
          ),

          // Ambient warm glow bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: size.height * 0.45,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0x88C87941),
                    Color(0x00C87941),
                  ],
                ),
              ),
            ),
          ),

          // Content
          FadeTransition(
            opacity: _fadeAnim,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  height: size.height - MediaQuery.of(context).padding.top,
                  child: Column(
                    children: [
                      const SizedBox(height: 32),

                      // ── Logo section ──
                      SlideTransition(
                        position: _logoSlide,
                        child: Column(
                          children: [
                            // Logo badge
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.08),
                                border: Border.all(
                                  color: const Color(0xFFC87941).withOpacity(0.5),
                                  width: 1.5,
                                ),
                              ),
                              child: Center(
                                child: CustomPaint(
                                  size: const Size(44, 40),
                                  painter: _HouseLogoPainter(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),

                            // Brand name
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Stay',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const Text(
                                  'Connect',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFC87941),
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 6),

                            // Pill tag
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 0.5,
                                ),
                              ),
                              child: const Text(
                                'Find  ·  Connect  ·  Stay',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // ── Tagline ──
                      SlideTransition(
                        position: _taglineSlide,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          child: Column(
                            children: [
                              const Text(
                                'Bringing landlords\nand tenants together.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  height: 1.25,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Find the right place or the right tenant,\neasily and securely.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.6),
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Spacer(),

                      // ── Cards section ──
                      SlideTransition(
                        position: _cardsSlide,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 4, bottom: 14),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 3,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFC87941),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'I want to join as',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Tenant card
                              _ModernRoleCard(
                                label: 'Tenant',
                                subtitle: 'Browse listings & find your perfect home',
                                tag: 'For renters',
                                icon: Icons.person_outline_rounded,
                                accentColor: const Color(0xFFC87941),
                                onTap: () {
                                  Navigator.of(context).push(
                                    _slideRoute(const TenantLoginPage()),
                                  );
                                },
                              ),

                              const SizedBox(height: 12),

                              // Landlord card
                              _ModernRoleCard(
                                label: 'Landlord',
                                subtitle: 'List properties & connect with tenants',
                                tag: 'For owners',
                                useCustomIcon: true,
                                accentColor: const Color(0xFFC87941),
                                onTap: () {
                                  Navigator.of(context).push(
                                    _slideRoute(const LandlordLoginPage()),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // ── Terms ──
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 11.5,
                              color: Colors.white.withOpacity(0.4),
                              height: 1.6,
                            ),
                            children: const [
                              TextSpan(text: 'By continuing you agree to our '),
                              TextSpan(
                                text: 'Terms of Service',
                                style: TextStyle(
                                  color: Color(0xFFC87941),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: Color(0xFFC87941),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Home bar
                      Container(
                        width: 134,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Route _slideRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          )),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}

// ── Modern Role Card ──────────────────────────────────────────────────────────

class _ModernRoleCard extends StatefulWidget {
  final String label;
  final String subtitle;
  final String tag;
  final IconData? icon;
  final bool useCustomIcon;
  final Color accentColor;
  final VoidCallback onTap;

  const _ModernRoleCard({
    required this.label,
    required this.subtitle,
    required this.tag,
    this.icon,
    this.useCustomIcon = false,
    required this.accentColor,
    required this.onTap,
  });

  @override
  State<_ModernRoleCard> createState() => _ModernRoleCardState();
}

class _ModernRoleCardState extends State<_ModernRoleCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pressController.forward(),
      onTapUp: (_) {
        _pressController.reverse();
        widget.onTap();
      },
      onTapCancel: () => _pressController.reverse(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
              width: 0.8,
            ),
          ),
          child: Row(
            children: [
              // Icon container
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: widget.accentColor.withOpacity(0.15),
                  border: Border.all(
                    color: widget.accentColor.withOpacity(0.4),
                    width: 1,
                  ),
                ),
                child: widget.useCustomIcon
                    ? Center(
                  child: CustomPaint(
                    size: const Size(28, 28),
                    painter:
                    _BuildingIconPainter(color: widget.accentColor),
                  ),
                )
                    : Icon(widget.icon, color: widget.accentColor, size: 28),
              ),

              const SizedBox(width: 14),

              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.label,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFC87941).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            widget.tag,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFFC87941),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.white.withOpacity(0.55),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Arrow
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFC87941).withOpacity(0.15),
                  border: Border.all(
                    color: const Color(0xFFC87941).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Color(0xFFC87941),
                  size: 18,
                ),
              ),
            ],
          ),
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
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double cx = size.width / 2;

    final roofPath = Path()
      ..moveTo(cx, 2)
      ..lineTo(size.width - 2, size.height * 0.42)
      ..lineTo(2, size.height * 0.42)
      ..close();
    canvas.drawPath(roofPath, paint);

    final wallPath = Path()
      ..moveTo(6, size.height * 0.42)
      ..lineTo(6, size.height - 2)
      ..lineTo(size.width - 6, size.height - 2)
      ..lineTo(size.width - 6, size.height * 0.42);
    canvas.drawPath(wallPath, paint);

    final personPaint = Paint()
      ..color = const Color(0xFFC87941)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(cx - 9, size.height * 0.57), 3.5, personPaint);
    final leftBody = Path()
      ..moveTo(cx - 16, size.height - 5)
      ..quadraticBezierTo(cx - 9, size.height * 0.73, cx - 2, size.height - 5);
    canvas.drawPath(leftBody, paint..style = PaintingStyle.stroke);

    canvas.drawCircle(Offset(cx + 9, size.height * 0.57), 3.5, personPaint);
    final rightBody = Path()
      ..moveTo(cx + 2, size.height - 5)
      ..quadraticBezierTo(cx + 9, size.height * 0.73, cx + 16, size.height - 5);
    canvas.drawPath(rightBody, paint..style = PaintingStyle.stroke);
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
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(4, size.height * 0.35, size.width - 8, size.height * 0.65),
      paint,
    );

    final roofPath = Path()
      ..moveTo(size.width / 2, 2)
      ..lineTo(size.width - 4, size.height * 0.35)
      ..lineTo(4, size.height * 0.35)
      ..close();
    canvas.drawPath(roofPath, paint);

    final windowSize = size.width * 0.13;
    for (final w in [
      Offset(size.width * 0.28, size.height * 0.5),
      Offset(size.width * 0.65, size.height * 0.5),
      Offset(size.width * 0.28, size.height * 0.68),
      Offset(size.width * 0.65, size.height * 0.68),
    ]) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: w, width: windowSize, height: windowSize),
          const Radius.circular(2),
        ),
        fillPaint,
      );
    }

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width / 2 - windowSize * 0.75,
          size.height * 0.76,
          windowSize * 1.5,
          size.height * 0.24,
        ),
        const Radius.circular(2),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(_BuildingIconPainter oldDelegate) => false;
}