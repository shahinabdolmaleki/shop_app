class ProductImage {
  String? imageUrl;
  String? productid;
  ProductImage(this.imageUrl, this.productid);

  factory ProductImage.fromJson(Map<String, dynamic> jsonObject) {
    return ProductImage(
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['image']}',
      jsonObject['product_id'],
    );
  }
}
