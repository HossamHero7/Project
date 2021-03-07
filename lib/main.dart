import 'package:provider/provider.dart';
import 'package:reine_tech_shopping/admin/OrdersScreen.dart';
import 'package:reine_tech_shopping/admin/editProduct.dart';
import 'package:reine_tech_shopping/admin/order_details.dart';
import 'package:reine_tech_shopping/provider/adminMode.dart';
import 'package:reine_tech_shopping/provider/cartItem.dart';
import 'package:reine_tech_shopping/provider/modelHud.dart';
import 'package:reine_tech_shopping/screens/CartScreen.dart';
import 'package:reine_tech_shopping/screens/HomePageScreen.dart';
import 'package:reine_tech_shopping/screens/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:reine_tech_shopping/admin/adminScreen.dart';
import 'package:reine_tech_shopping/screens/loginScreen.dart';
import 'package:reine_tech_shopping/admin/addProduct.dart';
import 'package:reine_tech_shopping/admin/manageProduct.dart';
import 'package:reine_tech_shopping/screens/productInfo.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(
        create:(context) => ModelHud(),),
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode(),
        ),
        ChangeNotifierProvider<CartItem>(
          create: (context) => CartItem(),
        ),
      ],
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute:LoginScreen.id,
        routes: {
          OrdersDetails.id : (context)=>OrdersDetails(),
          OrdersScreen.id : (context)=>OrdersScreen(),
          CartScreen.id:(context)=>CartScreen(),
          ProductInfo.id:(context)=>ProductInfo(),
          EditProduct.id:(context)=>EditProduct(),
          LoginScreen.id:(context)=>LoginScreen(),
          adminScreen.id:(context)=>adminScreen(),
          SignUp.id:(context)=>SignUp(),
          HomePage.id:(context)=>HomePage(),
          AddProduct.id:(context)=>AddProduct(),
          ManageProducts.id:(context)=>ManageProducts(),
        },
    ),
    );
  }
}