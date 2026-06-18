import 'package:flutter/material.dart';
import 'add_property.dart';

// ── Palette — exact mirror of LandlordDashboard ───────────────────────────────
class _C {
  static const bg              = Color(0xFFFAF5F0);
  static const bgCard          = Color(0xFFFFFFFF);
  static const primary         = Color(0xFFB5622A);
  static const primaryLo       = Color(0x1AB5622A);
  static const text            = Color(0xFF1A1A1A);
  static const textSub         = Color(0xFF888888);
  static const textLight       = Color(0xFFAAAAAA);
  static const divider         = Color(0xFFF0EBE6);
  static const inputBg         = Color(0xFFF5EFE9);
  static const inputBorder     = Color(0xFFE4D8CE);

  // Status tags — same as dashboard
  static const tagActive       = Color(0xFFE8F5EE);
  static const tagActiveText   = Color(0xFF2E7D52);
  static const tagPending      = Color(0xFFFFF3E0);
  static const tagPendingText  = Color(0xFFB5622A);
  static const tagDraft        = Color(0xFFF3F3F3);
  static const tagDraftText    = Color(0xFF888888);
}

class PropertiesTab extends StatefulWidget {
  const PropertiesTab({super.key});

  @override
  State<PropertiesTab> createState() => _PropertiesTabState();
}

class _PropertiesTabState extends State<PropertiesTab> {
  String _filter = 'All';
  final List<String> _filters = ['All', 'Active', 'Pending', 'Draft'];

  final List<_PropertyItem> _properties = [
    _PropertyItem(
      title: 'Sunset Apartment',
      type: 'Apartment',
      price: '\$1,200/mo',
      location: 'Westside, NY',
      bedrooms: 2,
      bathrooms: 1,
      status: 'Active',
      imageCount: 4,
    ),
    _PropertyItem(
      title: 'Downtown Studio',
      type: 'Studio',
      price: '\$900/mo',
      location: 'Downtown, LA',
      bedrooms: 0,
      bathrooms: 1,
      status: 'Active',
      imageCount: 3,
    ),
    _PropertyItem(
      title: 'Garden House',
      type: 'House',
      price: '\$2,500/mo',
      location: 'Brooklyn, NY',
      bedrooms: 3,
      bathrooms: 2,
      status: 'Pending',
      imageCount: 6,
    ),
    _PropertyItem(
      title: 'Lakeside Condo',
      type: 'Condo',
      price: '\$1,800/mo',
      location: 'Lakeview, IL',
      bedrooms: 2,
      bathrooms: 2,
      status: 'Draft',
      imageCount: 2,
    ),
  ];

  List<_PropertyItem> get _filtered =>
      _filter == 'All' ? _properties : _properties.where((p) => p.status == _filter).toList();

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;

    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'My Properties',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: _C.text,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${_properties.length} properties listed',
                          style: const TextStyle(fontSize: 13, color: _C.textSub),
                        ),
                      ],
                    ),
                  ),
                  // Add button — same style as dashboard stats card button
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AddPropertyScreen()),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                      decoration: BoxDecoration(
                        color: _C.primary,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: _C.primary.withOpacity(0.28),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.add_rounded, size: 16, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            'Add Property',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // ── Filter chips ─────────────────────────────────────────────────
            SizedBox(
              height: 34,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final f = _filters[i];
                  final active = _filter == f;
                  return GestureDetector(
                    onTap: () => setState(() => _filter = f),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                      decoration: BoxDecoration(
                        color: active ? _C.primary : _C.bgCard,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: active ? _C.primary : _C.inputBorder,
                          width: 1,
                        ),
                        boxShadow: active
                            ? [
                          BoxShadow(
                            color: _C.primary.withOpacity(0.22),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                            : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Text(
                        f,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: active ? Colors.white : _C.textSub,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // ── List ─────────────────────────────────────────────────────────
            Expanded(
              child: filtered.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
                physics: const BouncingScrollPhysics(),
                itemCount: filtered.length,
                itemBuilder: (_, i) => _PropertyCard(
                  property: filtered[i],
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: _C.primaryLo,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.apartment_rounded, size: 38, color: _C.primary),
          ),
          const SizedBox(height: 18),
          const Text(
            'No properties yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: _C.text),
          ),
          const SizedBox(height: 6),
          const Text(
            'Tap Add Property to list your first property',
            style: TextStyle(fontSize: 13, color: _C.textSub),
          ),
        ],
      ),
    );
  }
}

// ── Data model ───────────────────────────────────────────────────────────────

class _PropertyItem {
  final String title;
  final String type;
  final String price;
  final String location;
  final int bedrooms;
  final int bathrooms;
  final String status;
  final int imageCount;

  const _PropertyItem({
    required this.title,
    required this.type,
    required this.price,
    required this.location,
    required this.bedrooms,
    required this.bathrooms,
    required this.status,
    required this.imageCount,
  });
}

// ── Property card ─────────────────────────────────────────────────────────────

class _PropertyCard extends StatelessWidget {
  final _PropertyItem property;
  final VoidCallback onTap;

  const _PropertyCard({required this.property, required this.onTap});

  Color get _tagBg {
    switch (property.status) {
      case 'Active':  return _C.tagActive;
      case 'Pending': return _C.tagPending;
      default:        return _C.tagDraft;
    }
  }

  Color get _tagText {
    switch (property.status) {
      case 'Active':  return _C.tagActiveText;
      case 'Pending': return _C.tagPendingText;
      default:        return _C.tagDraftText;
    }
  }

  IconData get _typeIcon {
    switch (property.type) {
      case 'House':     return Icons.home_rounded;
      case 'Studio':    return Icons.meeting_room_rounded;
      case 'Condo':     return Icons.business_rounded;
      case 'Duplex':    return Icons.house_rounded;
      case 'Townhouse': return Icons.holiday_village_rounded;
      case 'Villa':     return Icons.villa_rounded;
      default:          return Icons.apartment_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: _C.bgCard,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 14,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              // ── Top row ───────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Thumbnail placeholder
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: _C.primaryLo,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(_typeIcon, size: 30, color: _C.primary),
                    ),
                    const SizedBox(width: 14),

                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title + status
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  property.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: _C.text,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _tagBg,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  property.status,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: _tagText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),

                          // Type tag
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: _C.inputBg,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              property.type,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: _C.textSub,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Location
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined,
                                  size: 13, color: _C.textLight),
                              const SizedBox(width: 3),
                              Text(
                                property.location,
                                style: const TextStyle(
                                    fontSize: 12, color: _C.textSub),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Divider ───────────────────────────────────────────────────
              Divider(height: 1, indent: 14, endIndent: 14, color: _C.divider),

              // ── Bottom stats row ──────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    _Chip(icon: Icons.bed_outlined,
                        label: '${property.bedrooms} Bed'),
                    const SizedBox(width: 14),
                    _Chip(icon: Icons.bathtub_outlined,
                        label: '${property.bathrooms} Bath'),
                    const SizedBox(width: 14),
                    _Chip(icon: Icons.photo_library_outlined,
                        label: '${property.imageCount} photos'),
                    const Spacer(),
                    Text(
                      property.price,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: _C.primary,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Action row ────────────────────────────────────────────────
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFBF7F4),
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(18)),
                ),
                child: Row(
                  children: [
                    _ActionBtn(
                      icon: Icons.edit_outlined,
                      label: 'Edit',
                      onTap: () {},
                    ),
                    Container(width: 1, height: 40, color: _C.divider),
                    _ActionBtn(
                      icon: Icons.visibility_outlined,
                      label: 'Preview',
                      onTap: () {},
                    ),
                    Container(width: 1, height: 40, color: _C.divider),
                    _ActionBtn(
                      icon: Icons.delete_outline_rounded,
                      label: 'Delete',
                      color: Colors.redAccent,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Small chip ────────────────────────────────────────────────────────────────

class _Chip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Chip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: _C.textLight),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(fontSize: 12, color: _C.textSub)),
      ],
    );
  }
}

// ── Action button ─────────────────────────────────────────────────────────────

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.icon,
    required this.label,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? _C.textSub;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 15, color: c),
              const SizedBox(width: 5),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: c,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}