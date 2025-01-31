import 'name_id.dart';

class Product {
  int? id;
  String? name;
  String? description;
  double? price;
  String? status;
  int? available;
  bool? isAvailable;
  NameId? category;
  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.status,
    this.available,
    this.isAvailable,
    this.category,
  });

  Product copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    String? status,
    int? available,
    bool? isAvailable,
    NameId? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      status: status ?? this.status,
      available: available ?? this.available,
      isAvailable: isAvailable ?? this.isAvailable,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'status': status,
      'available': available,
      'isAvailable': isAvailable,
      'category': category?.toMap(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
      status: map['status'] != null ? map['status'] as String : null,
      available: map['available'] != null ? map['available'] as int : null,
      isAvailable:
          map['isAvailable'] != null ? map['isAvailable'] as bool : null,
      category: map['category'] != null
          ? NameId.fromMap(map['category'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: "$name", description: "$description", price: $price, status: "$status", available: $available, isAvailable: $isAvailable, category: $category)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.price == price &&
        other.status == status &&
        other.available == available &&
        other.isAvailable == isAvailable &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        status.hashCode ^
        available.hashCode ^
        isAvailable.hashCode ^
        category.hashCode;
  }
}
