import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'landing_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _pulseController;
  late AnimationController _shimmerController;

  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;
  late Animation<Offset> _logoSlide;
  late Animation<Offset> _taglineSlide;
  late Animation<double> _ringScale;
  late Animation<double> _ringFade;
  late Animation<double> _pulseAnim;
  late Animation<double> _shimmerAnim;
  late Animation<double> _loadingAnim;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    // Main entrance animation
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    // Pulse ring animation
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // Shimmer animation
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _fadeAnim = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    _scaleAnim = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _logoSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _taglineSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.3, 0.9, curve: Curves.easeOut),
    ));

    _ringScale = Tween<double>(begin: 0.6, end: 1.8).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeOut,
      ),
    );

    _ringFade = Tween<double>(begin: 0.5, end: 0.0).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeOut,
      ),
    );

    _pulseAnim = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    _shimmerAnim = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _shimmerController,
        curve: Curves.easeInOut,
      ),
    );

    _loadingAnim = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    );

    // Start animations
    _mainController.forward();

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        _pulseController.repeat(reverse: true);
        _shimmerController.repeat();
      }
    });

    // Navigate after 3.2s
    Future.delayed(const Duration(milliseconds: 3200), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const LandingPage(),
            transitionsBuilder: (_, anim, __, child) => FadeTransition(
              opacity: anim,
              child: child,
            ),
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _pulseController.dispose();
    _shimmerController.dispose();
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
          // Hero image background
          Image.asset(
            'assets/images/hero.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),

          // Multi-stop dark overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.4, 0.7, 1.0],
                colors: [
                  Color(0xBB000000),
                  Color(0x77000000),
                  Color(0xAA000000),
                  Color(0xDD000000),
                ],
              ),
            ),
          ),

          // Warm amber bottom glow
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: size.height * 0.4,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0x55C87941),
                    Color(0x00C87941),
                  ],
                ),
              ),
            ),
          ),

          // Top-left ambient glow
          Positioned(
            top: -80,
            left: -80,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFC87941).withOpacity(0.18),
                    const Color(0xFFC87941).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          // Bottom-right ambient glow
          Positioned(
            bottom: -60,
            right: -60,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFC87941).withOpacity(0.14),
                    const Color(0xFFC87941).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          // ── Main content ──
          Center(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── Logo badge with pulse ring ──
                  SlideTransition(
                    position: _logoSlide,
                    child: ScaleTransition(
                      scale: _scaleAnim,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer pulse ring
                          AnimatedBuilder(
                            animation: _pulseController,
                            builder: (_, __) => Transform.scale(
                              scale: _ringScale.value,
                              child: Opacity(
                                opacity: _ringFade.value,
                                child: Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFFC87941),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Inner glow ring
                          AnimatedBuilder(
                            animation: _pulseController,
                            builder: (_, __) => Transform.scale(
                              scale: _pulseAnim.value,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.05),
                                  border: Border.all(
                                    color: const Color(0xFFC87941)
                                        .withOpacity(0.4),
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Logo container
                          Container(
                            width: 84,
                            height: 84,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.08),
                              border: Border.all(
                                color:
                                const Color(0xFFC87941).withOpacity(0.5),
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: CustomPaint(
                                size: const Size(42, 38),
                                painter: _HouseLogoPainter(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Brand name with shimmer ──
                  SlideTransition(
                    position: _logoSlide,
                    child: AnimatedBuilder(
                      animation: _shimmerController,
                      builder: (_, child) {
                        return ShaderMask(
                          shaderCallback: (bounds) {
                            return LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [
                                (_shimmerAnim.value - 0.3).clamp(0.0, 1.0),
                                _shimmerAnim.value.clamp(0.0, 1.0),
                                (_shimmerAnim.value + 0.3).clamp(0.0, 1.0),
                              ],
                              colors: const [
                                Colors.white,
                                Color(0xFFFFDDB8),
                                Colors.white,
                              ],
                            ).createShader(bounds);
                          },
                          child: child,
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Stay',
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              letterSpacing: -1,
                            ),
                          ),
                          Text(
                            'Connect',
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFC87941),
                              letterSpacing: -1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ── Tagline pill ──
                  SlideTransition(
                    position: _taglineSlide,
                    child: FadeTransition(
                      opacity: _loadingAnim,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.15),
                            width: 0.5,
                          ),
                        ),
                        child: const Text(
                          'Find  ·  Connect  ·  Stay',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                            letterSpacing: 1.8,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  // ── Loading indicator ──
                  SlideTransition(
                    position: _taglineSlide,
                    child: FadeTransition(
                      opacity: _loadingAnim,
                      child: Column(
                        children: [
                          // Animated loading bar
                          SizedBox(
                            width: 140,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                backgroundColor:
                                Colors.white.withOpacity(0.1),
                                valueColor:
                                const AlwaysStoppedAnimation<Color>(
                                  Color(0xFFC87941),
                                ),
                                minHeight: 3,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Loading your experience...',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.35),
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Bottom version tag ──
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _loadingAnim,
              child: Column(
                children: [
                  Text(
                    'v1.0.0',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.2),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Container(
                      width: 120,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(3),
                      ),
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

    // Roof
    final roofPath = Path()
      ..moveTo(cx, 2)
      ..lineTo(size.width - 2, size.height * 0.42)
      ..lineTo(2, size.height * 0.42)
      ..close();
    canvas.drawPath(roofPath, paint);

    // Walls
    final wallPath = Path()
      ..moveTo(6, size.height * 0.42)
      ..lineTo(6, size.height - 2)
      ..lineTo(size.width - 6, size.height - 2)
      ..lineTo(size.width - 6, size.height * 0.42);
    canvas.drawPath(wallPath, paint);

    final personPaint = Paint()
      ..color = const Color(0xFFC87941)
      ..style = PaintingStyle.fill;

    // Left person
    canvas.drawCircle(
      Offset(cx - 9, size.height * 0.57),
      3.5,
      personPaint,
    );
    final leftBody = Path()
      ..moveTo(cx - 16, size.height - 5)
      ..quadraticBezierTo(
        cx - 9, size.height * 0.73,
        cx - 2, size.height - 5,
      );
    canvas.drawPath(leftBody, paint..style = PaintingStyle.stroke);

    // Right person
    canvas.drawCircle(
      Offset(cx + 9, size.height * 0.57),
      3.5,
      personPaint,
    );
    final rightBody = Path()
      ..moveTo(cx + 2, size.height - 5)
      ..quadraticBezierTo(
        cx + 9, size.height * 0.73,
        cx + 16, size.height - 5,
      );
    canvas.drawPath(rightBody, paint..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(_HouseLogoPainter oldDelegate) => false;
}