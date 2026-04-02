class Product {
  final String uuid; // _id
  final int id;
  final String name;
  final String description;
  final List<String> originType;
  final String seriesTitle;
  final List<String> characters;
  final List<String> category;
  final String manufacturer;
  final double price;
  final String currency;
  final String scale;
  final List<String> material;
  final String status;
  final String releaseDate;
  final String thumbnail;
  final List<String> images;
  final List<String> tags;

  int? qty; // ! Quantity, excluded from JSON, used for Cart

  Product({
    required this.uuid, // _id
    required this.id,
    required this.name,
    required this.description,
    required this.originType,
    required this.seriesTitle,
    required this.characters,
    required this.category,
    required this.manufacturer,
    required this.price,
    required this.currency,
    required this.scale,
    required this.material,
    required this.status,
    required this.releaseDate,
    required this.thumbnail,
    required this.images,
    required this.tags,
    this.qty = 0,
  });

  // ! JSON -> List
  factory Product.fromJson(Map<String, dynamic> json) {
    List<String> parseList(dynamic list) {
      if (list == null || list is! List) return [];
      return list.map((e) => e.toString()).toList();
    }

    return Product(
      uuid: json['_id']?.toString() ?? '',
      id: (json['id'] as num? ?? 0).toInt(),
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      originType: parseList(json['origin_type']),
      seriesTitle: json['series_title']?.toString() ?? '',
      characters: parseList(json['characters']),
      category: parseList(json['category']),
      manufacturer: json['manufacturer'],
      price: (json['price'] as num? ?? 0.0).toDouble(),
      currency: json['currency']?.toString() ?? '',
      scale: json['scale']?.toString() ?? '',
      material: parseList(json['material']),
      status: json['status']?.toString() ?? '',
      releaseDate: json['release_date']?.toString() ?? '',
      thumbnail: json['thumbnail']?.toString() ?? '',
      images: parseList(json['images']),
      tags: parseList(json['tags']),
    );
  }

  // ! List -> JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': uuid,
      'id': id,
      'name': name,
      'description': description,
      'origin_type': originType,
      'series_title': seriesTitle,
      'characters': characters,
      'category': category,
      'manufacturer': manufacturer,
      'price': price,
      'currency': currency,
      'scale': scale,
      'material': material,
      'status': status,
      'release_date': releaseDate,
      'thumbnail': thumbnail,
      'images': images,
      'tags': tags,
    };
  }

  Product copyWith({int? qty}) {
    return Product(
      uuid: uuid,
      id: id,
      name: name,
      description: description,
      originType: originType,
      seriesTitle: seriesTitle,
      characters: characters,
      category: category,
      manufacturer: manufacturer,
      price: price,
      currency: currency,
      scale: scale,
      material: material,
      status: status,
      releaseDate: releaseDate,
      thumbnail: thumbnail,
      images: images,
      tags: tags,
      qty: qty ?? this.qty,
    );
  }
}
