import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  int id;
  String nome;
  int valor;
  String descricao;
  DateTime createdAt;
  DateTime updatedAt;

  Product({
    required this.id,
    required this.nome,
    required this.valor,
    required this.descricao,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        nome: json["nome"],
        valor: json["valor"],
        descricao: json["descricao"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "valor": valor,
        "descricao": descricao,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
