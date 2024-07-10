import 'package:shop_app/data/model/variant.dart';
import 'package:shop_app/data/model/varianttype.dart';

class ProductVariant {
  VariantType varianttype;
  List<Variant> variantList;
  ProductVariant(this.varianttype, this.variantList);
}
