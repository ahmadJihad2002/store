class HomeModel {
  late bool status;
  late HomeDataModel data;

  HomeModel.formJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.formJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.formJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModel.formJson(element));
    });

    json['products'].forEach((element) {
      products.add(ProductModel.formJson(element));
    });
  }
}

class BannerModel {
  int? id;
  late String image;

  BannerModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  String? image;
  String? name;
  bool? inCart;

  bool? inFavorites;

  ProductModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
