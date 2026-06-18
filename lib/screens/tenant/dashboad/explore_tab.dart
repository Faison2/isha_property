import 'package:flutter/material.dart';

class _C {
  static const bg          = Color(0xFFFAF5F0);
  static const bgCard      = Color(0xFFFFFFFF);
  static const primary     = Color(0xFF7B6FD0);
  static const primaryLo   = Color(0x1A7B6FD0);
  static const text        = Color(0xFF1A1A1A);
  static const textSub     = Color(0xFF888888);
  static const textLight   = Color(0xFFAAAAAA);
  static const divider     = Color(0xFFF0EBE6);
  static const inputBg     = Color(0xFFF5EFE9);
  static const inputBorder = Color(0xFFE4D8CE);
}

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  final _searchController = TextEditingController();
  String _query = '';
  String _selectedType = 'All';
  final _types = ['All', 'Apartment', 'House', 'Studio', 'Condo'];

  final _properties = [
    _PropertyItem(title: 'Sunset Apartment', type: 'Apartment', price: '\$1,200/mo', location: 'Westside, NY', beds: 2, baths: 1, area: '850 sqft'),
    _PropertyItem(title: 'Downtown Studio', type: 'Studio', price: '\$900/mo', location: 'Downtown, LA', beds: 0, baths: 1, area: '450 sqft'),
    _PropertyItem(title: 'Garden House', type: 'House', price: '\$2,500/mo', location: 'Brooklyn, NY', beds: 3, baths: 2, area: '1,400 sqft'),
    _PropertyItem(title: 'Lakeside Condo', type: 'Condo', price: '\$1,800/mo', location: 'Lakeview, IL', beds: 2, baths: 2, area: '1,100 sqft'),
    _PropertyItem(title: 'Penthouse Suite', type: 'Penthouse', price: '\$3,500/mo', location: 'Manhattan, NY', beds: 3, baths: 3, area: '2,000 sqft'),
    _PropertyItem(title: 'Cozy Townhouse', type: 'Townhouse', price: '\$1,600/mo', location: 'Austin, TX', beds: 2, baths: 1, area: '950 sqft'),
  ];

  List<_PropertyItem> get _filtered {
    var result = _properties;
    if (_selectedType != 'All') {
      result = result.where((p) => p.type == _selectedType).toList();
    }
    if (_query.isNotEmpty) {
      result = result.where((p) =>
          p.title.toLowerCase().contains(_query.toLowerCase()) ||
          p.location.toLowerCase().contains(_query.toLowerCase())).toList();
    }
    return result;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Explore', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: _C.text)),
                  const SizedBox(height: 2),
                  Text('${_properties.length} properties available', style: const TextStyle(fontSize: 13, color: _C.textSub)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: _C.bgCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _C.inputBorder, width: 1),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _query = v),
                  style: const TextStyle(fontSize: 14, color: _C.text),
                  decoration: const InputDecoration(
                    hintText: 'Search by location or name...',
                    hintStyle: TextStyle(fontSize: 14, color: _C.textLight),
                    prefixIcon: Icon(Icons.search_rounded, size: 20, color: _C.textLight),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 34,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _types.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final f = _types[i];
                  final active = _selectedType == f;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedType = f),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                      decoration: BoxDecoration(
                        color: active ? _C.primary : _C.bgCard,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: active ? _C.primary : _C.inputBorder, width: 1),
                        boxShadow: active
                            ? [BoxShadow(color: _C.primary.withOpacity(0.22), blurRadius: 8, offset: const Offset(0, 3))]
                            : [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4, offset: const Offset(0, 1))],
                      ),
                      child: Text(f, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: active ? Colors.white : _C.textSub)),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
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
                        onSave: () {},
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
            width: 80, height: 80,
            decoration: BoxDecoration(color: _C.primaryLo, shape: BoxShape.circle),
            child: const Icon(Icons.search_off_rounded, size: 36, color: _C.primary),
          ),
          const SizedBox(height: 18),
          const Text('No properties found', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: _C.text)),
          const SizedBox(height: 6),
          const Text('Try adjusting your search or filters', style: TextStyle(fontSize: 13, color: _C.textSub)),
        ],
      ),
    );
  }
}

class _PropertyItem {
  final String title, type, price, location, area;
  final int beds, baths;
  _PropertyItem({required this.title, required this.type, required this.price, required this.location, required this.beds, required this.baths, required this.area});
}

class _PropertyCard extends StatelessWidget {
  final _PropertyItem property;
  final VoidCallback onTap;
  final VoidCallback onSave;
  const _PropertyCard({required this.property, required this.onTap, required this.onSave});

  IconData get _typeIcon {
    switch (property.type) {
      case 'House': return Icons.home_rounded;
      case 'Studio': return Icons.meeting_room_rounded;
      case 'Condo': return Icons.business_rounded;
      case 'Townhouse': return Icons.holiday_village_rounded;
      default: return Icons.apartment_rounded;
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
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 14, offset: const Offset(0, 3))],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 70, height: 70,
                      decoration: BoxDecoration(color: _C.primaryLo, borderRadius: BorderRadius.circular(14)),
                      child: Icon(_typeIcon, size: 30, color: _C.primary),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(property.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _C.text)),
                              ),
                              GestureDetector(
                                onTap: onSave,
                                child: Icon(Icons.favorite_outline_rounded, size: 20, color: _C.textLight),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(color: _C.inputBg, borderRadius: BorderRadius.circular(6)),
                            child: Text(property.type, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _C.textSub)),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 13, color: _C.textLight),
                              const SizedBox(width: 3),
                              Text(property.location, style: const TextStyle(fontSize: 12, color: _C.textSub)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, indent: 14, endIndent: 14, color: _C.divider),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    _Chip(icon: Icons.bed_outlined, label: '${property.beds} Bed'),
                    const SizedBox(width: 14),
                    _Chip(icon: Icons.bathtub_outlined, label: '${property.baths} Bath'),
                    const SizedBox(width: 14),
                    _Chip(icon: Icons.square_foot_rounded, label: property.area),
                    const Spacer(),
                    Text(property.price, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: _C.primary)),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFBF7F4),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
                ),
                child: Row(
                  children: [
                    _ActionBtn(icon: Icons.chat_bubble_outline_rounded, label: 'Inquire', color: _C.primary, onTap: () {}),
                    Container(width: 1, height: 40, color: _C.divider),
                    _ActionBtn(icon: Icons.calendar_today_rounded, label: 'Viewing', color: _C.primary, onTap: () {}),
                    Container(width: 1, height: 40, color: _C.divider),
                    _ActionBtn(icon: Icons.share_outlined, label: 'Share', onTap: () {}),
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
        Text(label, style: const TextStyle(fontSize: 12, color: _C.textSub)),
      ],
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback onTap;
  const _ActionBtn({required this.icon, required this.label, this.color, required this.onTap});

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
              Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: c)),
            ],
          ),
        ),
      ),
    );
  }
}
