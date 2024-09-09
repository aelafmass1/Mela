// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String? phoneNumber;
  final String? password;
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? countryCode;
  UserModel({
    this.phoneNumber,
    this.password,
    this.firstName,
    this.lastName,
    this.email,
    this.countryCode,
  });

  UserModel copyWith({
    String? phoneNumber,
    String? password,
    String? firstName,
    String? lastName,
    String? email,
    int? countryCode,
  }) {
    return UserModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phoneNumber': int.parse(phoneNumber ?? ''),
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'countryCode': countryCode,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      countryCode:
          map['countryCode'] != null ? map['countryCode'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(phoneNumber: $phoneNumber, password: $password, firstName: $firstName, lastName: $lastName, email: $email, countryCode: $countryCode)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.phoneNumber == phoneNumber &&
        other.password == password &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.countryCode == countryCode;
  }

  @override
  int get hashCode {
    return phoneNumber.hashCode ^
        password.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        countryCode.hashCode;
  }
}
