class ProductModel {
  String productAsset;
  String productName;
  double? productPrice;
  double? productDiscount;
  String productDescription;
  bool isWishlist;

  ProductModel(
      {required this.productAsset,
      required this.productName,
      this.productDiscount,
      required this.productPrice,
      required this.productDescription,
      this.isWishlist = false});
}
