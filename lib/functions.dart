import 'models/products.dart';

List <Product> getProductByCateg(String categ,List<Product> _products) {
  List <Product> products=[];
  try {
    for (var product in _products) {
      if (product.pCate == categ) {
        products.add(product);
      }
    }
  }
  on Error catch(ex){
    
  }
  return products;
}