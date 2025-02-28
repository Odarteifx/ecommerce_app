import 'dart:convert';

class ShippingAddress {
  final String? addressId;
  final String fullName;
  final String phoneNumber;
  final String addressLine;
  final String city;
  final String? state;
  final String country;
  ShippingAddress({
    this.addressId,
    required this.fullName,
    required this.phoneNumber,
    required this.addressLine,
    required this.city,
    this.state,
    required this.country,
  });

  ShippingAddress copyWith({
    String? addressId,
    String? fullName,
    String? phoneNumber,
    String? addressLine,
    String? city,
    String? state,
    String? country,
  }) {
    return ShippingAddress(
      addressId: addressId ?? this.addressId,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      addressLine: addressLine ?? this.addressLine,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addressId': addressId,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'addressLine': addressLine,
      'city': city,
      'state': state,
      'country': country,
    };
  }

  factory ShippingAddress.fromMap(Map<String, dynamic> map, String id) {
    return ShippingAddress(
      addressId: id,
      fullName: map['fullName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      addressLine: map['addressLine'] as String,
      city: map['city'] as String,
      state: map['state'] != null ? map['state'] as String : null,
      country: map['country'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShippingAddress.fromJson(String source) =>
      ShippingAddress.fromMap(json.decode(source) as Map<String, dynamic>, '');

  @override
  String toString() {
    return 'ShippingAddress(addressId: $addressId, fullName: $fullName, phoneNumber: $phoneNumber, addressLine: $addressLine, city: $city, state: $state, country: $country)';
  }

  @override
  bool operator ==(covariant ShippingAddress other) {
    if (identical(this, other)) return true;

    return other.addressId == addressId &&
        other.fullName == fullName &&
        other.phoneNumber == phoneNumber &&
        other.addressLine == addressLine &&
        other.city == city &&
        other.state == state &&
        other.country == country;
  }

  @override
  int get hashCode {
    return addressId.hashCode ^
        fullName.hashCode ^
        phoneNumber.hashCode ^
        addressLine.hashCode ^
        city.hashCode ^
        state.hashCode ^
        country.hashCode;
  }
}
