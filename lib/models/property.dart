class Property {
  final String id;
  final String title;
  final String type;
  final String description;
  final double price;
  final String location;
  final int bedrooms;
  final int bathrooms;
  final double area;
  final List<String> imageUrls;
  final bool isAvailable;
  final DateTime listedDate;

  Property({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.price,
    required this.location,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.imageUrls,
    this.isAvailable = true,
    DateTime? listedDate,
  }) : listedDate = listedDate ?? DateTime.now();
}
