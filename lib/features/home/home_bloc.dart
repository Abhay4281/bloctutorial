import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloctutorial/data/cart_items.dart';
import 'package:bloctutorial/data/grocery_data.dart';
import 'package:bloctutorial/data/wishlist_items.dart';
import 'package:meta/meta.dart';

import 'models/home_product_datamodels.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(
        homeInitialEvent
    );
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(
        homeProductCartButtonClickedEvent
    );
    on<HomeWishlistButtonNavigateEvent>(
        homeWishlistButtonNavigateEvent
    );
    on<HomeCartButtonNavigateEvent>(
        homeCartButtonNavigateEvent
    );
  }
  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit)async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(HomeLoadedSuccessState(
        products: GroceryData.groceryProducts.map((e) => ProductDataModel(
        id: e['id'],
        name: e['name'],
        description: e['description'],
          price: double.tryParse(e['price'] ?? '0.0') ?? 0.0,
        imageUrl: e['imageUrl'],
    )
    ).toList()
    )
    );
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    print('wishlist product clicked');
    wishListItems.add(event.clickedProduct);
    emit(HomeProductItemWishListedActionState());
  }


  FutureOr<void> homeProductCartButtonClickedEvent(HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
  print('cart product clicked');
  cartItems.add(event.clickedProduct);
  emit(HomeProductItemCartedActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
  print('wishlist navigate clicked');
  emit(HomeNavigateToWishListPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
 print('cart navigate clicked');
 emit(HomeNavigateToCartPageActionState());
  }


}
