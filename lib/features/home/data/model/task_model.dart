import 'package:cloud_firestore/cloud_firestore.dart';

class Usermodel {
  String name;
  int age;
  List search;
  Timestamp? createdAt;
  Usermodel(
      {required this.name,
      required this.age,
      required this.search,
      this.createdAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
      "search": search,
      "createdAt": FieldValue.serverTimestamp(),
    };
  }

  factory Usermodel.fromMap(Map<String, dynamic> map) {
    return Usermodel(
        name: map['name'] as String,
        age: map['age'] is int
            ? map["age"] as int
            : int.tryParse(map["age"].toString()) ?? 0,
        search: List<String>.from(map["search"] ?? []),
        createdAt: map["createdAt"]);
  }

  Usermodel copyWith({
    String? name,
    int? age,
    List? search,
    Timestamp? createdAt,
  }) {
    return Usermodel(
      name: name ?? this.name,
      age: age ?? this.age,
      search: search ?? this.search,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
