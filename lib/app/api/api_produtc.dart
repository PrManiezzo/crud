import 'package:crud/app/model/product_model.dart';
import 'package:get/get.dart';

class ProductApi extends GetConnect {
  final String apiUrl = 'https://lucastroo.com/product-crud/public/api/product';

  Future<List<Product>> fetchProducts() async {
    final response = await get(apiUrl);
    if (response.status.hasError) {
      throw Exception('Erro ao obter produtos');
    }
    final List<dynamic> data = response.body;
    return data
        .map((json) => Product(
              id: json['id'],
              nome: json['nome'],
              valor: json['valor'].toDouble(),
              descricao: json['descricao'],
              createdAt: json['created_at'], // Corrected key
              updatedAt: json['updated_at'], // Corrected key
            ))
        .toList();
  }

  Future<void> createProduct(Product product) async {
    final response = await post(apiUrl, product.toJson());
    if (response.status.hasError) {
      throw Exception('Erro ao criar o produto');
    }
  }

  Future<void> updateProduct(Product product) async {
    final response =
        await put('$apiUrl/${product.id}', product.toJson()); // Corrected URL
    if (response.status.hasError) {
      throw Exception('Erro ao atualizar o produto');
    }
  }

  Future<void> deleteProduct(int id) async {
    final response = await delete('$apiUrl/$id'); // Corrected URL
    if (response.status.hasError) {
      throw Exception('Erro ao excluir o produto');
    }
  }
}
