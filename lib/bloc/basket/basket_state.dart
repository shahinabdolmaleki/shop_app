import 'package:dartz/dartz.dart';
import 'package:shop_app/data/model/card_item.dart';

abstract class BasketStat {}

class BasketInitState extends BasketStat {}

class Basketdatafetchstat extends BasketStat {
  Either<String, List<BasketItem>> basketitemlist;
  int basketfinalprice;
  Basketdatafetchstat(this.basketitemlist,this.basketfinalprice);
}
