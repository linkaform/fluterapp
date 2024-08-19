class BothEntity {
  final List<BoothData> data;

  BothEntity({required this.data});

  factory BothEntity.fromJson(Map<String, dynamic> json) {
    return BothEntity(
      data: List<BoothData>.from(
        (json['response']['data'] as List).map(
          (x) => BoothData.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class BoothData {
  final String status;
  final AddressGeolocation? addressGeolocation; // AddressGeolocation o null
  final String folio;
  final String? addressType; // String o null
  final String area;
  final String country;
  final DateTime createdAt;
  final String? email; // String o null
  final String? phone; // String o null
  final String state;
  final String city;
  final String location;
  final String addressName;
  final String address;
  final String employee;
  final String id;
  final String address2;
  final String marcadaComo;
  final String zipCode;

  BoothData({
    required this.status,
    this.addressGeolocation,
    required this.folio,
    this.addressType,
    required this.area,
    required this.country,
    required this.createdAt,
    this.email,
    this.phone,
    required this.state,
    required this.city,
    required this.location,
    required this.addressName,
    required this.address,
    required this.employee,
    required this.id,
    required this.address2,
    required this.marcadaComo,
    required this.zipCode,
  });

  factory BoothData.fromJson(Map<String, dynamic> json) {
    return BoothData(
      status: json["status"] as String,
      addressGeolocation: json["address_geolocation"] == null
          ? null
          : AddressGeolocation.fromJson(
              json["address_geolocation"] as Map<String, dynamic>),
      folio: json["folio"] as String,
      addressType: json["address_type"] as String?,
      // Puede ser null
      area: json["area"] as String,
      country: json["country"] as String,
      createdAt: DateTime.parse(json["created_at"] as String),
      email: json["email"] as String?,
      // Puede ser null
      phone: json["phone"] as String?,
      // Puede ser null
      state: json["state"] as String,
      city: json["city"] as String,
      location: json["location"] as String,
      addressName: json["address_name"] as String,
      address: json["address"] as String,
      employee: json["employee"] as String,
      id: json["_id"] as String,
      address2: json["address2"] as String,
      marcadaComo: json["marcada_como"] as String,
      zipCode: json["zip_code"] as String,
    );
  }

  factory BoothData.empty() {
    return BoothData(
      status: '',
      folio: '',
      area: '',
      country: '',
      createdAt: DateTime.now(),
      state: '',
      city: '',
      location: '',
      addressName: '',
      address: '',
      employee: '',
      id: '',
      address2: '',
      marcadaComo: '',
      zipCode: '',
    );
  }
}

class AddressGeolocation {
  final double latitude;
  final double longitude;

  AddressGeolocation({
    required this.latitude,
    required this.longitude,
  });

  factory AddressGeolocation.fromJson(Map<String, dynamic> json) {
    return AddressGeolocation(
      latitude: (json["latitude"] as num).toDouble(),
      longitude: (json["longitude"] as num).toDouble(),
    );
  }
}
