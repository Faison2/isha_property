import 'package:flutter/material.dart';

// ── Palette — exact mirror of LandlordDashboard ───────────────────────────────
class _C {
  static const bg          = Color(0xFFFAF5F0);
  static const bgCard      = Color(0xFFFFFFFF);
  static const primary     = Color(0xFFB5622A);
  static const primaryLo   = Color(0x1AB5622A);
  static const text        = Color(0xFF1A1A1A);
  static const textSub     = Color(0xFF888888);
  static const textLight   = Color(0xFFAAAAAA);
  static const divider     = Color(0xFFF0EBE6);
  static const inputBg     = Color(0xFFF5EFE9);
  static const inputBorder = Color(0xFFE4D8CE);
  static const tagOccupied     = Color(0xFFE8F5EE);
  static const tagOccupiedText = Color(0xFF2E7D52);
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ────────────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: _C.text,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Manage your account',
                        style: TextStyle(fontSize: 13, color: _C.textSub),
                      ),
                    ],
                  ),
                  _IconBtn(icon: Icons.settings_outlined, onTap: () {}),
                ],
              ),

              const SizedBox(height: 22),

              // ── Profile header card ───────────────────────────────────────
              _buildProfileCard(),

              const SizedBox(height: 20),

              // ── Stats row ─────────────────────────────────────────────────
              _buildStatsRow(),

              const SizedBox(height: 24),

              // ── Menu sections ─────────────────────────────────────────────
              _buildMenuSection('Account', [
                _MenuItem(Icons.person_outline_rounded, 'Personal Info'),
                _MenuItem(Icons.home_work_rounded,      'My Properties'),
                _MenuItem(Icons.notifications_outlined, 'Notifications'),
                _MenuItem(Icons.payments_outlined,      'Payment Methods'),
              ]),

              const SizedBox(height: 20),

              _buildMenuSection('Support', [
                _MenuItem(Icons.help_outline_rounded,    'Help Center'),
                _MenuItem(Icons.chat_outlined,           'Contact Support'),
                _MenuItem(Icons.description_outlined,    'Terms of Service'),
                _MenuItem(Icons.privacy_tip_outlined,    'Privacy Policy'),
              ]),

              const SizedBox(height: 28),

              // ── Log out ───────────────────────────────────────────────────
              _buildLogoutButton(context),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  // ── Profile card ──────────────────────────────────────────────────────────

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _C.bgCard,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Stack(
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _C.primaryLo,
                  border: Border.all(color: _C.primary.withOpacity(0.30), width: 2),
                ),
                child: const Icon(Icons.person_rounded, size: 34, color: _C.primary),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: _C.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: _C.bgCard, width: 2),
                  ),
                  child: const Icon(Icons.edit_rounded, size: 11, color: Colors.white),
                ),
              ),
            ],
          ),

          const SizedBox(width: 16),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: _C.text,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'john.doe@email.com',
                  style: TextStyle(fontSize: 13, color: _C.textSub),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // Role tag
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _C.primaryLo,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Landlord',
                        style: TextStyle(
                          fontSize: 11,
                          color: _C.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Verified badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _C.tagOccupied,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.verified_rounded,
                              size: 11, color: _C.tagOccupiedText),
                          SizedBox(width: 3),
                          Text(
                            'Verified',
                            style: TextStyle(
                              fontSize: 11,
                              color: _C.tagOccupiedText,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Stats row ─────────────────────────────────────────────────────────────

  Widget _buildStatsRow() {
    return Container(
      decoration: BoxDecoration(
        color: _C.primary,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: _C.primary.withOpacity(0.28),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          _StatCell(value: '8',   label: 'Properties'),
          _VertDivider(),
          _StatCell(value: '4',   label: 'Occupied'),
          _VertDivider(),
          _StatCell(value: '4.8', label: 'Rating'),
        ],
      ),
    );
  }

  // ── Menu section ──────────────────────────────────────────────────────────

  Widget _buildMenuSection(String title, List<_MenuItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: _C.textLight,
              letterSpacing: 1.0,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: _C.bgCard,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: List.generate(items.length, (i) {
              final isLast = i == items.length - 1;
              return Column(
                children: [
                  _MenuRow(item: items[i]),
                  if (!isLast)
                    Divider(height: 1, indent: 54, endIndent: 16, color: _C.divider),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  // ── Logout button ─────────────────────────────────────────────────────────

  Widget _buildLogoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).popUntil((r) => r.isFirst),
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: _C.bgCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFFFDADA), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.logout_rounded, size: 18, color: Color(0xFFD63031)),
            SizedBox(width: 8),
            Text(
              'Log Out',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFFD63031),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Stat cell (inside terracotta banner) ──────────────────────────────────────

class _StatCell extends StatelessWidget {
  final String value;
  final String label;
  const _StatCell({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withOpacity(0.75),
              ),
            ),
          ],
        ),
      ),
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

// ── Small icon button (header) ────────────────────────────────────────────────

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _C.bgCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _C.inputBorder, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: _C.textSub),
      ),
    );
  }
}

// ── Menu data ─────────────────────────────────────────────────────────────────

class _MenuItem {
  final IconData icon;
  final String label;
  const _MenuItem(this.icon, this.label);
}

// ── Menu row ──────────────────────────────────────────────────────────────────

class _MenuRow extends StatelessWidget {
  final _MenuItem item;
  const _MenuRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _C.inputBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item.icon, size: 18, color: _C.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                item.label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: _C.text,
                ),
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                size: 20, color: _C.textLight),
          ],
        ),
      ),
    );
  }
}