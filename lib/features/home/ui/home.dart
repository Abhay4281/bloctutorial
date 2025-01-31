import 'package:bloctutorial/features/home/ui/product_tile_widget.dart';
import 'package:bloctutorial/features/wishlist/ui/wishlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cart/ui/cart.dart';
import '../home_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void initState(){
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc= HomeBloc();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,

      listenWhen: (previous,current)=>current is HomeActionState,
      buildWhen: (previous,current)=>current is! HomeActionState,

      listener: (context, state) {
        if(state is HomeNavigateToCartPageActionState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
        }
        else if(state is HomeNavigateToWishListPageActionState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Wishlist()));
        }
        else if( state is HomeProductItemCartedActionState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item Carted')));
        }
        else if(state is HomeProductItemWishListedActionState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item Wishlisted')));
        }
      },

      builder: (context, state) {
        switch(state.runtimeType){
          case HomeLoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );


          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: Text("Grocery App",style: TextStyle(color: Colors.white),),
                actions: [
                  IconButton(onPressed: (){
                    homeBloc.add(HomeWishlistButtonNavigateEvent());
                  }, icon: Icon(Icons.favorite_border,color: Colors.white,)),
                  IconButton(onPressed: (){
                    homeBloc.add(HomeCartButtonNavigateEvent());
                  }, icon: Icon(Icons.shopping_cart_outlined,color: Colors.white,))
                ],
              ),
              body: ListView.builder(
                itemCount: successState.products.length,
                  itemBuilder: (context,index){
                return ProductTileWidget(homeBloc:homeBloc,productDataModel: successState.products[index]);
              }),
            );

          case HomeErrorState :
            return Scaffold(body: Center(child: Text("Error"),),);
          default:
            return SizedBox();
        }
      },
    );
  }
}
