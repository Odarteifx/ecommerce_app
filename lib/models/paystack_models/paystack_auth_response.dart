class PaystackAuthResponse {
  String? authorizationUrl;
  String? accessCode;
  String? reference;

  PaystackAuthResponse(
      {this.authorizationUrl, this.accessCode, this.reference});

  PaystackAuthResponse.fromJson(Map<String, dynamic> json) {
    authorizationUrl = json['authorization_url'];
    accessCode = json['access_code'];
    reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authorization_url'] = authorizationUrl;
    data['access_code'] = accessCode;
    data['reference'] = reference;
    return data;
  }
}
