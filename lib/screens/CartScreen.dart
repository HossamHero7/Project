import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reine_tech_shopping/const.dart';
import 'package:reine_tech_shopping/models/products.dart';
import 'package:reine_tech_shopping/provider/cartItem.dart';
import 'package:reine_tech_shopping/screens/productInfo.dart';
import 'package:reine_tech_shopping/services/store.dart';
import 'package:reine_tech_shopping/widgets/custom_menu.dart';

class CartScreen extends StatelessWidget {
  static String id = "CartScreen";

  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'My Cart',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          LayoutBuilder(
            builder:(context,constrains) {
              if(products.isNotEmpty) {
                return Container(
                  height: screenHeight - statusBarHeight - appBarHeight - (screenHeight*0.08),
                  child: ListView.builder(
                     // scrollDirection: Axis.vertical,
                     // shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: GestureDetector(
                          onTapUp: (details){
                            showCustomMenu(details,context,products[index]);
                          },
                          child: Container(
                            height: screenHeight * 0.15,
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: screenHeight * 0.15 / 2,
                                  backgroundImage: AssetImage(
                                      products[index].pLoc),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: <Widget>[
                                            Text(
                                              products[index].pName,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '${products[index].pPrice} \$',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Text(
                                          products[index].pQuantity.toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            color: Colors.blue,
                          ),
                        ),
                      );
                    },
                    itemCount: products.length,
                  ),
                );
              }else
                {
                  return Container(
                    height: screenHeight - (screenHeight * 0.08) - appBarHeight - statusBarHeight,
                    child: Center(
                      child: Text('Cart is Empty' ,
                        style: TextStyle(fontWeight: FontWeight.bold , fontSize: 50),
                      ),
                    ),
                  );
                }
            }
          ),
          Builder(
            builder:(context) => ButtonTheme(
              minWidth: screenWidth,
              height: screenHeight * 0.08,
              child: RaisedButton(

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                ),
                onPressed: () {
                  showCustomDialog(products,context);
                },
                child: Text(
                  'Order'.toUpperCase(),
                ),
                color: Colors.blue, //main color
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showCustomMenu(det,context,product) async {
    double dx=det.globalPosition.dx;
    double dy=det.globalPosition.dy;
    double dx2=MediaQuery.of(context).size.width-dx;
    double dy2=MediaQuery.of(context).size.height-dy;
    showMenu(context: context, position: RelativeRect.fromLTRB(dx, dy, dx2, dy2), items: [
      MyPopupMenuItem(
        onClick: (){
            Navigator.pop(context);
            Provider.of<CartItem>(context,listen: false).deleteProducts(product);
            Navigator.pushNamed(context, ProductInfo.id,arguments: product);
        },
        child: Text("Edit"),
      ),
      MyPopupMenuItem(
        onClick:(){
          Navigator.pop(context);
          Provider.of<CartItem>(context,listen: false).deleteProducts(product);
        },
        child: Text("Delete"),
      ),
    ]);
  }

  void showCustomDialog(List<Product>products,context)async {
    var price=getTotalPrice(products);
    var address;
    AlertDialog alertDialog = AlertDialog(
      actions: [
        MaterialButton(
          onPressed: (){
            try {
              Store _store = Store();
              _store.storeOrders(
                  {
                    TotalPrice: price,
                    Address: address,
                  }, products
              );
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Ordered Successfully !'),
              ));
              Navigator.pop(context);
            }catch (ex){
              print(ex.message);
            }
          },
          child: Text('Confirm'),
        )
      ],
      content: TextField(
        onChanged: (value){
          address = value;
        },
        decoration: InputDecoration(
          hintText: 'Your Address',
        ),
      ),
      title: Text('Total Price = $price\$'),
    );
    await showDialog(context: context,builder: (context){
      return alertDialog;
    });
  }
  getTotalPrice(List<Product> products) {
    var price = 0;
    for(var product in products){
      price += product.pQuantity * int.parse(product.pPrice);
    }
    return price;
  }
}
