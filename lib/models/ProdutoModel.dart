import 'dart:convert';

import 'package:projeto_flutter/models/EstoqueModel.dart';
import 'package:projeto_flutter/models/FornecedorModel.dart';

class ProdutoModel {
  int? id;
  String? nome;
  String? descricao;
  double? precoCompra = 0;
  String? categoria;
  String? margem;
  FornecedorModel? fornecedor;
  List<EstoqueModel>? estoque;

  ProdutoModel({
    this.id,
    this.nome,
    this.descricao,
    this.precoCompra,
    this.categoria,
    this.margem,
    this.fornecedor,
    this.estoque,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'precoCompra': precoCompra,
      'categoria': categoria,
      'margem': margem,
      'fornecedor': fornecedor?.toMap(),
      'estoque': estoque?.map((x) => x.toMap()).toList(),
    };
  }

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      id: map['id'],
      nome: map['nome'],
      descricao: map['descricao'],
      precoCompra: map['precoCompra'],
      categoria: map['categoria'],
      margem: map['margem'],
      fornecedor: FornecedorModel.fromMap(map['fornecedor']),
      estoque: List<EstoqueModel>.from(
          map['estoque']?.map((x) => EstoqueModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProdutoModel.fromJson(String source) =>
      ProdutoModel.fromMap(json.decode(source));
}
