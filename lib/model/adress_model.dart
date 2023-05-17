class AddressModel {
  String address;
  String phoneNumber;
  late String additionalInfo;
  String region;
  String city;
  String clientId;

  AddressModel({
    required this.address,
    required this.phoneNumber,
    this.additionalInfo = "",
    required this.region,
    required this.city,
    required this.clientId
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      additionalInfo: json['additionalInfo'],
      region: json['region'],
      city: json['city'],
       clientId: json['clientId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'phoneNumber': phoneNumber,
      'additionalInfo': additionalInfo,
      'region': region,
      'city': city,
      'clientId':clientId,
    };
  }
}
