import 'package:bloctutorial/features/cart/ui/cart_tile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/ui/product_tile_widget.dart';
import '../cart_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();

  void initState(){
    cartBloc.add(CartInitialEvent());
      super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        title: Text("Cart Items"),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        listenWhen: (previous,current)=>current is CartActionState,
        buildWhen: (previous,current)=>current is! CartActionState ,
        builder: (context, state) {
          switch(state.runtimeType){
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return ListView.builder(
                  itemCount: successState.cartItems.length
                  ,itemBuilder: (context,index){
                    return CartTileWidget(cartBloc:cartBloc,productDataModel: successState.cartItems[index]);
              });
            default:
          }
          return Container();
        },
      ),
    );
  }
}
//bloc consumer is a combination of listener and builder when we want to build and listen to ui we use
// bloc consumer when we only want to build then we use bloc builder and when listen we use bloc listener