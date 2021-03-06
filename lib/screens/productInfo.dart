import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reine_tech_shopping/models/products.dart';
import 'package:reine_tech_shopping/provider/cartItem.dart';
import 'package:reine_tech_shopping/screens/CartScreen.dart';
class ProductInfo extends StatefulWidget {
  static String id= 'ProductInfo';
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int quantity=1;
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: <Widget>[
         Container(
           height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:Image(
              fit: BoxFit.fill,
              image: AssetImage(product.pLoc),
          )
         ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child:Icon(Icons.arrow_back_ios),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, CartScreen.id);
                      },
                     child:Icon(Icons.shopping_cart),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
            child:Column(
            children : <Widget>[
              Opacity(
                child:Container(
                  color:Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.3,
                  child:Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          product.pName,
                        style: TextStyle(
                          fontSize: 20,fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(
                        height:14,
                      ),
                      Text(
                        product.pDesc,
                        style: TextStyle(
                            fontSize: 16,fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height:14,
                      ),
                      Text(
                        '${product.pPrice}\$',
                        style: TextStyle(
                          fontSize: 20,fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height:14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipOval(
                          child:Material(
                          color: Colors.blue,
                            child:GestureDetector(
                            onTap:add,
                          child:SizedBox(
                            child: Icon(
                              Icons.add
                            ),
                            height:28,
                            width: 28,
                          ),
                          ),
                          ),
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(
                              fontSize: 60,
                            ),
                          ),
                          ClipOval(
                            child:Material(
                              color: Colors.blue,
                              child:GestureDetector(
                                onTap:subtract,
                                child:SizedBox(
                                  child: Icon(
                                      Icons.remove,
                                  ),
                                  height:28,
                                  width: 28,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],

                  ),

                ),

              ),
                opacity:0.5,
              ),
              ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.08,
            child:Builder(
                  builder:(context)=>RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
              ),
              onPressed: (){
                addToCart(context,product);
              },
              child: Text('Add to Cart'.toUpperCase(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,

              ),
              ),
            )
            ),
            ),
            ],
            ),
            ),
        ],
      ),
    );
  }

  subtract() {
    if(quantity>1){
      setState(() {
        quantity--;
      });
    }
  }

  add() {
    setState(() {
      quantity++;
    });
  }

  void addToCart(context ,product) {
    CartItem cartItem=Provider.of<CartItem>(context,listen: false);
    product.pQuantity=quantity;
    bool exist = false;
    var productsInCart = cartItem.products;
    for(var productInCart in productsInCart){
      if(productInCart.pName == product.pName)
      {
        exist = true;
        break;
      }
    }
    if(exist){
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('You\'ve already added this item before'),
      ));
    }
    else {
      cartItem.addProduct(product);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Added to Cart !!'),
      ));
    }
    }
}
