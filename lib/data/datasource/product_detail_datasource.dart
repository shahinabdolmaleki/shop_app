import 'package:dio/dio.dart';
import 'package:shop_app/data/model/category.dart';
import 'package:shop_app/data/model/product_image.dart';
import 'package:shop_app/data/model/product_properties.dart';
import 'package:shop_app/data/model/product_variant.dart';
import 'package:shop_app/data/model/variant.dart';
import 'package:shop_app/data/model/varianttype.dart';
import 'package:shop_app/di/di.dart';
import 'package:shop_app/util/api_exeption.dart';

abstract class IproductDetailDataSource {
  Future<List<ProductImage>> getGallery(String productId);
  Future<List<VariantType>> getvarianttyps();
  Future<List<Variant>> getvariants(String productId);
  Future<List<ProductVariant>> getproductvarians(String productId);
  Future<Category> getproductcategorydata(String categoryId);
  Future<List<Property>> getproductproperty(String productId);

  getproductcategory() {}
}

class ProductDetailRemotDataSource extends IproductDetailDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<ProductImage>> getGallery(String productId) async {
    Map<String, String> qparams = {'filter': 'product_id="$productId"'};
    try {
      var respons = await _dio.get('collections/gallery/records',
          queryParameters: qparams);
      return respons.data['items']
          .map<ProductImage>((jsonObject) => ProductImage.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknown erorr');
    }
  }

  @override
  Future<List<VariantType>> getvarianttyps() async {
    try {
      var respons = await _dio.get('collections/variants_type/records');
      return respons.data['items']
          .map<VariantType>((jsonObject) => VariantType.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknown erorr');
    }
  }

  @override
  Future<List<Variant>> getvariants(String productId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="$productId"'};

      var respons = await _dio.get('collections/variants/records',
          queryParameters: qParams);
      return respons.data['items']
          .map<Variant>((jsonObject) => Variant.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknown erorr');
    }
  }

  @override
  Future<List<ProductVariant>> getproductvarians(String productId) async {
    var variantTypeList = await getvarianttyps();
    var variantList = await getvariants(productId);
    List<ProductVariant> productVariantList = [];

    try {
      for (var variantType in variantTypeList) {
        var variant = variantList
            .where((element) => element.typeId == variantType.id)
            .toList();
        productVariantList.add(ProductVariant(variantType, variant));
      }

      return productVariantList;
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknown erorr');
    }
  }

  @override
  Future<Category> getproductcategorydata(String categoryId) async {
    try {
      Map<String, String> qparams = {
        'filter': 'id="$categoryId"',
      };
      var response = await _dio.get('collections/category/records',
          queryParameters: qparams);
      return Category.fromMapJson(response.data['items'][0]);
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknown erorr');
    }
  }

  @override
  Future<List<Property>> getproductproperty(String productId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="$productId"'};

      var respons = await _dio.get('collections/properties/records',
          queryParameters: qParams);
      return respons.data['items']
          .map<Property>((jsonObject) => Property.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknown erorr');
    }
  }
}
