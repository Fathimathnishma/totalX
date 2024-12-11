import 'package:cloud_firestore/cloud_firestore.dart';

class Usermodel {
  String name;
  int age;
  List <dynamic>search;
  Timestamp? createdAt;
  String ? id;

  Usermodel(
      {required this.name,
      required this.age,
      required this.search,
      this.id,
      this.createdAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
      "search": search,
      "createdAt": createdAt,
      "id":id
    };
  }

  factory Usermodel.fromMap(Map<String, dynamic> map) {
    return Usermodel(
        name: map['name'] as String,
        age: map['age'] is int
            ? map["age"] as int
            : int.tryParse(map["age"].toString()) ?? 0,
        search: List<String>.from(map["search"] ?? []), 
        id:map["id"] as String,
        createdAt: map["createdAt"] as Timestamp,
       );
  }

  Usermodel copyWith({
    String? name,
    int? age,
    List? search,
    String? id,
    Timestamp? createdAt,
  }) {  
    return Usermodel(
      name: name ?? this.name,
      age: age ?? this.age,
      search: search ?? this.search,
      id: id?? this.id,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
