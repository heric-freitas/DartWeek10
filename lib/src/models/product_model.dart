import 'dart:convert';

class ProductModel {
  final int? id;
  final String name;
  final String description;
  final double price;
  final String image;
  final bool enabled; 
  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.enabled,
  });

  ProductModel copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    String? image,
    bool? enabled,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      enabled: enabled ?? this.enabled,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'enabled': enabled,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      image: map['image'] as String,
      enabled: map['enabled'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, description: $description, price: $price, image: $image, enabled: $enabled)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.price == price &&
      other.image == image &&
      other.enabled == enabled;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      price.hashCode ^
      image.hashCode ^
      enabled.hashCode;
  }
}
