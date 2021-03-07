import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reine_tech_shopping/models/products.dart';
import 'package:reine_tech_shopping/services/store.dart';
import 'package:reine_tech_shopping/const.dart';
import 'package:reine_tech_shopping/widgets/custom_menu.dart';

import 'editProduct.dart';
class ManageProducts extends StatefulWidget {
  static String id='ManageProducts';
  @override
  ManageProductsState createState() => ManageProductsState();
}
class ManageProductsState extends State<ManageProducts>{
  final store = Store();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: mainColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: store.viewProduct(),
        builder:(context , snapshot){
        if(snapshot.hasData) {
          List<Product> products=[];
          for (var i in snapshot.data.documents) {
            var data = i.data;
            products.add(Product(
              pId: i.documentID,
              pPrice: data[productPrice],
              pName: data[productName],
              pLoc: data[productLoc],
              pDesc: data[productDesc],
              pCate: data[productCateg],
            )
            );
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.25,
            ),
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              child:GestureDetector(
                onTapUp: (det){
                  double dx=det.globalPosition.dx;
                  double dy=det.globalPosition.dy;
                  double dx2=MediaQuery.of(context).size.width-dx;
                  double dy2=MediaQuery.of(context).size.height-dy;
                  showMenu(context: context, position: RelativeRect.fromLTRB(dx, dy, dx2, dy2), items: [
                    MyPopupMenuItem(
                        onClick: (){
                          Navigator.pushNamed(context, EditProduct.id,arguments: products[index]);
                        },
                        child: Text("Edit"),
                    ),
                    MyPopupMenuItem(
                      onClick:(){
                        store.deleteProduct(products[index].pId);
                        Navigator.pop(context);
                      },
                      child: Text("Delete"),
                    ),
                  ]);
                },
              child:Stack(
              children: <Widget> [
                Positioned.fill(
                child:Image(fit: BoxFit.fill,image: AssetImage(products[index].pLoc)),
                ),
                Positioned(
                    bottom: 0,
                    child: Opacity(
                      opacity: .6,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        color: Colors.white,
                        child:Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(products[index].pName,style:TextStyle( fontWeight:FontWeight.bold)),
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
        else {
          return Center(child: Text("Loading...",style:TextStyle(fontSize: 25)));
        }
      },
      ),
    );
  }
}
