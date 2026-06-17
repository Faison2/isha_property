import 'package:flutter/material.dart';
import 'add_property.dart';

class PropertiesTab extends StatefulWidget {
  const PropertiesTab({super.key});

  @override
  State<PropertiesTab> createState() => _PropertiesTabState();
}

class _PropertiesTabState extends State<PropertiesTab> {
  static const Color _primary = Color(0xFFC87941);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0A00),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Properties',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_properties.length} total',
                      style: const TextStyle(
                        fontSize: 12,
                        color: _primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _properties.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      physics: const BouncingScrollPhysics(),
                      itemCount: _properties.length,
                      itemBuilder: (_, i) => _PropertyCard(
                        property: _properties[i],
                        onTap: () {},
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AddPropertyScreen(),
            ),
          );
        },
        backgroundColor: _primary,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text(
          'Add Property',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.apartment_rounded,
            size: 64,
            color: Colors.white.withOpacity(0.15),
          ),
          const SizedBox(height: 16),
          Text(
            'No properties yet',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withOpacity(0.55),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the button below to list your first property',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}

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

class _PropertyCard extends StatelessWidget {
  final _PropertyItem property;
  final VoidCallback onTap;

  const _PropertyCard({required this.property, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final statusColor = property.status == 'Active'
        ? const Color(0xFF4CAF50)
        : property.status == 'Pending'
            ? const Color(0xFFFFA726)
            : Colors.white.withOpacity(0.4);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
              width: 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFFC87941).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.apartment_rounded,
                      color: Color(0xFFC87941),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              property.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFC87941).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                property.type,
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: Color(0xFFC87941),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                size: 12, color: Colors.white.withOpacity(0.4)),
                            const SizedBox(width: 4),
                              Text(
                                property.location,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.55),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      property.status,
                      style: TextStyle(
                        fontSize: 10,
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Divider(
                color: Colors.white.withOpacity(0.08),
                thickness: 0.5,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _InfoChip(
                      icon: Icons.bed_outlined,
                      text: '${property.bedrooms} ${property.bedrooms == 1 ? 'Bed' : 'Beds'}'),
                  const SizedBox(width: 12),
                  _InfoChip(
                      icon: Icons.bathtub_outlined,
                      text: '${property.bathrooms} ${property.bathrooms == 1 ? 'Bath' : 'Baths'}'),
                  const SizedBox(width: 12),
                  _InfoChip(
                      icon: Icons.photo_library_outlined,
                      text: '${property.imageCount} photos'),
                  const Spacer(),
                  Text(
                    property.price,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFC87941),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.white.withOpacity(0.4)),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.55),
          ),
        ),
      ],
    );
  }
}
