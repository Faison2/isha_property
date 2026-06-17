import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  static const Color _primary = Color(0xFFC87941);

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _locationController = TextEditingController();
  final _areaController = TextEditingController();

  String _selectedType = 'Apartment';
  int _bedrooms = 1;
  int _bathrooms = 1;
  bool _isAvailable = true;

  final List<String> _propertyImages = [];
  final List<String> _propertyTypes = [
    'Apartment',
    'House',
    'Studio',
    'Condo',
    'Duplex',
    'Townhouse',
    'Villa',
    'Penthouse',
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0A00),
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
                    _buildSectionTitle('Photos'),
                    const SizedBox(height: 12),
                    _buildImageGrid(),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Property Details'),
                    const SizedBox(height: 12),
                    _buildTextField(
                      controller: _titleController,
                      hint: 'Property title',
                      prefixIcon: Icons.edit_rounded,
                    ),
                    const SizedBox(height: 12),
                    _buildTypeDropdown(),
                    const SizedBox(height: 12),
                    _buildTextField(
                      controller: _descriptionController,
                      hint: 'Description',
                      prefixIcon: Icons.description_outlined,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Pricing & Location'),
                    const SizedBox(height: 12),
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
                        const SizedBox(width: 12),
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
                    const SizedBox(height: 12),
                    _buildTextField(
                      controller: _locationController,
                      hint: 'Location',
                      prefixIcon: Icons.location_on_outlined,
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Layout'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStepper(
                            label: 'Bedrooms',
                            value: _bedrooms,
                            onIncrement: () =>
                                setState(() => _bedrooms++),
                            onDecrement: () => setState(
                                () => _bedrooms = (_bedrooms > 0 ? _bedrooms - 1 : 0)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStepper(
                            label: 'Bathrooms',
                            value: _bathrooms,
                            onIncrement: () =>
                                setState(() => _bathrooms++),
                            onDecrement: () => setState(
                                () => _bathrooms = (_bathrooms > 0 ? _bathrooms - 1 : 0)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildAvailabilityToggle(),
                    const SizedBox(height: 32),
                    _buildSubmitButton(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 0.5,
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(),
          const Text(
            'Add Property',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 16,
          decoration: BoxDecoration(
            color: _primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildImageGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ...List.generate(_propertyImages.length, (i) {
              return _buildImageItem(i);
            }),
            if (_propertyImages.length < 6) _buildAddImageButton(),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '${_propertyImages.length}/6 photos  ·  Tap to add photos of your property',
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withOpacity(0.35),
          ),
        ),
      ],
    );
  }

  Widget _buildImageItem(int index) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: _primary.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _primary.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.image_rounded,
              color: Color(0xFFC87941),
              size: 36,
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () {
              setState(() => _propertyImages.removeAt(index));
            },
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Colors.black87,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close_rounded,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddImageButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _propertyImages.add('placeholder_${_propertyImages.length}');
        });
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.15),
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              size: 28,
              color: Colors.white.withOpacity(0.4),
            ),
            const SizedBox(height: 4),
            Text(
              'Add Photo',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData prefixIcon,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withOpacity(0.15),
          width: 0.8,
        ),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 14, color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.white.withOpacity(0.4),
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildTypeDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withOpacity(0.15),
          width: 0.8,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedType,
          isExpanded: true,
          dropdownColor: const Color(0xFF2D1500),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white.withOpacity(0.4),
          ),
          style: const TextStyle(fontSize: 14, color: Colors.white),
          items: _propertyTypes.map((type) {
            return DropdownMenuItem(
              value: type,
              child: Row(
                children: [
                  Icon(
                    _typeIcon(type),
                    size: 20,
                    color: const Color(0xFFC87941),
                  ),
                  const SizedBox(width: 10),
                  Text(type),
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
      case 'Apartment':
        return Icons.apartment_rounded;
      case 'House':
        return Icons.home_rounded;
      case 'Studio':
        return Icons.meeting_room_rounded;
      case 'Condo':
        return Icons.business_rounded;
      case 'Duplex':
        return Icons.house_rounded;
      case 'Townhouse':
        return Icons.holiday_village_rounded;
      case 'Villa':
        return Icons.villa_rounded;
      case 'Penthouse':
        return Icons.cloud_rounded;
      default:
        return Icons.apartment_rounded;
    }
  }

  Widget _buildStepper({
    required String label,
    required int value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withOpacity(0.15),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.55),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onDecrement,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.remove_rounded,
                    size: 18,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Text(
                '$value',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 14),
              GestureDetector(
                onTap: onIncrement,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: _primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    size: 18,
                    color: Color(0xFFC87941),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilityToggle() {
    return GestureDetector(
      onTap: () => setState(() => _isAvailable = !_isAvailable),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withOpacity(0.15),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            _isAvailable ? Icons.check_circle_rounded : Icons.cancel_outlined,
              color: _isAvailable ? const Color(0xFF4CAF50) : Colors.white.withOpacity(0.4),
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _isAvailable ? 'Available for rent' : 'Mark as unavailable',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _isAvailable
                        ? 'Tenants can see and inquire about this property'
                        : 'Hide this property from search results',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 44,
              height: 24,
              child: Switch.adaptive(
                value: _isAvailable,
                onChanged: (v) => setState(() => _isAvailable = v),
                activeColor: _primary,
                inactiveTrackColor: Colors.white.withOpacity(0.15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Property listed successfully!'),
            backgroundColor: _primary,
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
          color: _primary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _primary.withOpacity(0.35),
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
