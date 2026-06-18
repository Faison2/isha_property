import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'add_property.dart';
import 'properties_tab.dart';
import 'chat_tab.dart';
import 'profile_tab.dart';

// ── Color palette — warm light theme (home) + glass nav ─────────────────────
class _C {
  // Home tab / global bg
  static const bg           = Color(0xFFFAF5F0); // warm cream
  static const bgCard       = Color(0xFFFFFFFF); // white cards
  static const primary      = Color(0xFFB5622A); // warm terracotta
  static const primaryLo    = Color(0x1AB5622A); // primary 10%
  static const headerCard   = Color(0xFFB5622A); // big stats card
  static const text         = Color(0xFF1A1A1A);
  static const textSub      = Color(0xFF888888);
  static const textLight    = Color(0xFFAAAAAA);
  static const divider      = Color(0xFFF0EBE6);
  static const tagOccupied     = Color(0xFFE8F5EE);
  static const tagOccupiedText = Color(0xFF2E7D52);
  static const tagVacant       = Color(0xFFFFF3E0);
  static const tagVacantText   = Color(0xFFB5622A);

  // Glass nav (original)
  static const glass    = Color(0x1AFFFFFF); // white 10%
  static const glassBdr = Color(0x33FFFFFF); // white 20%
  static const white70  = Color(0xB3FFFFFF);
  static const white40  = Color(0xFF555555); // dark gray for inactive nav items
}

class LandlordDashboard extends StatefulWidget {
  const LandlordDashboard({super.key});

  @override
  State<LandlordDashboard> createState() => _LandlordDashboardState();
}

class _LandlordDashboardState extends State<LandlordDashboard> {
  int _currentIndex = 0;

  late final List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
      const _HomeTab(),
      const PropertiesTab(),
      const ChatTab(),
      const ProfileTab(),
    ];
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
      extendBody: true, // lets content slide under the glass nav
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 280),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: KeyedSubtree(
          key: ValueKey(_currentIndex),
          child: _tabs[_currentIndex],
        ),
      ),
      bottomNavigationBar: _LiquidGlassNav(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

// ── Liquid Glass Bottom Nav (original, unchanged) ────────────────────────────

class _LiquidGlassNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _LiquidGlassNav({
    required this.currentIndex,
    required this.onTap,
  });

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
                  const Color(0xFF2D1500),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _GlassNavItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  isActive: currentIndex == 0,
                  onTap: () => onTap(0),
                ),
                _GlassNavItem(
                  icon: Icons.apartment_rounded,
                  label: 'Properties',
                  isActive: currentIndex == 1,
                  onTap: () => onTap(1),
                ),
                _GlassNavItem(
                  icon: Icons.chat_bubble_rounded,
                  label: 'Messages',
                  isActive: currentIndex == 2,
                  badge: '3',
                  onTap: () => onTap(2),
                ),
                _GlassNavItem(
                  icon: Icons.person_rounded,
                  label: 'Profile',
                  isActive: currentIndex == 3,
                  onTap: () => onTap(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final String? badge;
  final VoidCallback onTap;

  const _GlassNavItem({
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
                        ? [
                      BoxShadow(
                        color: _C.primary.withOpacity(0.35),
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: const Offset(0, 2),
                      ),
                    ]
                        : null,
                  ),
                  child: Icon(
                    icon,
                    size: 22,
                    color: isActive ? Colors.white : _C.white40,
                  ),
                ),
                if (badge != null)
                  Positioned(
                    top: -4,
                    right: -2,
                    child: Container(
                      width: 17,
                      height: 17,
                      decoration: const BoxDecoration(
                        color: _C.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          badge!,
                          style: const TextStyle(
                            fontSize: 9,
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
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
                color: isActive ? _C.primary : _C.white40,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                letterSpacing: isActive ? 0.2 : 0,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Home Tab ─────────────────────────────────────────────────────────────────

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 110), // clear the glass nav
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildStatsCard(context),
              const SizedBox(height: 24),
              _buildRecentActivity(),
              const SizedBox(height: 24),
              _buildMyProperties(),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu_rounded, color: _C.text, size: 26),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(Icons.notifications_outlined, color: _C.text, size: 26),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(color: _C.primary, shape: BoxShape.circle),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: _C.headerCard,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hi, James',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
            ),
            const SizedBox(height: 2),
            Text(
              'Manage your properties',
              style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.75)),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Properties', style: TextStyle(fontSize: 12, color: Colors.white70)),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AddPropertyScreen()),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Add Property',
                            style: TextStyle(fontSize: 12, color: _C.primary, fontWeight: FontWeight.w700)),
                        const SizedBox(width: 4),
                        Icon(Icons.add_circle_outline_rounded, size: 14, color: _C.primary),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            const Text('8',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white)),
            const SizedBox(height: 16),
            Divider(color: Colors.white.withOpacity(0.2), height: 1),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _StatCell(value: '6', label: 'Listed')),
                _VertDivider(),
                Expanded(child: _StatCell(value: '4', label: 'Occupied')),
                _VertDivider(),
                Expanded(child: _StatCell(value: '2', label: 'Vacant')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(title: 'Recent Activity', onSeeAll: () {}),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: _C.bgCard,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 2)),
              ],
            ),
            child: Column(
              children: [
                _ActivityTile(
                  avatarColor: const Color(0xFFD4896A),
                  initials: 'SW',
                  title: 'New inquiry for ',
                  boldPart: '2BHK Apartment',
                  subtitle: 'by Sarah W.',
                  time: '10 min ago',
                  actionIcon: Icons.chat_bubble_outline_rounded,
                  actionColor: _C.primary,
                  isLast: false,
                ),
                _ActivityTile(
                  avatarColor: const Color(0xFF8B6B4A),
                  initials: 'MK',
                  title: 'Viewing scheduled\n',
                  boldPart: '1BHK Apartment by Mark K.',
                  subtitle: '',
                  time: '2 hr ago',
                  actionIcon: Icons.calendar_today_rounded,
                  actionColor: _C.primary,
                  isLast: false,
                ),
                _ActivityTile(
                  avatarColor: const Color(0xFF6B8FAB),
                  initials: 'JD',
                  title: 'Payment received\n',
                  boldPart: 'From John D.',
                  subtitle: '',
                  time: '1 day ago',
                  actionIcon: Icons.check_circle_outline_rounded,
                  actionColor: Colors.green,
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyProperties() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(title: 'My Properties', onSeeAll: () {}),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: _C.bgCard,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 2)),
              ],
            ),
            child: const Column(
              children: [
                _PropertyTile(
                  title: '2BHK Apartment',
                  location: 'Sunset Road, Nairobi',
                  price: 'KES 35,000 / month',
                  status: 'Occupied',
                  isLast: false,
                ),
                _PropertyTile(
                  title: '1BHK Apartment',
                  location: 'Westlands, Nairobi',
                  price: 'KES 22,000 / month',
                  status: 'Vacant',
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Shared sub-widgets ───────────────────────────────────────────────────────

class _StatCell extends StatelessWidget {
  final String value;
  final String label;
  const _StatCell({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
        const SizedBox(height: 3),
        Text(label,
            style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.75))),
      ],
    );
  }
}

class _VertDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 36,
      color: Colors.white.withOpacity(0.2),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;
  const _SectionHeader({required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: _C.text)),
        GestureDetector(
          onTap: onSeeAll,
          child: const Text('See all',
              style: TextStyle(fontSize: 13, color: _C.primary, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final Color avatarColor;
  final String initials;
  final String title;
  final String boldPart;
  final String subtitle;
  final String time;
  final IconData actionIcon;
  final Color actionColor;
  final bool isLast;

  const _ActivityTile({
    required this.avatarColor,
    required this.initials,
    required this.title,
    required this.boldPart,
    required this.subtitle,
    required this.time,
    required this.actionIcon,
    required this.actionColor,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(color: avatarColor, shape: BoxShape.circle),
                child: Center(
                  child: Text(initials,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 14, color: _C.text, height: 1.4),
                        children: [
                          TextSpan(text: title),
                          TextSpan(
                              text: boldPart,
                              style: const TextStyle(fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    if (subtitle.isNotEmpty)
                      Text(subtitle,
                          style: const TextStyle(fontSize: 12, color: _C.textSub)),
                    const SizedBox(height: 3),
                    Text(time, style: const TextStyle(fontSize: 11, color: _C.textLight)),
                  ],
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: actionColor.withOpacity(0.10),
                  shape: BoxShape.circle,
                ),
                child: Icon(actionIcon, size: 18, color: actionColor),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(height: 1, indent: 70, endIndent: 16, color: _C.divider),
      ],
    );
  }
}

class _PropertyTile extends StatelessWidget {
  final String title;
  final String location;
  final String price;
  final String status;
  final bool isLast;

  const _PropertyTile({
    required this.title,
    required this.location,
    required this.price,
    required this.status,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final isOccupied = status == 'Occupied';
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 72,
                  height: 72,
                  color: const Color(0xFFE8DDD5),
                  child: Icon(Icons.apartment_rounded,
                      size: 32, color: _C.primary.withOpacity(0.4)),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(title,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700, color: _C.text)),
                        ),
                        Icon(Icons.more_vert_rounded, color: _C.textLight, size: 20),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(location,
                        style: const TextStyle(fontSize: 12, color: _C.textSub)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(price,
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600, color: _C.text)),
                        const Spacer(),
                        Container(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isOccupied ? _C.tagOccupied : _C.tagVacant,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isOccupied
                                  ? _C.tagOccupiedText
                                  : _C.tagVacantText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(height: 1, indent: 14, endIndent: 14, color: _C.divider),
      ],
    );
  }
}