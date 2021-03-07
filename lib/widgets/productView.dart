
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reine_tech_shopping/models/products.dart';
import 'package:reine_tech_shopping/screens/productInfo.dart';

import '../functions.dart';

Widget ProductsView(String categ, double h, List<Product> _products) {
  List <Product> products;
  products=getProductByCateg(categ,_products);
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: h,
    ),
    itemBuilder: (context, index) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, ProductInfo.id,arguments: products[index]);
        },
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage(products[index].pLoc)),
            ),
            Positioned(
              bottom: 0,
              child: Opacity(
                opacity: .6,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(products[index].pName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold)),
                        Text("${products[index].pPrice}\$"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    itemCount: products.length,
  );
}