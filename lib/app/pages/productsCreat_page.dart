import 'package:crud/app/controller/product_controller.dart';
import 'package:crud/app/decoration/inputDecoration.dart';
import 'package:crud/app/model/product_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class NewProduct extends GetWidget<ProductController> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController valorController = TextEditingController();
  final ProductController productController = Get.find();

  final _formKey = GlobalKey<FormState>();

  NewProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        backgroundColor: Color.fromARGB(255, 104, 230, 247),
        foregroundColor: Colors.black,
        title: const Text('Novo Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: getLabelDecoration('Nome'),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Nome Obrigatorio";
                  }
                  return null;
                },
                controller: nameController,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: descricaoController,
                decoration: getLabelDecoration('Descriçao'),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Descrição Obrigatoria";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: valorController,
                decoration: getLabelDecoration('valor'),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Valor Obrigatorio";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  final product = Product(
                    id: 0,
                    nome: nameController.text,
                    descricao: descricaoController.text,
                    valor: int.parse(valorController.text),
                    createdAt: DateTime
                        .now(), // Define a data de criação como a data atual
                    updatedAt: DateTime.now(),
                  );

                  if (_formKey.currentState!.validate()) {
                    productController.createProduct(product);
                    Get.back();
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(
                      900, 54), // Defina a largura e altura desejadas
                ),
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
