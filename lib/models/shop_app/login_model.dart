class ShopLoginModel {
  late bool status;
  late String  message;

  // can be null
  UserData? data;

  // ShopLoginModel(
  //     {required this.status, required this.data, required this.message});
  ShopLoginModel.formJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.formJson(json['data']) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
    String?  token;



  UserData.formJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}