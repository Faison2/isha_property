import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';


// ── Colour tokens (matching app palette) ─────────────────────────────────────
class _C {
  static const bg         = Color(0xFFF5F4FB);
  static const primary    = Color(0xFF7B6FD0);
  static const primaryLo  = Color(0x1A7B6FD0);
  static const amber      = Color(0xFFC87941);
  static const amberLo    = Color(0x1AC87941);
  static const green      = Color(0xFF3B9A5A);
  static const greenLo    = Color(0x1A3B9A5A);
  static const text       = Color(0xFF1A1A2E);
  static const textSub    = Color(0xFF8A8FA8);
  static const textLight  = Color(0xFFAAAAAA);
  static const divider    = Color(0xFFF0EBF8);
  static const card       = Color(0xFFFFFFFF);
  static const inputBorder = Color(0xFFE0DCF5);
}

// ═════════════════════════════════════════════════════════════════════════════
//  DATA MODEL
// ═════════════════════════════════════════════════════════════════════════════

/// Full property model used on the detail screen.
/// The list screens pass a [PropertyListing] when navigating here.
class PropertyListing {
  final String id;
  final String title;
  final String type;
  final String price;
  final String suburb;
  final String city;
  final String country;
  final int beds;
  final int baths;
  final String area;

  // Detail-only fields
  final String description;
  final List<String> imagePaths;   // asset paths OR network URLs
  final List<String> amenities;
  final double latitude;
  final double longitude;
  final String landlordName;
  final String landlordPhone;
  final String landlordWhatsApp;   // phone number string e.g. '+263771234567'
  final bool isAvailable;
  final String availableFrom;      // e.g. 'Immediately' or '1 Aug 2025'
  final String deposit;            // e.g. 'USD 700'

  const PropertyListing({
    required this.id,
    required this.title,
    required this.type,
    required this.price,
    required this.suburb,
    required this.city,
    this.country = 'Zimbabwe',
    required this.beds,
    required this.baths,
    required this.area,
    required this.description,
    required this.imagePaths,
    required this.amenities,
    required this.latitude,
    required this.longitude,
    required this.landlordName,
    required this.landlordPhone,
    required this.landlordWhatsApp,
    this.isAvailable = true,
    this.availableFrom = 'Immediately',
    required this.deposit,
  });
}

// ── Sample data (replace / extend with your API response) ────────────────────
final sampleListings = <PropertyListing>[
  PropertyListing(
    id: '1',
    title: 'Modern 2-Bed Flat',
    type: 'Apartment',
    price: 'USD 350/mo',
    suburb: 'Avondale',
    city: 'Harare',
    beds: 2,
    baths: 1,
    area: '850 sqft',
    deposit: 'USD 700',
    description:
    'A beautifully maintained second-floor apartment in the heart of Avondale. '
        'Freshly painted with tiled floors throughout, the unit enjoys abundant natural '
        'light and a private balcony overlooking the garden. The open-plan kitchen is '
        'fitted with modern cabinetry and a built-in hob. Fibre-ready. Secure parking '
        'for one vehicle included. Walking distance to Avondale Shopping Centre and '
        'major bus routes.',
    imagePaths: [
      'assets/images/property1.jpg',
      'assets/images/property1b.jpg',
      'assets/images/property1c.jpg',
    ],
    amenities: [
      'Secure Parking',
      'Fibre Ready',
      'Private Balcony',
      'Garden Access',
      'Security Guard',
      'Water Included',
      'DSTV Point',
      'Built-in Wardrobes',
    ],
    latitude: -17.8044,
    longitude: 31.0440,
    landlordName: 'Tatenda Moyo',
    landlordPhone: '+263771234567',
    landlordWhatsApp: '+263771234567',
    availableFrom: 'Immediately',
  ),
  PropertyListing(
    id: '2',
    title: 'Executive House',
    type: 'House',
    price: 'USD 750/mo',
    suburb: 'Borrowdale',
    city: 'Harare',
    beds: 4,
    baths: 3,
    area: '2,200 sqft',
    deposit: 'USD 1,500',
    description:
    'Spacious executive home in the prestigious Borrowdale neighbourhood. '
        'Features a large lounge and formal dining room, fully fitted kitchen with '
        'pantry, and a separate staff quarter. The garden is professionally landscaped '
        'with a borehole for irrigation. High perimeter walls with electric fence and '
        'alarm system. Double garage. Schools, shops, and Borrowdale Brooke Golf Club '
        'all within 5 minutes.',
    imagePaths: [
      'assets/images/property2.jpg',
      'assets/images/property2b.jpg',
    ],
    amenities: [
      'Double Garage',
      'Electric Fence',
      'Alarm System',
      'Borehole',
      'Staff Quarter',
      'Fibre Ready',
      'Garden & Lawn',
      'Solar Geyser',
    ],
    latitude: -17.7473,
    longitude: 31.0969,
    landlordName: 'Rumbidzai Chikwanda',
    landlordPhone: '+263712345678',
    landlordWhatsApp: '+263712345678',
    availableFrom: '1 Aug 2025',
  ),
];

// ═════════════════════════════════════════════════════════════════════════════
//  PROPERTY DETAIL SCREEN
// ═════════════════════════════════════════════════════════════════════════════
class PropertyDetailScreen extends StatefulWidget {
  final PropertyListing listing;

  const PropertyDetailScreen({super.key, required this.listing});

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  int _currentImage = 0;
  bool _isSaved = false;
  final PageController _imageCtrl = PageController();

  PropertyListing get p => widget.listing;

  @override
  void dispose() {
    _imageCtrl.dispose();
    super.dispose();
  }

  // ── Launchers ──────────────────────────────────────────────────────────────
  Future<void> _launchPhone() async {
    final uri = Uri(scheme: 'tel', path: p.landlordPhone);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _launchWhatsApp() async {
    final number = p.landlordWhatsApp.replaceAll('+', '').replaceAll(' ', '');
    final uri = Uri.parse('https://wa.me/$number?text=${Uri.encodeComponent('Hi, I\'m interested in your listing: ${p.title} in ${p.suburb}, ${p.city}.')}');
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _launchMaps() async {
    final label = Uri.encodeComponent('${p.title}, ${p.suburb}');
    // Try Google Maps app first, fallback to browser maps
    final googleMapsApp = Uri.parse(
        'comgooglemaps://?q=${p.latitude},${p.longitude}&zoom=16&label=$label');
    final googleMapsBrowser = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${p.latitude},${p.longitude}');

    if (await canLaunchUrl(googleMapsApp)) {
      await launchUrl(googleMapsApp);
    } else {
      await launchUrl(googleMapsBrowser, mode: LaunchMode.externalApplication);
    }
  }

  // ── Image viewer overlay ───────────────────────────────────────────────────
  void _openFullscreenGallery(int startIndex) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black,
        pageBuilder: (_, __, ___) => _FullscreenGallery(
          imagePaths: p.imagePaths,
          initialIndex: startIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      backgroundColor: _C.bg,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // ── Scrollable content ─────────────────────────────────────────
          CustomScrollView(
            slivers: [
              // ── Image gallery hero ──────────────────────────────────────
              SliverToBoxAdapter(child: _buildImageGallery()),

              // ── Title & quick stats ─────────────────────────────────────
              SliverToBoxAdapter(child: _buildTitleSection()),

              // ── Key details row ─────────────────────────────────────────
              SliverToBoxAdapter(child: _buildKeyDetails()),

              // ── Description ─────────────────────────────────────────────
              SliverToBoxAdapter(child: _buildSection(
                title: 'Description',
                child: Text(
                  p.description,
                  style: const TextStyle(fontSize: 14, color: _C.textSub, height: 1.65),
                ),
              )),

              // ── Amenities ───────────────────────────────────────────────
              SliverToBoxAdapter(child: _buildSection(
                title: 'Amenities & Features',
                child: _buildAmenities(),
              )),

              // ── Lease info ──────────────────────────────────────────────
              SliverToBoxAdapter(child: _buildSection(
                title: 'Lease Information',
                child: _buildLeaseInfo(),
              )),

              // ── Location / Map ──────────────────────────────────────────
              SliverToBoxAdapter(child: _buildSection(
                title: 'Location',
                child: _buildMapCard(),
              )),

              // ── Landlord ────────────────────────────────────────────────
              SliverToBoxAdapter(child: _buildSection(
                title: 'Listed By',
                child: _buildLandlordCard(),
              )),

              // Bottom padding so content clears the fixed action bar
              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),

          // ── Floating back + save bar ────────────────────────────────────
          _buildTopBar(),

          // ── Bottom action bar ───────────────────────────────────────────
          Positioned(
            left: 0, right: 0, bottom: 0,
            child: _buildBottomBar(),
          ),
        ],
      ),
    );
  }

  // ── IMAGE GALLERY ──────────────────────────────────────────────────────────
  Widget _buildImageGallery() {
    return SizedBox(
      height: 320,
      child: Stack(
        children: [
          // Pages
          PageView.builder(
            controller: _imageCtrl,
            itemCount: p.imagePaths.length,
            onPageChanged: (i) => setState(() => _currentImage = i),
            itemBuilder: (_, i) => GestureDetector(
              onTap: () => _openFullscreenGallery(i),
              child: Image.asset(
                p.imagePaths[i],
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (_, __, ___) => _imagePlaceholder(p.type),
              ),
            ),
          ),

          // Bottom gradient
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              height: 120,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xDD1A1A2E), Colors.transparent],
                ),
              ),
            ),
          ),

          // Dot indicators
          Positioned(
            bottom: 16, left: 0, right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(p.imagePaths.length, (i) {
                final active = i == _currentImage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: active ? 20 : 6,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: active ? Colors.white : Colors.white38,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),

          // Image counter badge
          Positioned(
            bottom: 16, right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.photo_library_outlined, size: 13, color: Colors.white),
                  const SizedBox(width: 5),
                  Text('${_currentImage + 1}/${p.imagePaths.length}',
                      style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),

          // Thumbnail strip at bottom-left
          if (p.imagePaths.length > 1)
            Positioned(
              bottom: 44, left: 16,
              child: SizedBox(
                height: 44,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: p.imagePaths.length,
                  itemBuilder: (_, i) {
                    final active = i == _currentImage;
                    return GestureDetector(
                      onTap: () {
                        _imageCtrl.animateToPage(i,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 44,
                        height: 44,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: active ? _C.primary : Colors.white38,
                            width: active ? 2.5 : 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            p.imagePaths[i],
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: Colors.white12,
                              child: const Icon(Icons.image_outlined, size: 18, color: Colors.white54),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ── TITLE SECTION ──────────────────────────────────────────────────────────
  Widget _buildTitleSection() {
    return Container(
      color: _C.card,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Type badge + availability
          Row(
            children: [
              _TypeBadge(type: p.type),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: p.isAvailable ? _C.greenLo : _C.amberLo,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6, height: 6,
                      decoration: BoxDecoration(
                        color: p.isAvailable ? _C.green : _C.amber,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      p.isAvailable ? 'Available' : 'Occupied',
                      style: TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w700,
                        color: p.isAvailable ? _C.green : _C.amber,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Title
          Text(p.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: _C.text, height: 1.2)),
          const SizedBox(height: 8),

          // Location row
          Row(
            children: [
              const Icon(Icons.location_on_rounded, size: 15, color: _C.primary),
              const SizedBox(width: 4),
              Text('${p.suburb}, ${p.city}, ${p.country}',
                  style: const TextStyle(fontSize: 13, color: _C.textSub)),
            ],
          ),
          const SizedBox(height: 14),

          // Price row
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(p.price,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: _C.primary)),
              const Spacer(),
              // Rating placeholder
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7E0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.star_rounded, size: 14, color: _C.amber),
                    SizedBox(width: 4),
                    Text('4.8', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _C.amber)),
                    SizedBox(width: 4),
                    Text('(24)', style: TextStyle(fontSize: 11, color: _C.textLight)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── KEY DETAILS ────────────────────────────────────────────────────────────
  Widget _buildKeyDetails() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: _C.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          if (p.beds > 0) ...[
            _StatCell(icon: Icons.bed_rounded, value: '${p.beds}', label: p.beds == 1 ? 'Bedroom' : 'Bedrooms', color: _C.primary),
            _VertDivider(),
          ],
          _StatCell(icon: Icons.bathtub_outlined, value: '${p.baths}', label: p.baths == 1 ? 'Bathroom' : 'Bathrooms', color: _C.amber),
          _VertDivider(),
          _StatCell(icon: Icons.square_foot_rounded, value: p.area.replaceAll(' sqft', ''), label: 'sqft', color: _C.green),
          _VertDivider(),
          _StatCell(icon: Icons.account_balance_wallet_outlined, value: p.deposit.split(' ').last, label: 'Deposit', color: const Color(0xFF5A8FD0)),
        ],
      ),
    );
  }

  // ── SECTION WRAPPER ────────────────────────────────────────────────────────
  Widget _buildSection({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(title: title),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  // ── AMENITIES ──────────────────────────────────────────────────────────────
  Widget _buildAmenities() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: p.amenities.map((a) => _AmenityChip(label: a)).toList(),
    );
  }

  // ── LEASE INFO ─────────────────────────────────────────────────────────────
  Widget _buildLeaseInfo() {
    return Container(
      decoration: BoxDecoration(
        color: _C.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _C.inputBorder),
      ),
      child: Column(
        children: [
          _LeaseRow(icon: Icons.attach_money_rounded,    label: 'Monthly Rent',    value: p.price,           color: _C.primary),
          Divider(height: 1, indent: 16, endIndent: 16, color: _C.divider),
          _LeaseRow(icon: Icons.security_rounded,        label: 'Security Deposit', value: p.deposit,         color: _C.amber),
          Divider(height: 1, indent: 16, endIndent: 16, color: _C.divider),
          _LeaseRow(icon: Icons.calendar_today_rounded,  label: 'Available From',  value: p.availableFrom,   color: _C.green),
          Divider(height: 1, indent: 16, endIndent: 16, color: _C.divider),
          _LeaseRow(icon: Icons.home_work_rounded,       label: 'Property Type',   value: p.type,            color: const Color(0xFF5A8FD0)),
        ],
      ),
    );
  }

  // ── MAP CARD ───────────────────────────────────────────────────────────────
  Widget _buildMapCard() {
    return GestureDetector(
      onTap: _launchMaps,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: _C.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _C.inputBorder),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Static map via Google Static Maps API
              // Replace YOUR_API_KEY with your key, or use a placeholder image
              Image.network(
                'https://maps.googleapis.com/maps/api/staticmap'
                    '?center=${p.latitude},${p.longitude}'
                    '&zoom=15'
                    '&size=600x400'
                    '&maptype=roadmap'
                    '&markers=color:purple%7C${p.latitude},${p.longitude}'
                    '&key=YOUR_GOOGLE_MAPS_API_KEY',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
                errorBuilder: (_, __, ___) => _mapPlaceholder(),
              ),

              // Tap overlay
              Positioned(
                bottom: 0, left: 0, right: 0,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Color(0xCC1A1A2E), Colors.transparent],
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_rounded, size: 16, color: Colors.white),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text('${p.suburb}, ${p.city}',
                            style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w600)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _C.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.map_outlined, size: 13, color: Colors.white),
                            SizedBox(width: 5),
                            Text('Open Maps', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w700)),
                          ],
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
    );
  }

  // ── LANDLORD CARD ──────────────────────────────────────────────────────────
  Widget _buildLandlordCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _C.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _C.inputBorder),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 52, height: 52,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF7B6FD0), Color(0xFF4A3FA8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                p.landlordName.substring(0, 1).toUpperCase(),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.landlordName,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _C.text)),
                const SizedBox(height: 3),
                const Row(
                  children: [
                    Icon(Icons.verified_rounded, size: 13, color: _C.primary),
                    SizedBox(width: 4),
                    Text('Verified Landlord', style: TextStyle(fontSize: 12, color: _C.primary, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(p.landlordPhone, style: const TextStyle(fontSize: 12, color: _C.textSub)),
              ],
            ),
          ),
          // Quick action buttons
          _IconActionBtn(icon: Icons.call_rounded, color: _C.green, onTap: _launchPhone),
          const SizedBox(width: 8),
          _IconActionBtn(icon: Icons.chat_rounded, color: const Color(0xFF25D366), onTap: _launchWhatsApp),
        ],
      ),
    );
  }

  // ── TOP BAR (back + save) ──────────────────────────────────────────────────
  Widget _buildTopBar() {
    return Positioned(
      top: 0, left: 0, right: 0,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Row(
            children: [
              _GlassBtn(
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: () => Navigator.of(context).pop(),
              ),
              const Spacer(),
              _GlassBtn(
                icon: Icons.share_outlined,
                onTap: () {/* share logic */},
              ),
              const SizedBox(width: 10),
              _GlassBtn(
                icon: _isSaved ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                iconColor: _isSaved ? Colors.red : Colors.white,
                onTap: () => setState(() => _isSaved = !_isSaved),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── BOTTOM ACTION BAR ──────────────────────────────────────────────────────
  Widget _buildBottomBar() {
    final bottom = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 14, 20, bottom + 14),
      decoration: BoxDecoration(
        color: _C.card,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
      ),
      child: Row(
        children: [
          // WhatsApp button
          Expanded(
            child: _BarBtn(
              icon: Icons.chat_rounded,
              label: 'WhatsApp',
              color: const Color(0xFF25D366),
              onTap: _launchWhatsApp,
            ),
          ),
          const SizedBox(width: 12),
          // Schedule viewing
          Expanded(
            child: _BarBtn(
              icon: Icons.calendar_month_rounded,
              label: 'Book Viewing',
              color: _C.amber,
              onTap: () => _showBookingSheet(context),
            ),
          ),
          const SizedBox(width: 12),
          // Call button (compact)
          GestureDetector(
            onTap: _launchPhone,
            child: Container(
              width: 50, height: 50,
              decoration: BoxDecoration(
                color: _C.primaryLo,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _C.primary.withOpacity(0.3)),
              ),
              child: const Icon(Icons.call_rounded, color: _C.primary, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  // ── BOOKING BOTTOM SHEET ───────────────────────────────────────────────────
  void _showBookingSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _BookingSheet(listing: p),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  BOOKING SHEET
// ═════════════════════════════════════════════════════════════════════════════
class _BookingSheet extends StatefulWidget {
  final PropertyListing listing;
  const _BookingSheet({required this.listing});

  @override
  State<_BookingSheet> createState() => _BookingSheetState();
}

class _BookingSheetState extends State<_BookingSheet> {
  DateTime? _selectedDate;
  int _selectedTimeIndex = -1;

  static const _times = ['09:00 AM', '11:00 AM', '01:00 PM', '03:00 PM', '05:00 PM'];

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, bottom + 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(color: _C.divider, borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 18),
          const Text('Book a Viewing',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _C.text)),
          const SizedBox(height: 4),
          Text(widget.listing.title,
              style: const TextStyle(fontSize: 13, color: _C.textSub)),
          const SizedBox(height: 20),

          // Date picker button
          GestureDetector(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now().add(const Duration(days: 1)),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 90)),
                builder: (ctx, child) => Theme(
                  data: Theme.of(ctx).copyWith(
                    colorScheme: const ColorScheme.light(primary: _C.primary),
                  ),
                  child: child!,
                ),
              );
              if (picked != null) setState(() => _selectedDate = picked);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: _C.bg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _selectedDate != null ? _C.primary : _C.inputBorder),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today_rounded, size: 18,
                      color: _selectedDate != null ? _C.primary : _C.textLight),
                  const SizedBox(width: 10),
                  Text(
                    _selectedDate == null
                        ? 'Select a date'
                        : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                    style: TextStyle(
                      fontSize: 14,
                      color: _selectedDate != null ? _C.text : _C.textLight,
                      fontWeight: _selectedDate != null ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.chevron_right_rounded, size: 18, color: _C.textLight),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Time slots
          const Text('Preferred Time',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _C.textSub)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: List.generate(_times.length, (i) {
              final selected = i == _selectedTimeIndex;
              return GestureDetector(
                onTap: () => setState(() => _selectedTimeIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: selected ? _C.primary : _C.bg,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: selected ? _C.primary : _C.inputBorder),
                  ),
                  child: Text(_times[i],
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600,
                          color: selected ? Colors.white : _C.textSub)),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),

          // Confirm button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: (_selectedDate != null && _selectedTimeIndex >= 0)
                  ? () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Viewing booked for ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year} at ${_times[_selectedTimeIndex]}',
                    ),
                    backgroundColor: _C.primary,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                );
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _C.primary,
                disabledBackgroundColor: _C.inputBorder,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              child: const Text('Confirm Viewing',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  FULLSCREEN GALLERY
// ═════════════════════════════════════════════════════════════════════════════
class _FullscreenGallery extends StatefulWidget {
  final List<String> imagePaths;
  final int initialIndex;
  const _FullscreenGallery({required this.imagePaths, required this.initialIndex});

  @override
  State<_FullscreenGallery> createState() => _FullscreenGalleryState();
}

class _FullscreenGalleryState extends State<_FullscreenGallery> {
  late int _current;
  late PageController _ctrl;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _ctrl = PageController(initialPage: widget.initialIndex);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _ctrl,
            itemCount: widget.imagePaths.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (_, i) => InteractiveViewer(
              child: Center(
                child: Image.asset(
                  widget.imagePaths[i],
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => _imagePlaceholder(''),
                ),
              ),
            ),
          ),
          // Top bar
          Positioned(
            top: 0, left: 0, right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    _GlassBtn(icon: Icons.close_rounded, onTap: () => Navigator.pop(context)),
                    const Spacer(),
                    Text('${_current + 1} / ${widget.imagePaths.length}',
                        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  SMALL REUSABLE WIDGETS
// ═════════════════════════════════════════════════════════════════════════════

class _TypeBadge extends StatelessWidget {
  final String type;
  const _TypeBadge({required this.type});

  Color get _color {
    switch (type) {
      case 'House':  return const Color(0xFFC87941);
      case 'Studio': return const Color(0xFF3B9A5A);
      case 'Room':   return const Color(0xFF5A8FD0);
      case 'Office': return const Color(0xFF888888);
      default:       return _C.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(type,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: _color)),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 4, height: 18, decoration: BoxDecoration(color: _C.primary, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 10),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: _C.text)),
      ],
    );
  }
}

class _StatCell extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  const _StatCell({required this.icon, required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: color)),
          Text(label, style: const TextStyle(fontSize: 10, color: _C.textLight)),
        ],
      ),
    );
  }
}

class _VertDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 48, color: _C.divider);
}

class _AmenityChip extends StatelessWidget {
  final String label;
  const _AmenityChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _C.primaryLo,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _C.primary.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_rounded, size: 13, color: _C.primary),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 12, color: _C.primary, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _LeaseRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _LeaseRow({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 34, height: 34,
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, size: 17, color: color),
          ),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontSize: 13, color: _C.textSub)),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _C.text)),
        ],
      ),
    );
  }
}

class _GlassBtn extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final VoidCallback onTap;
  const _GlassBtn({required this.icon, this.iconColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24),
        ),
        child: Icon(icon, size: 18, color: iconColor ?? Colors.white),
      ),
    );
  }
}

class _IconActionBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _IconActionBtn({required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 20, color: color),
      ),
    );
  }
}

class _BarBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _BarBtn({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(14)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: Colors.white),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────
Widget _imagePlaceholder(String type) {
  return Container(
    color: const Color(0xFFDDDAF5),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.home_work_rounded, size: 56, color: Colors.white54),
          const SizedBox(height: 8),
          Text(type, style: const TextStyle(color: Colors.white54, fontSize: 13)),
        ],
      ),
    ),
  );
}

Widget _mapPlaceholder() {
  return Container(
    color: const Color(0xFFE8E4F5),
    child: Stack(
      children: [
        // Grid lines to simulate map
        CustomPaint(painter: _MapGridPainter(), size: Size.infinite),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44, height: 44,
                decoration: const BoxDecoration(color: _C.primary, shape: BoxShape.circle),
                child: const Icon(Icons.location_on_rounded, color: Colors.white, size: 26),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)]),
                child: const Text('Tap to open Google Maps',
                    style: TextStyle(fontSize: 12, color: _C.primary, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD0CBF0)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}