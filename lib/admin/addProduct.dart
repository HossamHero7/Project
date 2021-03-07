import 'package:flutter/material.dart';
import 'package:reine_tech_shopping/models/products.dart';
import 'package:reine_tech_shopping/widgets/customText.dart';
import 'package:reine_tech_shopping/services/store.dart';
class AddProduct extends StatelessWidget {
  static String id='AddProduct';
  String name,price,desc,categ,imageLoc;
  final store=Store();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomText(
              hint: 'Product Name',
              check: false,
              onClick: (value){
                name=value;
              },
            ),
            SizedBox(
              height: 15,
            ),
            CustomText(
              hint: 'Product Price',
              onClick: (value){
                price=value;
              },
              check: false,
            ),
            SizedBox(
              height: 15,
            ),
            CustomText(
              hint: 'Product Description',
              onClick: (value){
                desc=value;
              },
              check: false,
            ),
            SizedBox(
              height: 15,
            ),
            CustomText(
              hint: 'Product Category',
              onClick: (value){
                categ=value;
              },
              check: false,
            ),
            SizedBox(
              height: 15,
            ),
            CustomText(
              hint: 'Product Location',
              onClick: (value){
                imageLoc=value;
              },
              check: false,
            ),
            SizedBox(
              height: 25,
            ),
            RaisedButton(
              onPressed: (){
                if(_globalKey.currentState.validate()){
                  _globalKey.currentState.save();
                  _globalKey.currentState.reset();
                    store.addProduct(Product(
                    pName: name,
                    pPrice: price,
                    pCate: categ,
                    pDesc: desc,
                    pLoc: imageLoc,
                  ));
                }
              },
              child: Text("Add Product"),
            ),
          ],
        ),
      ),
    );
  }
}
