import 'package:flutter/material.dart';
import 'package:stayconnect/screens/tenant/dashboad/property_tab.dart';


class _C {
  static const bg          = Color(0xFFF5F4FB);
  static const bgCard      = Color(0xFFFFFFFF);
  static const primary     = Color(0xFF7B6FD0);
  static const primaryLo   = Color(0x1A7B6FD0);
  static const amber       = Color(0xFFC87941);
  static const amberLo     = Color(0x1AC87941);
  static const text        = Color(0xFF1A1A2E);
  static const textSub     = Color(0xFF8A8FA8);
  static const textLight   = Color(0xFFAAAAAA);
  static const divider     = Color(0xFFF0EBF8);
  static const inputBg     = Color(0xFFF0EEF9);
  static const inputBorder = Color(0xFFE0DCF5);
}

// ── Location data ─────────────────────────────────────────────────────────────
class _City {
  final String name;
  final String emoji;
  final List<String> suburbs;
  const _City({required this.name, required this.emoji, required this.suburbs});
}

const _cities = [
  _City(name: 'Harare',   emoji: '🏙️', suburbs: ['All Areas','Madokero','Mbare','Avondale','Borrowdale','Glen View','Highfield','Mount Pleasant','Eastlea','Kuwadzana']),
  _City(name: 'Bulawayo', emoji: '🌆', suburbs: ['All Areas','Nkulumane','Mpopoma','Cowdray Park','Pumula','Sunninghill','Matsheumhlope']),
  _City(name: 'Kwekwe',   emoji: '🏘️', suburbs: ['All Areas','Mbizo','Redcliff','Amaveni','Newton West','Globe & Phoenix']),
  _City(name: 'Mutare',   emoji: '🌄', suburbs: ['All Areas','Dangamvura','Chikanga','Sakubva','Hobhouse','Fern Valley']),
  _City(name: 'Gweru',    emoji: '🏗️', suburbs: ['All Areas','Mkoba','Mambo','Ascot','Southdowns','Woodlands']),
  _City(name: 'Masvingo', emoji: '🏛️', suburbs: ['All Areas','Mucheke','Rhodene','Runyararo','Target Kopje']),
];

const _propertyTypes = ['All Types', 'Apartment', 'House', 'Studio', 'Room', 'Office'];

// ── Sample listings ────────────────────────────────────────────────────────────
class _PropertyItem {
  final String title, type, price, suburb, city, area;
  final int beds, baths;
  const _PropertyItem({
    required this.title, required this.type, required this.price,
    required this.suburb, required this.city,
    required this.beds, required this.baths, required this.area,
  });
}

const _properties = [
  _PropertyItem(title: 'Modern 2-Bed Flat',   type: 'Apartment', price: 'USD 350/mo', suburb: 'Avondale',      city: 'Harare',   beds: 2, baths: 1, area: '850 sqft'),
  _PropertyItem(title: 'Cosy Room',           type: 'Room',      price: 'USD 80/mo',  suburb: 'Mbare',         city: 'Harare',   beds: 1, baths: 1, area: '200 sqft'),
  _PropertyItem(title: 'Executive House',     type: 'House',     price: 'USD 750/mo', suburb: 'Borrowdale',    city: 'Harare',   beds: 4, baths: 3, area: '2,200 sqft'),
  _PropertyItem(title: 'Family Home',         type: 'House',     price: 'USD 420/mo', suburb: 'Madokero',      city: 'Harare',   beds: 3, baths: 2, area: '1,400 sqft'),
  _PropertyItem(title: 'Upmarket Studio',     type: 'Studio',    price: 'USD 280/mo', suburb: 'Mount Pleasant',city: 'Harare',   beds: 0, baths: 1, area: '420 sqft'),
  _PropertyItem(title: 'Office Space',        type: 'Office',    price: 'USD 600/mo', suburb: 'Eastlea',       city: 'Harare',   beds: 0, baths: 2, area: '1,100 sqft'),
  _PropertyItem(title: 'Townhouse',           type: 'Apartment', price: 'USD 200/mo', suburb: 'Nkulumane',     city: 'Bulawayo', beds: 2, baths: 1, area: '900 sqft'),
  _PropertyItem(title: '3-Bed Suburban Home', type: 'House',     price: 'USD 310/mo', suburb: 'Mpopoma',       city: 'Bulawayo', beds: 3, baths: 2, area: '1,300 sqft'),
  _PropertyItem(title: 'Mbizo Apartment',     type: 'Apartment', price: 'USD 150/mo', suburb: 'Mbizo',         city: 'Kwekwe',   beds: 2, baths: 1, area: '750 sqft'),
  _PropertyItem(title: 'Chikanga Cottage',    type: 'House',     price: 'USD 180/mo', suburb: 'Chikanga',      city: 'Mutare',   beds: 2, baths: 1, area: '850 sqft'),
  _PropertyItem(title: 'Mkoba Starter Home',  type: 'House',     price: 'USD 120/mo', suburb: 'Mkoba',         city: 'Gweru',    beds: 2, baths: 1, area: '700 sqft'),
  _PropertyItem(title: 'Mucheke Rooms',       type: 'Room',      price: 'USD 60/mo',  suburb: 'Mucheke',       city: 'Masvingo', beds: 1, baths: 1, area: '180 sqft'),
];

// ─────────────────────────────────────────────────────────────────────────────
//  EXPLORE TAB
// ─────────────────────────────────────────────────────────────────────────────
class ExploreTab extends StatefulWidget {
  /// Optional type filter pre-applied when navigating from Home categories.
  /// Matches values in [_propertyTypes] e.g. 'Apartment', 'House', 'Room'.
  /// Pass 'All Types' or null to show everything.
  final String? initialTypeFilter;

  /// Called once the widget has consumed [initialTypeFilter] so the parent
  /// can clear it (avoids re-applying on hot reload / revisit).
  final VoidCallback? onFilterConsumed;

  const ExploreTab({
    super.key,
    this.initialTypeFilter,
    this.onFilterConsumed,
  });

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  int _selectedCityIndex   = 0;
  int _selectedSuburbIndex = 0;
  int _selectedTypeIndex   = 0;

  bool _showFilters = false;

  static const _allCity = _City(name: 'All Cities', emoji: '🌍', suburbs: ['All Areas']);
  List<_City> get _cityList => [_allCity, ..._cities];
  _City get _currentCity => _cityList[_selectedCityIndex];

  @override
  void initState() {
    super.initState();
    _applyInitialFilter();
  }

  @override
  void didUpdateWidget(ExploreTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Re-apply if a new filter arrived (user tapped a different category)
    if (widget.initialTypeFilter != null &&
        widget.initialTypeFilter != oldWidget.initialTypeFilter) {
      _applyInitialFilter();
    }
  }

  void _applyInitialFilter() {
    final filter = widget.initialTypeFilter;
    if (filter == null) return;

    final idx = _propertyTypes.indexOf(filter);

    // Apply the filter to local state immediately (safe — we're in initState
    // or didUpdateWidget, not inside build itself)
    _selectedTypeIndex   = idx >= 0 ? idx : 0;
    _selectedCityIndex   = 0;
    _selectedSuburbIndex = 0;
    _query               = '';
    _searchCtrl.clear();
    _showFilters         = false;

    // Notify the parent AFTER the current build frame completes.
    // Calling setState on TenantDashboard synchronously here would trigger
    // "setState() called during build" because ExploreTab is still building.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.onFilterConsumed?.call();
    });
  }

  List<_PropertyItem> get _filtered {
    var result = _properties.toList();

    if (_selectedCityIndex > 0) {
      final cityName = _currentCity.name;
      result = result.where((p) => p.city == cityName).toList();
      if (_selectedSuburbIndex > 0) {
        final suburb = _currentCity.suburbs[_selectedSuburbIndex];
        result = result.where((p) => p.suburb == suburb).toList();
      }
    }

    if (_selectedTypeIndex > 0) {
      final type = _propertyTypes[_selectedTypeIndex];
      result = result.where((p) => p.type == type).toList();
    }

    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      result = result.where((p) =>
      p.title.toLowerCase().contains(q) ||
          p.suburb.toLowerCase().contains(q) ||
          p.city.toLowerCase().contains(q)).toList();
    }

    return result;
  }

  String get _activeFilterSummary {
    final parts = <String>[];
    parts.add(_currentCity.name);
    if (_selectedCityIndex > 0 && _selectedSuburbIndex > 0) {
      parts.add(_currentCity.suburbs[_selectedSuburbIndex]);
    }
    parts.add(_propertyTypes[_selectedTypeIndex]);
    return parts.join(' · ');
  }

  bool get _hasActiveFilter =>
      _selectedCityIndex > 0 || _selectedSuburbIndex > 0 ||
          _selectedTypeIndex > 0 || _query.isNotEmpty;

  void _resetFilters() => setState(() {
    _selectedCityIndex   = 0;
    _selectedSuburbIndex = 0;
    _selectedTypeIndex   = 0;
    _query               = '';
    _searchCtrl.clear();
  });

  void _onCityChanged(int idx) => setState(() {
    _selectedCityIndex   = idx;
    _selectedSuburbIndex = 0;
  });

  @override
  void dispose() {
    _searchCtrl.dispose();
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

            // ── Header ────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Explore',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: _C.text)),
                      const SizedBox(height: 2),
                      Text('${filtered.length} of ${_properties.length} properties',
                          style: const TextStyle(fontSize: 13, color: _C.textSub)),
                    ],
                  ),
                  const Spacer(),
                  // Active type badge — shows which category was tapped
                  if (_selectedTypeIndex > 0 && !_showFilters) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: _C.primaryLo,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.category_rounded, size: 13, color: _C.primary),
                          const SizedBox(width: 5),
                          Text(
                            _propertyTypes[_selectedTypeIndex],
                            style: const TextStyle(fontSize: 12, color: _C.primary, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () => setState(() => _selectedTypeIndex = 0),
                            child: const Icon(Icons.close_rounded, size: 13, color: _C.primary),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  // Filter toggle button
                  GestureDetector(
                    onTap: () => setState(() => _showFilters = !_showFilters),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: _showFilters ? _C.primary : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _showFilters ? _C.primary : _C.inputBorder),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.tune_rounded, size: 16, color: _showFilters ? Colors.white : _C.primary),
                          const SizedBox(width: 6),
                          Text('Filter',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700,
                                  color: _showFilters ? Colors.white : _C.primary)),
                          if (_hasActiveFilter) ...[
                            const SizedBox(width: 6),
                            Container(
                              width: 8, height: 8,
                              decoration: const BoxDecoration(color: _C.amber, shape: BoxShape.circle),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ── Search bar ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: _C.bgCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _C.inputBorder),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))
                  ],
                ),
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (v) => setState(() => _query = v),
                  style: const TextStyle(fontSize: 14, color: _C.text),
                  decoration: InputDecoration(
                    hintText: 'Search city, suburb or property name…',
                    hintStyle: const TextStyle(fontSize: 13, color: _C.textLight),
                    prefixIcon: const Icon(Icons.search_rounded, size: 20, color: _C.textLight),
                    suffixIcon: _query.isNotEmpty
                        ? GestureDetector(
                      onTap: () => setState(() { _query = ''; _searchCtrl.clear(); }),
                      child: const Icon(Icons.close_rounded, size: 18, color: _C.textLight),
                    )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                  ),
                ),
              ),
            ),

            // ── Collapsible filter panel ──────────────────────────────────
            AnimatedSize(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeInOut,
              child: _showFilters ? _buildFilterPanel() : const SizedBox.shrink(),
            ),

            // ── Active filter pill (panel closed) ─────────────────────────
            if (!_showFilters && _hasActiveFilter && _selectedTypeIndex == 0)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(color: _C.primaryLo, borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.filter_list_rounded, size: 14, color: _C.primary),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(_activeFilterSummary,
                            style: const TextStyle(fontSize: 12, color: _C.primary, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _resetFilters,
                        child: const Icon(Icons.close_rounded, size: 14, color: _C.primary),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 14),

            // ── Property list ─────────────────────────────────────────────
            Expanded(
              child: filtered.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
                physics: const BouncingScrollPhysics(),
                itemCount: filtered.length,
                itemBuilder: (_, i) => _PropertyCard(property: filtered[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Filter panel ─────────────────────────────────────────────────────────
  Widget _buildFilterPanel() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(color: _C.primaryLo, borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.location_on_rounded, size: 16, color: _C.primary),
                ),
                const SizedBox(width: 10),
                const Text('Filter by Location',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _C.text)),
                const Spacer(),
                if (_hasActiveFilter)
                  GestureDetector(
                    onTap: _resetFilters,
                    child: Text('Clear all',
                        style: TextStyle(fontSize: 12, color: _C.amber, fontWeight: FontWeight.w700)),
                  ),
              ],
            ),
          ),

          _FilterLabel('City'),
          SizedBox(
            height: 36,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16, right: 8),
              itemCount: _cityList.length,
              itemBuilder: (_, i) {
                final selected = i == _selectedCityIndex;
                return GestureDetector(
                  onTap: () => _onCityChanged(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: selected ? _C.primary : _C.inputBg,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: selected
                          ? [BoxShadow(color: _C.primary.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2))]
                          : null,
                    ),
                    child: Row(
                      children: [
                        Text(_cityList[i].emoji, style: const TextStyle(fontSize: 12)),
                        const SizedBox(width: 5),
                        Text(_cityList[i].name,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600,
                                color: selected ? Colors.white : _C.textSub)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 14),

          _FilterLabel('Neighbourhood'),
          SizedBox(
            height: 36,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16, right: 8),
              itemCount: _currentCity.suburbs.length,
              itemBuilder: (_, i) {
                final selected = i == _selectedSuburbIndex;
                final enabled = _selectedCityIndex > 0;
                return GestureDetector(
                  onTap: enabled ? () => setState(() => _selectedSuburbIndex = i) : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: !enabled
                          ? _C.inputBg.withOpacity(0.5)
                          : selected
                          ? _C.amber
                          : const Color(0xFFFFF6EF),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: (enabled && selected)
                          ? [BoxShadow(color: _C.amber.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2))]
                          : null,
                    ),
                    child: Text(
                      _currentCity.suburbs[i],
                      style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600,
                        color: !enabled ? _C.textLight : selected ? Colors.white : _C.amber,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 14),

          _FilterLabel('Property Type'),
          SizedBox(
            height: 36,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16, right: 8),
              itemCount: _propertyTypes.length,
              itemBuilder: (_, i) {
                final selected = i == _selectedTypeIndex;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTypeIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: selected ? const Color(0xFF1A1A2E) : _C.inputBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(_propertyTypes[i],
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600,
                            color: selected ? Colors.white : _C.textSub)),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 14),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(color: _C.bg, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const Icon(Icons.filter_list_rounded, size: 16, color: _C.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(_activeFilterSummary,
                        style: const TextStyle(fontSize: 12, color: _C.primary, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _showFilters = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(color: _C.primary, borderRadius: BorderRadius.circular(10)),
                      child: const Text('Apply',
                          style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
            decoration: const BoxDecoration(color: _C.primaryLo, shape: BoxShape.circle),
            child: const Icon(Icons.search_off_rounded, size: 36, color: _C.primary),
          ),
          const SizedBox(height: 18),
          const Text('No properties found',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: _C.text)),
          const SizedBox(height: 6),
          const Text('Try adjusting your search or filters',
              style: TextStyle(fontSize: 13, color: _C.textSub)),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _resetFilters,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(color: _C.primary, borderRadius: BorderRadius.circular(14)),
              child: const Text('Clear Filters',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Label widget ──────────────────────────────────────────────────────────────
class _FilterLabel extends StatelessWidget {
  final String text;
  const _FilterLabel(this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 16, bottom: 6),
    child: Text(text,
        style: TextStyle(
            fontSize: 11, fontWeight: FontWeight.w600,
            color: _C.textSub.withOpacity(0.8), letterSpacing: 0.4)),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
//  Property card
// ─────────────────────────────────────────────────────────────────────────────
class _PropertyCard extends StatelessWidget {
  final _PropertyItem property;
  const _PropertyCard({required this.property});

  IconData get _typeIcon {
    switch (property.type) {
      case 'House':  return Icons.home_rounded;
      case 'Studio': return Icons.meeting_room_rounded;
      case 'Room':   return Icons.bed_rounded;
      case 'Office': return Icons.business_rounded;
      default:       return Icons.apartment_rounded;
    }
  }

  Color get _typeColor {
    switch (property.type) {
      case 'House':  return const Color(0xFFC87941);
      case 'Studio': return const Color(0xFF3B9A5A);
      case 'Room':   return const Color(0xFF5A8FD0);
      case 'Office': return const Color(0xFF888888);
      default:       return const Color(0xFF7B6FD0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => PropertyDetailScreen(listing: _toListing(property))),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Container(
          decoration: BoxDecoration(
            color: _C.bgCard,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 14, offset: const Offset(0, 3))
            ],
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
                      decoration: BoxDecoration(
                        color: _typeColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(_typeIcon, size: 30, color: _typeColor),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(property.title,
                                    style: const TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.w700, color: _C.text)),
                              ),
                              const Icon(Icons.favorite_outline_rounded, size: 20, color: _C.textLight),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: _typeColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(property.type,
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w700, color: _typeColor)),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.location_on_rounded, size: 13, color: _C.primary),
                              const SizedBox(width: 3),
                              Text('${property.suburb}, ${property.city}',
                                  style: const TextStyle(fontSize: 12, color: _C.textSub)),
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
                    if (property.beds > 0) ...[
                      _Chip(icon: Icons.bed_outlined, label: '${property.beds} Bed'),
                      const SizedBox(width: 12),
                    ],
                    _Chip(icon: Icons.bathtub_outlined, label: '${property.baths} Bath'),
                    const SizedBox(width: 12),
                    _Chip(icon: Icons.square_foot_rounded, label: property.area),
                    const Spacer(),
                    Text(property.price,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w800, color: _C.primary)),
                  ],
                ),
              ),

              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF8F7FD),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
                ),
                child: Row(
                  children: [
                    _ActionBtn(icon: Icons.chat_bubble_outline_rounded, label: 'Inquire',  color: _C.primary, onTap: () {}),
                    Container(width: 1, height: 40, color: _C.divider),
                    _ActionBtn(icon: Icons.calendar_today_rounded,      label: 'Viewing',  color: _C.primary, onTap: () {}),
                    Container(width: 1, height: 40, color: _C.divider),
                    _ActionBtn(icon: Icons.share_outlined,              label: 'Share',    onTap: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),   // Padding
    );   // GestureDetector
  }
}

class _Chip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Chip({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 14, color: _C.textLight),
      const SizedBox(width: 4),
      Text(label, style: const TextStyle(fontSize: 12, color: _C.textSub)),
    ],
  );
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
              Text(label,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: c)),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Helper: convert _PropertyItem to PropertyListing for navigation ────────────
PropertyListing _toListing(_PropertyItem p) {
  // Find a matching full listing from sampleListings, fallback to stub
  final match = sampleListings.where(
        (l) => l.title == p.title && l.suburb == p.suburb,
  );
  if (match.isNotEmpty) return match.first;

  // Stub for items not yet in sampleListings
  return PropertyListing(
    id: p.title.hashCode.toString(),
    title: p.title,
    type: p.type,
    price: p.price,
    suburb: p.suburb,
    city: p.city,
    beds: p.beds,
    baths: p.baths,
    area: p.area,
    deposit: 'USD ${int.tryParse(p.price.replaceAll(RegExp(r'[^0-9]'), '')) != null ? (int.parse(p.price.replaceAll(RegExp(r'[^0-9]'), '')) * 2) : 0}',
    description: 'A great ${p.type.toLowerCase()} located in ${p.suburb}, ${p.city}. Contact the landlord for more details.',
    imagePaths: const ['assets/images/property1.jpg'],
    amenities: const ['Secure Parking', 'Water Included', 'Security Guard'],
    latitude: -17.8292,
    longitude: 31.0522,
    landlordName: 'Property Manager',
    landlordPhone: '+263771000000',
    landlordWhatsApp: '+263771000000',
    availableFrom: 'Immediately',
  );
}