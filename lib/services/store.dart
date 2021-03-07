import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reine_tech_shopping/const.dart';
import 'package:reine_tech_shopping/models/products.dart';
class Store {
  final Firestore _firestore = Firestore.instance;

  addProduct(Product product) {
    _firestore.collection(productCollec).add(
        {
          productName: product.pName,
          productDesc: product.pDesc,
          productLoc: product.pLoc,
          productCateg: product.pCate,
          productPrice: product.pPrice
        }
    );
  }

  Stream<QuerySnapshot> viewProduct() {
    return _firestore.collection(productCollec).snapshots();
  }
  Stream<QuerySnapshot>viewOrders(){
    return _firestore.collection(Orders).snapshots();
  }
  Stream<QuerySnapshot> viewOrderDetails(documentId) {
    return _firestore
        .collection(Orders)
        .document(documentId)
        .collection(OrderDetails)
        .snapshots();
  }
  deleteProduct(docId){
    _firestore.collection(productCollec).document(docId).delete();
  }
  editProduct(data,docId){
      _firestore.collection(productCollec).document(docId).updateData(data);
  }
  storeOrders(data,List<Product> products){
    var documentRef = _firestore.collection(Orders).document();
    documentRef.setData(data);
    for(var product in products) {
      documentRef.collection(OrderDetails).document().setData(
        {
          productName : product.pName,
          productPrice : product.pPrice,
          productQuantity : product.pQuantity,
          productLoc : product.pLoc,
        }
      );
    }
  }
}