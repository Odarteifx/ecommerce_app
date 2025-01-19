class Customer {
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  int? integration;
  String? domain;
  String? customerCode;
  int? id;
  bool? identified;

  Customer(
      {this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.integration,
      this.domain,
      this.customerCode,
      this.id,
      this.identified});

  Customer.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    integration = json['integration'];
    domain = json['domain'];
    customerCode = json['customer_code'];
    id = json['id'];
    identified = json['identified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['email'] = email;
    data['integration'] = integration;
    data['domain'] = domain;
    data['customer_code'] = customerCode;
    data['id'] = id;
    data['identified'] = identified;
    return data;
  }
}