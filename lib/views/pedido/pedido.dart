import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_flutter/componentes/boxdecoration.dart';
import 'package:projeto_flutter/componentes/inputdecoration.dart';
import 'package:projeto_flutter/models/produto.dart';
import 'package:projeto_flutter/views/pedido/buscarproduto.dart';
import '../../componentes/appbar.dart';
import '../../componentes/drawer.dart';

import '../../models/endereco.dart';

import '../pedido/endereco.dart';

import '../../componentes/textstyle.dart';
import '../../componentes/inputdecoration.dart';
import '../../componentes/boxdecoration.dart';

class Pedido extends StatefulWidget {
  EnderecoModel? enderecoModel;
  List<ProdutoModels> listaProduto = [];

  Pedido({Key? key, this.enderecoModel}) : super(key: key);

  changeEndereco(EnderecoModel endereco) {
    this.enderecoModel = endereco;
  }

  //Adiciona produto
  handleAdicionarProduto(ProdutoModels produtoModel) {
    int index = listaProduto
        .indexWhere((produto) => produto.idProduto == produtoModel.idProduto);

    //Caso não existe o produto da lista adiciona
    if (index < 0) {
      listaProduto.add(produtoModel);
    } else {
      listaProduto[index] = produtoModel;
    }
    print('produto.getNome()');
    for (var produto in listaProduto) {
      print(produto.getNome());
      print(produto.getQuantidade());
    }
  }

  //Remove produto
  handleRemoveProduto(ProdutoModels produtoModels) {
    listaProduto.remove(produtoModels);
  }

  @override
  _PedidoState createState() => _PedidoState();
}

class _PedidoState extends State<Pedido> {
  //Cliente
  final cpfCnpjController = TextEditingController();
  final nomeClienteController = TextEditingController();

  consultarCliente() {
    var cpfCnpjCliente = '00222081007';
    var nomeCliente = 'teste';

    //Caso seja cpf, aplica-se a máscara de CPF, caso contrário aplica-se a máscara de CNPJ
    if (cpfCnpjCliente.length == 11) {
      cpfCnpjCliente = UtilBrasilFields.obterCpf(cpfCnpjCliente);
    } else if (cpfCnpjCliente.length == 14) {
      cpfCnpjCliente = UtilBrasilFields.obterCnpj(cpfCnpjCliente);
    }
    //Caso exista o cliente cadastrado, preencha os campos com as respectivas informações
    cpfCnpjController.text = cpfCnpjCliente;
    nomeClienteController.text = nomeCliente;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponente(appBar: AppBar()),
      drawer: DrawerComponente(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Consultar cliente
            Container(
              width: 330,
              margin: EdgeInsets.fromLTRB(20, 17, 20, 3),
              padding: EdgeInsets.fromLTRB(15, 25, 10, 13),
              decoration: boxDecorationComponente,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'CPF/CNPJ:',
                        style: textStyleComponente,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 3),
                        width: 230,
                        height: 31,
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CpfOuCnpjFormatter()
                          ],
                          decoration: inputDecorationComponente,
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 241,
                    height: 31,
                    margin: EdgeInsets.only(top: 18, bottom: 13),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(0, 94, 181, 1)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ))),
                        onPressed: () {
                          consultarCliente();
                        },
                        child: Text(
                          'Consultar',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                        )),
                  )
                ],
              ),
            ),
            //Cliente
            Container(
              width: 330,
              margin: EdgeInsets.fromLTRB(20, 17, 20, 3),
              padding: EdgeInsets.fromLTRB(15, 25, 10, 13),
              decoration: boxDecorationComponente,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'Nome:',
                        style: textStyleComponente,
                      ),
                      Container(
                        //margin: EdgeInsets.only(left: 3),
                        width: 260,
                        height: 31,
                        child: TextField(
                          controller: nomeClienteController,
                          decoration: inputDecorationComponente,
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text(
                        'CPF/CNPJ:',
                        style: textStyleComponente,
                      ),
                      Container(
                        //  margin: EdgeInsets.only(left: 2),
                        width: 233,
                        height: 31,
                        child: TextField(
                          controller: cpfCnpjController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CpfOuCnpjFormatter()
                          ],
                          decoration: inputDecorationComponente,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            //Entrega
            Container(
              width: 330,
              margin: EdgeInsets.fromLTRB(20, 17, 20, 3),
              padding: EdgeInsets.fromLTRB(15, 25, 10, 13),
              decoration: boxDecorationComponente,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        'CEP:',
                        style: textStyleComponente,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        width: 260,
                        height: 31,
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CepInputFormatter()
                          ],
                          decoration: inputDecorationComponente,
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text(
                        'Logradouro:',
                        style: textStyleComponente,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 3),
                        width: 224,
                        height: 31,
                        child: TextField(
                          decoration: inputDecorationComponente,
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Num.:',
                            style: textStyleComponente,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 9),
                            width: 73,
                            height: 31,
                            child: TextField(
                              decoration: inputDecorationComponente,
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              'Bairro:',
                              style: textStyleComponente,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 4),
                              width: 128,
                              height: 31,
                              child: TextField(
                                decoration: inputDecorationComponente,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Cidade:',
                            style: textStyleComponente,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 1),
                            width: 115,
                            height: 31,
                            child: TextField(
                              decoration: inputDecorationComponente,
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Container(
                        margin: EdgeInsets.only(left: 14),
                        child: Row(
                          children: [
                            Text(
                              'Estado:',
                              style: textStyleComponente,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 6),
                              width: 73,
                              height: 31,
                              child: TextField(
                                decoration: inputDecorationComponente,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            BuscarProduto(
                handleAdicionarProduto: widget.handleAdicionarProduto,
                handleRemoveProduto: widget.handleRemoveProduto)
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
