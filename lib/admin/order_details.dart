import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reine_tech_shopping/const.dart';
import 'package:reine_tech_shopping/models/products.dart';
import 'package:reine_tech_shopping/services/store.dart';
class OrdersDetails extends StatelessWidget {
  @override
  static String id = 'OrdersDetails';
  Store store = Store();
  Widget build(BuildContext context) {
    String documentId= ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body:
      StreamBuilder<QuerySnapshot>(
        stream: store.viewOrderDetails(documentId),
        builder: (context, snapshot) {
          if(snapshot.hasData){
              List <Product> products = [];
              for(var doc in snapshot.data.documents){
                  products.add(Product(
                    pName: doc.data[productName],
                    pQuantity: doc.data[productQuantity],
                    pCate: doc.data[productCateg],
                  ));
              }
              return Column(
                children:[
                  Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .2,
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('product name : ${products[index].pName}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Quantity : ${products[index].pQuantity}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'product Category : ${products[index].pCate}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    itemCount: products.length,
                  ),
                ),
                    ],
              );
          }
          else {
            return Center(
              child: Text('Loading Orders'),
            );
          }
        }
      ),
    );
  }
}
