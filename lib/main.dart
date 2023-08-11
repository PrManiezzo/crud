

import 'package:crud/app/pages/productsCreat_page.dart';
import 'package:crud/app/pages/productsList_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CRUD App',
      initialRoute: '/list',
      getPages: [
        GetPage(name: '/list', page: () => ListProducts()),
        GetPage(name: '/new', page: () => NewProduct()),
        
        
        //  GetPage(name: '/delete/:id', page: () => ProductDeletePage()),
      ],
    );
  }
}

