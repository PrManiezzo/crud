import 'package:crud/app/api/api_produtc.dart';
import 'package:crud/app/model/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var labelText = ''.obs;
  final _productApi = ProductApi();

  RxList<Product> products = <Product>[].obs;

  get valor => null;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final List<Product> fetchedProducts = await _productApi.fetchProducts();
      products.assignAll(fetchedProducts);
    } catch (e) {
      // Lida com o erro, se necessário
    }
  }

  Future<void> createProduct(Product product) async {
    try {
      await _productApi.createProduct(product);
      products.add(product);
    } catch (e) {
      // Lida com o erro, se necessário
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _productApi.updateProduct(product);
      final index = products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        products[index] = product;
      }
    } catch (e) {
      // Lida com o erro, se necessário
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _productApi.deleteProduct(id);
      products.removeWhere((p) => p.id == id);
    } catch (e) {
      // Lida com o erro, se necessário
    }
  }
}
