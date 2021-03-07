import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reine_tech_shopping/models/products.dart';
import 'package:reine_tech_shopping/screens/CartScreen.dart';
import 'package:reine_tech_shopping/screens/productInfo.dart';
import 'package:reine_tech_shopping/services/auth.dart';
import 'package:reine_tech_shopping/services/store.dart';
import 'package:reine_tech_shopping/widgets/productView.dart';

import '../const.dart';
import '../functions.dart';

class HomePage extends StatefulWidget {
  static String id = 'Homepage';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final auth = Auth();
  FirebaseUser loggedUser;
  int tabeBarIdx = 0;
  int bottomBarIdx = 0;
  final store = Store();
  List<Product> _products;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: unActiveColor,
              currentIndex: bottomBarIdx,
              fixedColor: Colors.blue,
              onTap: (value) {
                setState(() {
                  bottomBarIdx = value;
                });
              },
              items: [
                BottomNavigationBarItem(
                  title: Text('Test1'),
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  title: Text('Test2'),
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  title: Text('Test3'),
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  title: Text('Test4'),
                  icon: Icon(Icons.person),
                ),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              bottom: TabBar(
                indicatorColor:
                    Colors.black, //The line that is under the selected categ.
                onTap: (value) {
                  setState(() {
                    tabeBarIdx = value;
                  });
                },
                tabs: <Widget>[
                  Text(
                    'Laptops',
                    style: TextStyle(
                      color: tabeBarIdx == 0 ? Colors.black : unActiveColor,
                      fontSize: tabeBarIdx == 0 ? 15 : null,
                    ),
                  ),
                  Text(
                    'Mobiles',
                    style: TextStyle(
                      color: tabeBarIdx == 1 ? Colors.black : unActiveColor,
                      fontSize: tabeBarIdx == 1 ? 15 : null,
                    ),
                  ),
                  Text(
                    'iPads',
                    style: TextStyle(
                      color: tabeBarIdx == 2 ? Colors.black : unActiveColor,
                      fontSize: tabeBarIdx == 2 ? 15 : null,
                    ),
                  ),
                  Text(
                    'Consoles',
                    style: TextStyle(
                      color: tabeBarIdx == 3 ? Colors.black : unActiveColor,
                      fontSize: tabeBarIdx == 3 ? 15 : null,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                LaptopsView(),
                ProductsView(categMobiles,0.95,_products),
                ProductsView(categiPads,1.2,_products),
                ProductsView(categConsoles,1.2,_products),
                //LaptopsView(),
                //LaptopsView(),
                //LaptopsView(),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Discover'.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
        ),
      ],
    );
  }

  @override
  void initState() {
    getCurrentUser();
  }

  getCurrentUser() async {
    loggedUser = await auth.getUser();
  }

  Widget LaptopsView() {
    return StreamBuilder<QuerySnapshot>(
        stream: store.viewProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var i in snapshot.data.documents) {
              var data = i.data;
              products.add(Product(
                pId: i.documentID,
                pPrice: data[productPrice],
                pName: data[productName],
                pLoc: data[productLoc],
                pDesc: data[productDesc],
                pCate: data[productCateg],
              ));
            }
            _products = [...products];
            products.clear();
            products=getProductByCateg(categLaptops,_products);
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.25,
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
          } else {
            return Center(
                child: Text("Loading...", style: TextStyle(fontSize: 25)));
          }
        });
  }
}
