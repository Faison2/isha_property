import 'package:flutter/material.dart';

// ── Brand colours (tenant-side) ──────────────────────────────────────────────
class _C {
  static const bg        = Color(0xFFF5F4FB);
  static const primary   = Color(0xFF7B6FD0);
  static const amber     = Color(0xFFC87941);
  static const textDark  = Color(0xFF1A1A2E);
  static const textGrey  = Color(0xFF8A8FA8);
  static const white     = Colors.white;
  static const cardBg    = Colors.white;
}

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
            // ── Top bar ─────────────────────────────────────────────────────
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
                          right: 0, top: 0,
                          child: Container(
                            width: 8, height: 8,
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

            // ── Greeting ────────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hi, Sarah ',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: _C.textDark,
                          ),
                        ),
                        const Text('👋', style: TextStyle(fontSize: 24)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Find your next home',
                      style: TextStyle(fontSize: 14, color: _C.textGrey),
                    ),
                  ],
                ),
              ),
            ),

            // ── Search bar ──────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: _C.white,
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
                      width: 48, height: 48,
                      decoration: BoxDecoration(
                        color: _C.white,
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

            // ── Hero banner ─────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: SizedBox(
                  height: 168,
                  child: Stack(
                    children: [
                      PageView(
                        controller: _bannerCtrl,
                        onPageChanged: (i) => setState(() => _bannerPage = i),
                        children: [
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
                      // dots
                      Positioned(
                        bottom: 10,
                        left: 0, right: 0,
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

            // ── Browse by Category ───────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Browse by Category',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _C.textDark),
                    ),
                    Text('See all', style: TextStyle(fontSize: 13, color: _C.primary, fontWeight: FontWeight.w600)),
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
                      _CategoryChip(icon: Icons.apartment_rounded,    label: 'Apartments', color: Color(0xFFEEECFA)),
                      _CategoryChip(icon: Icons.house_rounded,         label: 'Houses',    color: Color(0xFFFFF0E6)),
                      _CategoryChip(icon: Icons.bed_rounded,           label: 'Rooms',     color: Color(0xFFE9F5EE)),
                      _CategoryChip(icon: Icons.people_rounded,        label: 'Shared',    color: Color(0xFFFFF7E0)),
                    ],
                  ),
                ),
              ),
            ),

            // ── Recommended for you ─────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recommended for you',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _C.textDark),
                    ),
                    Text('See all', style: TextStyle(fontSize: 13, color: _C.primary, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),

            // ── Property cards ──────────────────────────────────────────────
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
                // bottom padding so last card isn't hidden by nav bar
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
//  Hero banner slide
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
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFDDDAF5),
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          // text side
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 8, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    headline,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: _C.textDark,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    sub,
                    style: const TextStyle(fontSize: 12, color: _C.textGrey, height: 1.4),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _C.textDark,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                      textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                    child: Text(buttonLabel),
                  ),
                ],
              ),
            ),
          ),
          // image side
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: double.infinity,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFFCBC7EF),
                  child: const Icon(Icons.home_work_rounded, size: 60, color: Colors.white54),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
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
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _C.textDark)),
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
          // thumbnail
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
                width: 110, height: 110,
                color: const Color(0xFFDDDAF5),
                child: const Icon(Icons.apartment_rounded, size: 36, color: Colors.white54),
              ),
            ),
          ),
          // details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _C.textDark),
                        ),
                      ),
                      const Icon(Icons.favorite_border_rounded, size: 20, color: _C.textGrey),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(location, style: const TextStyle(fontSize: 11, color: _C.textGrey)),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: price,
                          style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w800, color: _C.textDark,
                          ),
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
        Text(label, style: const TextStyle(fontSize: 10, color: _C.textGrey, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
