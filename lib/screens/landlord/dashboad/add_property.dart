import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ── Colour palette — mirrors LandlordDashboard exactly ───────────────────────
class _C {
  static const bg           = Color(0xFFFAF5F0); // warm cream
  static const bgCard       = Color(0xFFFFFFFF); // white cards
  static const primary      = Color(0xFFB5622A); // terracotta
  static const primaryLo    = Color(0x1AB5622A); // primary 10 %
  static const text         = Color(0xFF1A1A1A);
  static const textSub      = Color(0xFF888888);
  static const textLight    = Color(0xFFAAAAAA);
  static const divider      = Color(0xFFF0EBE6);
  static const inputBg      = Color(0xFFF5EFE9); // warm tinted input bg
  static const inputBorder  = Color(0xFFE4D8CE);
  static const tagOccupied     = Color(0xFFE8F5EE);
  static const tagOccupiedText = Color(0xFF2E7D52);
}

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final _titleController       = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController       = TextEditingController();
  final _locationController    = TextEditingController();
  final _areaController        = TextEditingController();

  String _selectedType = 'Apartment';
  int    _bedrooms     = 1;
  int    _bathrooms    = 1;
  bool   _isAvailable  = true;

  final List<String> _propertyImages = [];
  final List<String> _propertyTypes  = [
    'Apartment', 'House', 'Studio', 'Condo',
    'Duplex', 'Townhouse', 'Villa', 'Penthouse',
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildSectionTitle('Photos'),
                    const SizedBox(height: 12),
                    _buildImageGrid(),
                    const SizedBox(height: 28),
                    _buildSectionTitle('Property Details'),
                    const SizedBox(height: 14),
                    _buildCard(
                      child: Column(
                        children: [
                          _buildTextField(
                            controller: _titleController,
                            hint: 'Property title',
                            prefixIcon: Icons.edit_rounded,
                          ),
                          _buildDivider(),
                          _buildTypeDropdown(),
                          _buildDivider(),
                          _buildTextField(
                            controller: _descriptionController,
                            hint: 'Description',
                            prefixIcon: Icons.description_outlined,
                            maxLines: 4,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    _buildSectionTitle('Pricing & Location'),
                    const SizedBox(height: 14),
                    _buildCard(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  controller: _priceController,
                                  hint: 'Monthly rent',
                                  prefixIcon: Icons.attach_money_rounded,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              Container(width: 1, height: 52, color: _C.divider),
                              Expanded(
                                child: _buildTextField(
                                  controller: _areaController,
                                  hint: 'Area (sqft)',
                                  prefixIcon: Icons.square_foot_rounded,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                          _buildDivider(),
                          _buildTextField(
                            controller: _locationController,
                            hint: 'Location',
                            prefixIcon: Icons.location_on_outlined,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    _buildSectionTitle('Layout'),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStepperCard(
                            label: 'Bedrooms',
                            icon: Icons.bed_rounded,
                            value: _bedrooms,
                            onIncrement: () => setState(() => _bedrooms++),
                            onDecrement: () =>
                                setState(() => _bedrooms = (_bedrooms > 0 ? _bedrooms - 1 : 0)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStepperCard(
                            label: 'Bathrooms',
                            icon: Icons.bathtub_rounded,
                            value: _bathrooms,
                            onIncrement: () => setState(() => _bathrooms++),
                            onDecrement: () =>
                                setState(() => _bathrooms = (_bathrooms > 0 ? _bathrooms - 1 : 0)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    _buildSectionTitle('Availability'),
                    const SizedBox(height: 14),
                    _buildAvailabilityToggle(),
                    const SizedBox(height: 32),
                    _buildSubmitButton(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── App bar ───────────────────────────────────────────────────────────────

  Widget _buildAppBar() {
    return Container(
      color: _C.bg,
      padding: const EdgeInsets.fromLTRB(8, 10, 20, 10),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
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
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: _C.text,
              ),
            ),
          ),
          const Spacer(),
          const Text(
            'Add Property',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: _C.text,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 40), // balance
        ],
      ),
    );
  }

  // ── Section title — matches dashboard style ───────────────────────────────

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 17,
          decoration: BoxDecoration(
            color: _C.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: _C.text,
          ),
        ),
      ],
    );
  }

  // ── White card wrapper (mirrors dashboard card style) ─────────────────────

  Widget _buildCard({required Widget child}) {
    return Container(
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
      child: child,
    );
  }

  Widget _buildDivider() =>
      Divider(height: 1, indent: 16, endIndent: 16, color: _C.divider);

  // ── Photos section ────────────────────────────────────────────────────────

  static const Color _dropBg     = Color(0xFFFFF8F4);
  static const Color _dropBorder = Color(0xFFD4B09A);
  static const Color _thumbEmpty = Color(0xFFF5EDE5);
  static const Color _thumbBdr   = Color(0xFFE8DDD4);
  static const Color _countBg    = Color(0xFFF5EDE5);

  Widget _buildImageGrid() {
    final count = _propertyImages.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Count badge row
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: _countBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$count / 6 photos',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: _C.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // ── Main drop zone
        GestureDetector(
          onTap: () => setState(() =>
              _propertyImages.add('placeholder_${_propertyImages.length}')),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: double.infinity,
            height: 148,
            decoration: BoxDecoration(
              color: _dropBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _dropBorder,
                width: 1.5,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: _C.primaryLo,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.cloud_upload_outlined,
                    size: 26,
                    color: _C.primary,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Tap to add photos',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _C.text,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'JPG or PNG · up to 10 MB each',
                  style: TextStyle(fontSize: 11, color: _C.textLight),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 14),

        // ── Thumbnail strip (6 fixed slots)
        Row(
          children: List.generate(6, (i) {
            if (i < count) {
              return _buildThumb(i);
            } else if (i == count && count < 6) {
              return _buildAddThumb();
            } else {
              return _buildEmptyThumb();
            }
          })
              .map((w) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: w,
            ),
          ))
              .toList(),
        ),

        const SizedBox(height: 8),
        const Text(
          'First photo will be the cover image',
          style: TextStyle(fontSize: 11, color: _C.textLight),
        ),
      ],
    );
  }

  Widget _buildThumb(int index) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: _C.primaryLo,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _thumbBdr, width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const Icon(Icons.image_rounded, color: _C.primary, size: 24),
                  // Cover label on first photo
                  if (index == 0)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: _C.primary.withOpacity(0.80),
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: const Text(
                          'Cover',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Delete button
          Positioned(
            top: 3,
            right: 3,
            child: GestureDetector(
              onTap: () => setState(() => _propertyImages.removeAt(index)),
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: _C.text.withOpacity(0.65),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close_rounded, size: 11, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddThumb() {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () => setState(() =>
            _propertyImages.add('placeholder_${_propertyImages.length}')),
        child: Container(
          decoration: BoxDecoration(
            color: _dropBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _dropBorder, width: 1.5, style: BorderStyle.solid),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_rounded, size: 20, color: _C.primary),
              SizedBox(height: 2),
              Text(
                'Add',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: _C.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyThumb() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: _thumbEmpty,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _thumbBdr, width: 1),
        ),
        child: const Icon(Icons.photo_outlined, size: 18, color: Color(0xFFD4A882)),
      ),
    );
  }

  // ── Text field — light theme ──────────────────────────────────────────────

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData prefixIcon,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14, color: _C.text),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: _C.textLight, fontSize: 14),
        prefixIcon: Icon(prefixIcon, color: _C.textSub, size: 20),
        border: InputBorder.none,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  // ── Type dropdown ─────────────────────────────────────────────────────────

  Widget _buildTypeDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedType,
          isExpanded: true,
          dropdownColor: _C.bgCard,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: _C.textSub),
          style: const TextStyle(fontSize: 14, color: _C.text),
          items: _propertyTypes.map((type) {
            return DropdownMenuItem(
              value: type,
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Icon(_typeIcon(type), size: 20, color: _C.primary),
                  const SizedBox(width: 10),
                  Text(type, style: const TextStyle(color: _C.text)),
                ],
              ),
            );
          }).toList(),
          onChanged: (v) {
            if (v != null) setState(() => _selectedType = v);
          },
        ),
      ),
    );
  }

  IconData _typeIcon(String type) {
    switch (type) {
      case 'Apartment':  return Icons.apartment_rounded;
      case 'House':      return Icons.home_rounded;
      case 'Studio':     return Icons.meeting_room_rounded;
      case 'Condo':      return Icons.business_rounded;
      case 'Duplex':     return Icons.house_rounded;
      case 'Townhouse':  return Icons.holiday_village_rounded;
      case 'Villa':      return Icons.villa_rounded;
      case 'Penthouse':  return Icons.cloud_rounded;
      default:           return Icons.apartment_rounded;
    }
  }

  // ── Stepper card ──────────────────────────────────────────────────────────

  Widget _buildStepperCard({
    required String label,
    required IconData icon,
    required int value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: _C.primary),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _C.textSub,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Decrement
              GestureDetector(
                onTap: onDecrement,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: _C.inputBg,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _C.inputBorder, width: 1),
                  ),
                  child: const Icon(Icons.remove_rounded, size: 18, color: _C.textSub),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '$value',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: _C.text,
                ),
              ),
              const SizedBox(width: 16),
              // Increment
              GestureDetector(
                onTap: onIncrement,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: _C.primaryLo,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: _C.primary.withOpacity(0.25), width: 1),
                  ),
                  child: const Icon(Icons.add_rounded, size: 18, color: _C.primary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Availability toggle ───────────────────────────────────────────────────

  Widget _buildAvailabilityToggle() {
    return GestureDetector(
      onTap: () => setState(() => _isAvailable = !_isAvailable),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: _isAvailable ? _C.tagOccupied : _C.inputBg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isAvailable
                    ? Icons.check_circle_rounded
                    : Icons.cancel_outlined,
                color: _isAvailable
                    ? _C.tagOccupiedText
                    : _C.textLight,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _isAvailable ? 'Available for rent' : 'Not available',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _C.text,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _isAvailable
                        ? 'Tenants can see and inquire about this property'
                        : 'Property is hidden from search results',
                    style: const TextStyle(fontSize: 11, color: _C.textSub),
                  ),
                ],
              ),
            ),
            Switch.adaptive(
              value: _isAvailable,
              onChanged: (v) => setState(() => _isAvailable = v),
              activeColor: _C.primary,
              inactiveTrackColor: _C.inputBg,
            ),
          ],
        ),
      ),
    );
  }

  // ── Submit button — mirrors dashboard "Add Property" CTA ─────────────────

  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Property listed successfully!'),
            backgroundColor: _C.primary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        Navigator.of(context).pop();
      },
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          color: _C.primary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _C.primary.withOpacity(0.30),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'List Property',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}