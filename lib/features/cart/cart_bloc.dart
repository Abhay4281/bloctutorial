import 'package:bloc/bloc.dart';
import 'package:bloctutorial/data/cart_items.dart';
import 'package:meta/meta.dart';

import '../home/models/home_product_datamodels.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
   on<CartInitialEvent>(cartInitialEvent);

  }
}

Future<void>cartInitialEvent(
   CartInitialEvent event ,Emitter<CartState>emit)async {
  emit(CartSuccessState(cartItems: cartItems));
}
