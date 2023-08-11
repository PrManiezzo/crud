 
import 'package:crud/app/controller/product_controller.dart';
import 'package:crud/app/decoration/inputDecoration.dart';
import 'package:crud/app/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListProducts extends GetView<ProductController> {
  final ProductController _productController = Get.put(ProductController());

  ListProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: const Color.fromARGB(255, 104, 230, 247),
        foregroundColor: Colors.black,
        title: const Text('Produtos'),
      ),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    bottom: 3, top: 5, left: 39, right: 8),
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed("/new");
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: const Color.fromARGB(255, 33, 129, 33),
                    padding: const EdgeInsets.all(22),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
              const Text(' Novo Produto'),
            ],
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: _productController.products.length,
                itemBuilder: (context, index) {
                  final product = _productController.products[index];

                  return Container(
                    margin: const EdgeInsets.only(
                        bottom: 2, left: 10, top: 3, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 104, 230, 247),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          textColor: Colors.black,
                          title: Text('Nome  : ${product.nome}'),
                          subtitle: Text('Valor : ${product.valor.toString()}'),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete_outline_rounded),
                                color: Colors.redAccent,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Excluir Produto'),
                                        content: const Text(
                                            'Tem certeza de que deseja excluir este produto?'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Cancelar'),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Fechar o diálogo
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Excluir'),
                                            onPressed: () {
                                              _productController
                                                  .deleteProduct(product.id);
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit_note_outlined),
                                color: Colors.orangeAccent,
                                onPressed: () {
                                  showEditDialog(product);
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            show(product);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  showEditDialog(Product product) {
    Product editedProduct = product;

    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Container(
              margin: const EdgeInsets.only(
                bottom: 5,
                top: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: const Color.fromARGB(255, 104, 230, 247),
              ),
              child: const Text('Editar Produto')),
          content: _buildProductForm(editedProduct),
          actions: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Editar Produtos'),
                      content: const Text(
                          'Tem certeza de que deseja Editar este produto?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Fechar o diálogo
                          },
                        ),
                        TextButton(
                          child: const Text('Salvar'),
                          onPressed: () {
                            _productController.updateProduct(editedProduct);
                            Get.back();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Salvar'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  show(Product product) {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Container(
            margin:
                const EdgeInsets.only(bottom: 2, left: 10, top: 3, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromARGB(255, 104, 230, 247),
            ),
            child: const Text(
              'Produto',
            ),
          ),
          content: Container(
            margin:
                const EdgeInsets.only(bottom: 2, left: 10, top: 3, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromARGB(255, 104, 230, 247),
            ),
            child: ListTile(
              textColor: Colors.black,
              title: Text('Nome : ${product.nome}'),
              subtitle: Text('Descrição :  ${product.descricao}'),
              trailing: Text('Valor : ${product.valor.toString()}'),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProductForm(Product product) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          decoration: getLabelDecoration('nome'),
          onChanged: (value) => product.nome = value,
          controller: TextEditingController(text: product.nome),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: getLabelDecoration('Descriçao'),
          onChanged: (value) => product.descricao = value,
          controller: TextEditingController(text: product.descricao),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: getLabelDecoration('Valor'),
          onChanged: (value) => product.valor = double.parse(value) as int,
          controller: TextEditingController(text: product.valor.toString()),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}