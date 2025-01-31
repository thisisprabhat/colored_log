class NameId {
  int? id;
  String? name;
  NameId({this.id, this.name});

  NameId copyWith({int? id, String? name}) {
    return NameId(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name};
  }

  factory NameId.fromMap(Map<String, dynamic> map) {
    return NameId(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  @override
  String toString() => 'NameId(id: $id, name: "$name")';

  @override
  bool operator ==(covariant NameId other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
