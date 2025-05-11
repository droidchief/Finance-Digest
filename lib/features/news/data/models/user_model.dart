import 'dart:convert';

class UserModel {
  final String firstName;
  final String lastName;

  UserModel({
    required this.firstName,
    required this.lastName,
  });

  UserModel copyWith({
    String? firstName,
    String? lastName,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(firstName: $firstName, lastName: $lastName)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.firstName == firstName &&
      other.lastName == lastName;
  }

  @override
  int get hashCode => firstName.hashCode ^ lastName.hashCode;
}
