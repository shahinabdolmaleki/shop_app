import 'package:bloc/bloc.dart';
import 'package:shop_app/bloc/basket/basket_event.dart';
import 'package:shop_app/bloc/basket/basket_state.dart';
import 'package:shop_app/util/payment_handler.dart';

import '../../data/repository/basket_repository.dart';

class BasketBloc extends Bloc<BasketEvent, BasketStat> {
  final IBasketRepository _basketRepository;
  final PaymentHandler paymentHandler;

  BasketBloc(this._basketRepository,this.paymentHandler) : super(BasketInitState()) {
    on<BasketfetchfromHiveevent>(((event, emit) async {
      var basketItemList = await _basketRepository.getAllBasketItems();
      var finalPrice = await _basketRepository.getbasketfinalprice();

      emit(Basketdatafetchstat(basketItemList, finalPrice));
    }));
    on<Basketpaymentinitevent>((event, emit) async {
      paymentHandler.initPaymentRequest();
    
    });
    on<Basketpaymentrequestinitevent>((event, emit) async {
      paymentHandler.sendPaymentRequest();
    });
  }
}
