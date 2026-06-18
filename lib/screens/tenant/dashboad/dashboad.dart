import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_tab.dart';
import 'explore_tab.dart';
import 'chat_tab.dart';
import 'profile_tab.dart';

class _C {
  static const bg           = Color(0xFFFAF5F0);
  static const primary      = Color(0xFF7B6FD0);
  static const glass        = Color(0x1AFFFFFF);
  static const glassBdr     = Color(0x33FFFFFF);
  static const white40      = Color(0xFF555555);
}

class TenantDashboard extends StatefulWidget {
  const TenantDashboard({super.key});

  @override
  State<TenantDashboard> createState() => _TenantDashboardState();
}

class _TenantDashboardState extends State<TenantDashboard> {
  int _currentIndex = 0;

  late final List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
      const TenantHomeTab(),
      const ExploreTab(),
      const TenantChatTab(),
      const TenantProfileTab(),
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
                _NavItem(icon: Icons.home_rounded, label: 'Home', isActive: currentIndex == 0, onTap: () => onTap(0)),
                _NavItem(icon: Icons.search_rounded, label: 'Explore', isActive: currentIndex == 1, onTap: () => onTap(1)),
                _NavItem(icon: Icons.chat_bubble_rounded, label: 'Messages', isActive: currentIndex == 2, badge: '2', onTap: () => onTap(2)),
                _NavItem(icon: Icons.person_rounded, label: 'Profile', isActive: currentIndex == 3, onTap: () => onTap(3)),
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
  const _NavItem({required this.icon, required this.label, required this.isActive, this.badge, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 72, height: 68,
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
                  child: Icon(icon, size: 22, color: isActive ? Colors.white : _C.white40),
                ),
                if (badge != null)
                  Positioned(
                    top: -4, right: -2,
                    child: Container(
                      width: 17, height: 17,
                      decoration: const BoxDecoration(color: _C.primary, shape: BoxShape.circle),
                      child: Center(child: Text(badge!, style: const TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w800))),
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
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
