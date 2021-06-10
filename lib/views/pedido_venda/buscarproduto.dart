import 'package:flutter/material.dart';
import '../../models/produto.dart';

class BuscarProduto extends StatefulWidget {
  List<ProdutoModels> listaProduto = [];
  BuscarProduto({Key? key}) : super(key: key);

  @override
  _BuscarProdutoState createState() => _BuscarProdutoState();
}

class _BuscarProdutoState extends State<BuscarProduto> {
  @override
  void initState() {
    super.initState();

    ProdutoModels produtoModels1 = new ProdutoModels('x', 10.0, 100);
    ProdutoModels produtoModels2 = new ProdutoModels('Produto2', 10.0, 100);

    widget.listaProduto.add(produtoModels1);
    widget.listaProduto.add(produtoModels2);
  }

  @override
  Widget build(BuildContext context) {
    //Ordena

    widget.listaProduto.sort((a, b) {
      return a.getNome().compareTo('x');
    });

    print(widget.listaProduto);

    final auxListaProduto = widget.listaProduto.map((produto) {
      return Text(produto.getNome());
    }).toList();

    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: [...auxListaProduto],
      ),
    ));
  }
}
