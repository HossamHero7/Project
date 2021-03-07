import 'package:flutter/material.dart';
import 'package:reine_tech_shopping/const.dart';
import 'package:reine_tech_shopping/models/products.dart';
import 'package:reine_tech_shopping/services/store.dart';
import 'package:reine_tech_shopping/widgets/customText.dart';

class EditProduct extends StatelessWidget {
  @override
  static String id='EditProduct';
  String name,price,desc,categ,imageLoc;
  final store=Store();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    Product product=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Form(
        key: _globalKey,
        child:ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height*0.2,
            ),
            Column(
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
                      store.editProduct(({
                        productName : name,
                        productLoc : imageLoc,
                        productCateg : categ,
                        productDesc : desc,
                        productPrice : price,
                      }), product.pId);
                    }
                  },
                  child: Text("Edit Product"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
