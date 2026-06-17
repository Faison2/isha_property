import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  static const Color _primary = Color(0xFFC87941);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0A00),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.15),
                        width: 0.5,
                      ),
                    ),
                    child: Icon(
                      Icons.settings_outlined,
                      size: 20,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildProfileHeader(),
              const SizedBox(height: 24),
              _buildMenuSection('Account', [
                _MenuItem(Icons.person_outline_rounded, 'Personal Info'),
                _MenuItem(Icons.home_work_rounded, 'My Properties'),
                _MenuItem(Icons.notifications_outlined, 'Notifications'),
                _MenuItem(Icons.payments_outlined, 'Payment Methods'),
              ]),
              const SizedBox(height: 20),
              _buildMenuSection('Support', [
                _MenuItem(Icons.help_outline_rounded, 'Help Center'),
                _MenuItem(Icons.chat_outlined, 'Contact Support'),
                _MenuItem(Icons.description_outlined, 'Terms of Service'),
                _MenuItem(Icons.privacy_tip_outlined, 'Privacy Policy'),
              ]),
              const SizedBox(height: 20),
              _buildLogoutButton(context),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.15),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _primary.withOpacity(0.15),
              border: Border.all(
                color: _primary.withOpacity(0.4),
                width: 2,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.person_rounded,
                size: 32,
                color: _primary.withOpacity(0.7),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'john.doe@email.com',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.55),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Landlord',
                    style: TextStyle(
                      fontSize: 11,
                      color: _primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.edit_rounded,
            size: 18,
            color: Colors.white.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(String title, List<_MenuItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.4),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
              width: 0.5,
            ),
          ),
          child: Column(
            children: List.generate(items.length, (i) {
              final isLast = i == items.length - 1;
              return Column(
                children: [
                  _MenuRow(item: items[i]),
                  if (!isLast)
                    Divider(
                      height: 0,
                      color: Colors.white.withOpacity(0.05),
                      thickness: 0.5,
                      indent: 52,
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.red.withOpacity(0.2),
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout_rounded,
              size: 18,
              color: Colors.red.withOpacity(0.7),
            ),
            const SizedBox(width: 8),
            Text(
              'Log Out',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.red.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;

  const _MenuItem(this.icon, this.label);
}

class _MenuRow extends StatelessWidget {
  final _MenuItem item;

  const _MenuRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(
            item.icon,
            size: 22,
            color: Colors.white.withOpacity(0.5),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              item.label,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            size: 20,
            color: Colors.white.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
