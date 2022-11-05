import 'dart:convert';

class Address {
  String addLine1;
  String addLine2;
  String city;
  String state;
  String country;
  int zipCode;
  Address({
    required this.addLine1,
    required this.addLine2,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });

  Address copyWith({
    String? addLine1,
    String? addLine2,
    String? city,
    String? state,
    String? country,
    int? zipCode,
  }) {
    return Address(
      addLine1: addLine1 ?? this.addLine1,
      addLine2: addLine2 ?? this.addLine2,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addLine1': addLine1,
      'addLine2': addLine2,
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      addLine1: map['addLine1'] as String,
      addLine2: map['addLine2'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      country: map['country'] as String,
      zipCode: map['zipCode'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Address(addLine1: $addLine1, addLine2: $addLine2, city: $city, state: $state, country: $country, zipCode: $zipCode)';
  }

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;

    return other.addLine1 == addLine1 &&
        other.addLine2 == addLine2 &&
        other.city == city &&
        other.state == state &&
        other.country == country &&
        other.zipCode == zipCode;
  }

  @override
  int get hashCode {
    return addLine1.hashCode ^
        addLine2.hashCode ^
        city.hashCode ^
        state.hashCode ^
        country.hashCode ^
        zipCode.hashCode;
  }
}
