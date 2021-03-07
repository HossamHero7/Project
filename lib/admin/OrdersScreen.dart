
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reine_tech_shopping/admin/adminScreen.dart';
import 'package:reine_tech_shopping/const.dart';
import 'package:reine_tech_shopping/main.dart';
import 'package:reine_tech_shopping/models/order.dart';
import 'package:reine_tech_shopping/services/store.dart';
import 'package:reine_tech_shopping/admin/order_details.dart';
class OrdersScreen extends StatelessWidget {
  static String id = 'OrdersScreen';
  final Store _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body : StreamBuilder<QuerySnapshot>(
            stream: _store.viewOrders(),
            builder: (context,snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: Text('There is no orders'),
                );
              }
              else {
                List <Order>orders=[];
                for(var doc in snapshot.data.documents){
                  orders.add(Order(
                    documentId: doc.documentID,
                    address: doc.data[Address],
                    totalPrice: doc.data[TotalPrice],
                  ));
                }
                //print(orders[2].documentId);
                return ListView.builder(itemBuilder:
                (context,index) =>
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context,OrdersDetails.id,arguments: orders[index].documentId);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.2,
                        color : Colors.cyan,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Total Price = ${orders[index].totalPrice}\$',style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),),
                              SizedBox(height: 10,),
                              Text('Address is ${orders[index].address}',style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,

                              ),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  itemCount: orders.length,
                );
              }
            },
        ),
    );
  }
}
