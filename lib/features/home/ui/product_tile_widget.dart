import 'package:bloctutorial/features/home/home_bloc.dart';
import 'package:bloctutorial/features/home/models/home_product_datamodels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  const ProductTileWidget({super.key, required this.productDataModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(fit:BoxFit.cover,image: NetworkImage(productDataModel.imageUrl))
            ),
            
          ),
          const SizedBox(height: 10,),
          Text(productDataModel.name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

          Text(productDataModel.description),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$   "+productDataModel.price.toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Row(
                children: [
                  IconButton(onPressed: (){

                    homeBloc.add(HomeProductWishlistButtonClickedEvent(
                      clickedProduct: productDataModel
                    ));

                  }, icon: Icon(Icons.favorite_border,color: Colors.black,)),
                  IconButton(onPressed: (){

                    homeBloc.add(HomeProductCartButtonClickedEvent(
                      clickedProduct: productDataModel
                    ));
                  }, icon: Icon(Icons.shopping_cart_outlined,color: Colors.black,))

                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
