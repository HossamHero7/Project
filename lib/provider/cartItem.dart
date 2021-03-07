import 'package:flutter/cupertino.dart';
import 'package:reine_tech_shopping/models/products.dart';

class CartItem extends ChangeNotifier{
  List<Product> products=[];
  addProduct(Product product){
    products.add(product);
    notifyListeners();
  }
  deleteProducts(Product product){
    products.remove(product);
    notifyListeners();
  }
}