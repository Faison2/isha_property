import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'explore_tab.dart';
import 'chat_tab.dart';
import 'profile_tab.dart';

// ── Brand colours ─────────────────────────────────────────────────────────────
class _C {
  static const bg       = Color(0xFFF5F4FB);
  static const primary  = Color(0xFF7B6FD0);
  static const amber    = Color(0xFFC87941);
  static const textDark = Color(0xFF1A1A2E);
  static const textGrey = Color(0xFF8A8FA8);
  static const cardBg   = Colors.white;
  static const glass    = Color(0x1AFFFFFF);
  static const glassBdr = Color(0x33FFFFFF);
  static const navIcon  = Color(0xFF555555);
}

// ═════════════════════════════════════════════════════════════════════════════
//  DASHBOARD (shell)
// ═════════════════════════════════════════════════════════════════════════════
class TenantDashboard extends StatefulWidget {
  const TenantDashboard({super.key});

  @override
  State<TenantDashboard> createState() => _TenantDashboardState();
}

class _TenantDashboardState extends State<TenantDashboard> {
  int _currentIndex = 0;

  late final List<Widget> _tabs = [
    const TenantHomeTab(),
    const ExploreTab(),
    const TenantChatTab(),
    const TenantProfileTab(),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 280),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: KeyedSubtree(
          key: ValueKey(_currentIndex),
          child: _tabs[_currentIndex],
        ),
      ),
      bottomNavigationBar: _GlassNav(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Glass bottom nav
// ─────────────────────────────────────────────────────────────────────────────
class _GlassNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const _GlassNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, bottom + 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            height: 68,
            decoration: BoxDecoration(
              color: _C.glass,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: _C.glassBdr, width: 1),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.18),
                  const Color(0xFF1A0D3D),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(icon: Icons.home_rounded,        label: 'Home',     isActive: currentIndex == 0, onTap: () => onTap(0)),
                _NavItem(icon: Icons.search_rounded,      label: 'Explore',  isActive: currentIndex == 1, onTap: () => onTap(1)),
                _NavItem(icon: Icons.chat_bubble_rounded, label: 'Messages', isActive: currentIndex == 2, badge: '2', onTap: () => onTap(2)),
                _NavItem(icon: Icons.person_rounded,      label: 'Profile',  isActive: currentIndex == 3, onTap: () => onTap(3)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final String? badge;
  final VoidCallback onTap;
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    this.badge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 72,
        height: 68,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: isActive ? _C.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: isActive
                        ? [BoxShadow(color: _C.primary.withOpacity(0.35), blurRadius: 12, offset: const Offset(0, 2))]
                        : null,
                  ),
                  child: Icon(icon, size: 22, color: isActive ? Colors.white : _C.navIcon),
                ),
                if (badge != null)
                  Positioned(
                    top: -4,
                    right: -2,
                    child: Container(
                      width: 17,
                      height: 17,
                      decoration: const BoxDecoration(color: _C.primary, shape: BoxShape.circle),
                      child: Center(
                        child: Text(badge!,
                            style: const TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 220),
              style: TextStyle(
                fontSize: 10,
                color: isActive ? _C.primary : _C.navIcon,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  HOME TAB
// ═════════════════════════════════════════════════════════════════════════════
class TenantHomeTab extends StatefulWidget {
  const TenantHomeTab({super.key});
  @override
  State<TenantHomeTab> createState() => _TenantHomeTabState();
}

class _TenantHomeTabState extends State<TenantHomeTab> {
  int _bannerPage = 0;
  final PageController _bannerCtrl = PageController();

  @override
  void dispose() {
    _bannerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // ── Top bar ───────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  children: [
                    const Icon(Icons.menu_rounded, size: 26, color: _C.textDark),
                    const Spacer(),
                    Stack(
                      children: [
                        const Icon(Icons.notifications_outlined, size: 26, color: _C.textDark),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF4D4D),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ── Search bar ────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Search location, property or landlord',
                            hintStyle: TextStyle(color: _C.textGrey, fontSize: 13),
                            prefixIcon: Icon(Icons.search_rounded, color: _C.textGrey, size: 20),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.tune_rounded, color: _C.textDark, size: 20),
                    ),
                  ],
                ),
              ),
            ),

            // ── Hero banner ───────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: SizedBox(
                  height: 210,
                  child: Stack(
                    children: [
                      PageView(
                        controller: _bannerCtrl,
                        onPageChanged: (i) => setState(() => _bannerPage = i),
                        children: const [
                          _HeroBannerSlide(
                            headline: 'Find a place\nyou\'ll love to live',
                            sub: 'Browse verified listings\nnear you',
                            buttonLabel: 'Explore Now',
                            imagePath: 'assets/images/banner1.jpg',
                          ),
                          _HeroBannerSlide(
                            headline: 'Premium rooms\nat great prices',
                            sub: 'Hundreds of options\nin your city',
                            buttonLabel: 'Browse Rooms',
                            imagePath: 'assets/images/banner2.jpg',
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(2, (i) {
                            final active = i == _bannerPage;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: active ? 18 : 6,
                              height: 6,
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                color: active ? _C.primary : Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Browse by Category ────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Browse by Category',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _C.textDark)),
                    Text('See all',
                        style: TextStyle(fontSize: 13, color: _C.primary, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 90,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: const [
                      _CategoryChip(icon: Icons.apartment_rounded, label: 'Apartments', color: Color(0xFFEEECFA)),
                      _CategoryChip(icon: Icons.house_rounded,      label: 'Houses',    color: Color(0xFFFFF0E6)),
                      _CategoryChip(icon: Icons.bed_rounded,        label: 'Rooms',     color: Color(0xFFE9F5EE)),
                      _CategoryChip(icon: Icons.people_rounded,     label: 'Shared',    color: Color(0xFFFFF7E0)),
                    ],
                  ),
                ),
              ),
            ),

            // ── Recommended for you ───────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Recommended for you',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _C.textDark)),
                    Text('See all',
                        style: TextStyle(fontSize: 13, color: _C.primary, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),

            // ── Property cards ────────────────────────────────────────────
            SliverList(
              delegate: SliverChildListDelegate([
                const _PropertyCard(
                  imagePath: 'assets/images/property1.jpg',
                  title: '2BHK Apartment',
                  location: 'Sunset Road, Nairobi',
                  price: 'KES 35,000',
                  beds: '2 Bed',
                  baths: '2 Bath',
                  tag: 'Furnished',
                ),
                const _PropertyCard(
                  imagePath: 'assets/images/property2.jpg',
                  title: 'Spacious Room',
                  location: 'Westlands, Nairobi',
                  price: 'KES 12,000',
                  beds: '1 Bed',
                  baths: '1 Bath',
                  tag: 'Self-contained',
                ),
                const _PropertyCard(
                  imagePath: 'assets/images/property3.jpg',
                  title: 'Modern Studio',
                  location: 'Kilimani, Nairobi',
                  price: 'KES 22,000',
                  beds: '1 Bed',
                  baths: '1 Bath',
                  tag: 'Furnished',
                ),
                const SizedBox(height: 100),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Hero banner slide — slanted gradient design
// ─────────────────────────────────────────────────────────────────────────────
class _HeroBannerSlide extends StatelessWidget {
  final String headline;
  final String sub;
  final String buttonLabel;
  final String imagePath;

  const _HeroBannerSlide({
    required this.headline,
    required this.sub,
    required this.buttonLabel,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 210,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Rich diagonal gradient background ────────────────────────
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.45, 0.75, 1.0],
                  colors: [
                    Color(0xFF4A3FA8), // deep indigo
                    Color(0xFF7B6FD0), // brand purple
                    Color(0xFFAA8FE0), // soft violet
                    Color(0xFFD4A8F0), // lavender fade
                  ],
                ),
              ),
            ),

            // ── Decorative circles (depth / atmosphere) ──────────────────
            Positioned(
              top: -30,
              right: 100,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.07),
                ),
              ),
            ),
            Positioned(
              bottom: -20,
              right: 60,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: -10,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.06),
                ),
              ),
            ),

            // ── Image panel with slanted clip on left edge ───────────────
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: 170,
              child: ClipPath(
                clipper: _SlantClipper(),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF9B8FE8), Color(0xFF6A5FC1)],
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.home_work_rounded, size: 56, color: Colors.white38),
                    ),
                  ),
                ),
              ),
            ),

            // ── Gradient fade overlay on image (blends into bg) ──────────
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: 200,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.0, 0.35, 1.0],
                    colors: [
                      Color(0xFF7B6FD0), // matches mid gradient — seamless blend
                      Colors.transparent,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // ── Text content ─────────────────────────────────────────────
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              right: 140,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 8, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // eyebrow pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.25), width: 0.8),
                      ),
                      child: const Text(
                        '✦  Featured',
                        style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w600, letterSpacing: 0.5),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      headline,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.25,
                        shadows: [Shadow(color: Color(0x40000000), blurRadius: 8)],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      sub,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.75),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 14),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.18),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          buttonLabel,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF4A3FA8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Clips the image panel so its left edge is a diagonal slant
class _SlantClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(36, 0);       // slant starts 36px in from left at top
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height); // bottom-left flush
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_SlantClipper old) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
//  Category chip
// ─────────────────────────────────────────────────────────────────────────────
class _CategoryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _CategoryChip({required this.icon, required this.label, required this.color});

  Color get _iconColor {
    if (color == const Color(0xFFEEECFA)) return const Color(0xFF7B6FD0);
    if (color == const Color(0xFFFFF0E6)) return const Color(0xFFC87941);
    if (color == const Color(0xFFE9F5EE)) return const Color(0xFF3B9A5A);
    return const Color(0xFFC8A000);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 26, color: _iconColor),
          const SizedBox(height: 6),
          Text(label,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _C.textDark)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Property listing card
// ─────────────────────────────────────────────────────────────────────────────
class _PropertyCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String location;
  final String price;
  final String beds;
  final String baths;
  final String tag;

  const _PropertyCard({
    required this.imagePath,
    required this.title,
    required this.location,
    required this.price,
    required this.beds,
    required this.baths,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      decoration: BoxDecoration(
        color: _C.cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Image.asset(
              imagePath,
              width: 110,
              height: 110,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 110,
                height: 110,
                color: const Color(0xFFDDDAF5),
                child: const Icon(Icons.apartment_rounded, size: 36, color: Colors.white54),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(title,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700, color: _C.textDark)),
                      ),
                      const Icon(Icons.favorite_border_rounded, size: 20, color: _C.textGrey),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(location,
                      style: const TextStyle(fontSize: 11, color: _C.textGrey)),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: price,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800, color: _C.textDark),
                        ),
                        const TextSpan(
                          text: ' / month',
                          style: TextStyle(fontSize: 11, color: _C.textGrey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _Pill(icon: Icons.bed_rounded, label: beds),
                      const SizedBox(width: 8),
                      _Pill(icon: Icons.bathtub_outlined, label: baths),
                      const SizedBox(width: 8),
                      _Pill(icon: Icons.chair_rounded, label: tag),
                    ],
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

class _Pill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Pill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 12, color: _C.textGrey),
        const SizedBox(width: 3),
        Text(label,
            style: const TextStyle(
                fontSize: 10, color: _C.textGrey, fontWeight: FontWeight.w500)),
      ],
    );
  }
}