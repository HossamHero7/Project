import 'package:flutter/material.dart';
import 'package:reine_tech_shopping/admin/OrdersScreen.dart';
import 'package:reine_tech_shopping/admin/addProduct.dart';
import 'package:reine_tech_shopping/admin/manageProduct.dart';
import 'package:reine_tech_shopping/const.dart';
class adminScreen extends StatelessWidget {
  static String id='adminScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          RaisedButton(
            onPressed: (){
              Navigator.pushNamed(context, AddProduct.id);
            },
            child: Text("Add Product"),
          ),
          RaisedButton(
            onPressed: (){
              Navigator.pushNamed(context, ManageProducts.id);
            },
            child: Text("Edit Product"),
          ),
          RaisedButton(
            onPressed: (){
              Navigator.pushNamed(context, OrdersScreen.id);
            },
            child: Text("View orders"),
          ),
        ],
      ),
    );
  }
}