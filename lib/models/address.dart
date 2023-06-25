import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  GeoPoint location;
  String city;
  String state;
  String country;
  int zipCode;
  Address({
    required this.location,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });

  Address copyWith({
    // GeoPoint? location,
    String? city,
    String? state,
    String? country,
    int? zipCode,
  }) {
    return Address(
      location: location,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location,
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      location: map['location'] as GeoPoint,
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
    return 'Address(location: $location, city: $city, state: $state, country: $country, zipCode: $zipCode)';
  }

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;

    return other.location == location &&
        other.city == city &&
        other.state == state &&
        other.country == country &&
        other.zipCode == zipCode;
  }

  @override
  int get hashCode {
    return location.hashCode ^
        city.hashCode ^
        state.hashCode ^
        country.hashCode ^
        zipCode.hashCode;
  }
}