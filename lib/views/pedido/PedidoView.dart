// import 'package:flutter/material.dart';
// import 'package:projeto_flutter/componentes/AppBarComponent.dart';
// import 'package:projeto_flutter/componentes/ButtonComponent.dart';
// import 'package:projeto_flutter/componentes/DrawerComponent.dart';
// import 'package:projeto_flutter/componentes/FormComponent.dart';
// import 'package:projeto_flutter/componentes/InputComponent.dart';
// import 'package:brasil_fields/brasil_fields.dart';
// import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
// import 'package:projeto_flutter/componentes/styles.dart';
// import 'package:projeto_flutter/controllers/ClienteController.dart';
// import 'package:projeto_flutter/models/EnderecoCorreioModel.dart';
// import 'package:projeto_flutter/controllers/EnderecoCorreioController.dart';
// import 'package:flutter/services.dart';

// //Produto
// import 'package:projeto_flutter/controllers/ProdutoController.dart';
// import 'package:projeto_flutter/models/ProdutoModel.dart';

// import 'package:projeto_flutter/componentes/TextComponent.dart';
// import 'package:projeto_flutter/views/pedido/ProdutoCarrinhoWidget.dart';

// class PedidoView extends StatefulWidget {
//   const PedidoView({Key? key}) : super(key: key);

//   @override
//   _PedidoViewState createState() => _PedidoViewState();
// }

// class _PedidoViewState extends State<PedidoView> {
//   bool _active = false;

//   final _formKeyConsultarCliente = GlobalKey<FormState>();
//   final _formKeyCliente = GlobalKey<FormState>();
//   final _formKeyEndereco = GlobalKey<FormState>();

//   //Cliente
//   var cpfCnpjController = TextEditingController();
//   var nomeController = TextEditingController();
//   //Dados de endereço
//   final cepController = TextEditingController();
//   final logradouroController = TextEditingController();
//   final numeroController = TextEditingController();
//   final bairroController = TextEditingController();
//   final cidadeController = TextEditingController();
//   final estadoController = TextEditingController();

//   final nomeProdutoController = TextEditingController();

//   //EnderecoModel? enderecoModel;
//   late Future<List<ProdutoModel>> listaProdutos;

//   bool isVazio(value) {
//     if (value == null || value.isEmpty) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   String validarCpfCnpj(cpfCnpj) {
//     if (isVazio(cpfCnpj)) {
//       return 'Campo CPF/CNPJ vazio';
//     }
//     if (UtilBrasilFields.removeCaracteres(cpfCnpj).length == 11) {
//       if (UtilBrasilFields.isCPFValido(
//           UtilBrasilFields.removeCaracteres(cpfCnpj))) {
//         return 'CPF inválido !';
//       }
//     }
//     if (UtilBrasilFields.removeCaracteres(cpfCnpj).length == 14) {
//       if (UtilBrasilFields.isCNPJValido(cpfCnpj)) {
//         return 'CNPJ inválido !';
//       }
//     }
//     return "";
//   }

//   consultarCliente() async {
//     if (_formKeyConsultarCliente.currentState!.validate()) {
//       //consultar
//       ClienteController clienteController = new ClienteController();
//       final clienteModel = await clienteController.obtenhaPorCpf(
//           UtilBrasilFields.removeCaracteres(cpfCnpjController.text));
//       //Preenche os dados do cliente
//       setState(() {
//         //Cliente
//         nomeController.text = clienteModel.nome;
//         //Endereço
//         cepController.text = clienteModel.cep;
//         logradouroController.text = clienteModel.logradouro;
//         numeroController.text = clienteModel.numero;
//         bairroController.text = clienteModel.bairro;
//         cidadeController.text = clienteModel.cidade;
//         estadoController.text = clienteModel.estadoCivil;
//       });
//     }
//   }

//   carregarEndereco() async {
//     EnderecoCorreioController enderecoCorreioController =
//         new EnderecoCorreioController();
//     final enderecoCorreioModel =
//         await enderecoCorreioController.obtenhaEnderecoPorCep(
//             UtilBrasilFields.removeCaracteres(cepController.text));

//     //Carrega os dados de endereço
//     logradouroController.text = enderecoCorreioModel.logradouro;
//     bairroController.text = enderecoCorreioModel.bairro;
//     cidadeController.text = enderecoCorreioModel.localidade;
//     estadoController.text = enderecoCorreioModel.uf;
//   }

//   @override
//   void initState() {
//     super.initState();
//     carregarProdutos();
//   }

//   void carregarProdutos() async {
//     // ProdutoController produtoController = new ProdutoController();
//     // listaProdutos = produtoController.obtenhaTodos();
//   }

//   changeProduto() {
//     setState(() {});
//   }

//   abrirCarrinhoProduto() {
//     setState(() {
//       _active = true;
//     });
//   }

//   fecharCarrinhoProduto() {
//     setState(() {
//       _active = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final formConsultar = Form(
//         key: _formKeyConsultarCliente,
//         child: FormComponent(
//           label: 'Consulta',
//           content: Column(
//             children: [
//               InputComponent(
//                 label: 'CPF/CNPJ: ',
//                 controller: cpfCnpjController,
//                 validator: validarCpfCnpj,
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               ButtonComponent(
//                 label: 'Consultar',
//                 onPressed: consultarCliente,
//               )
//             ],
//           ),
//         ));

//     final formCliente = Form(
//         key: _formKeyCliente,
//         child: FormComponent(
//           label: 'Cliente',
//           content: Column(
//             children: [
//               InputComponent(
//                 label: 'Nome: ',
//                 controller: nomeController,
//                 validator: (value) {
//                   if (isVazio(value)) {
//                     return 'Campo nome vazio !';
//                   }
//                   return null;
//                 },
//               ),
//             ],
//           ),
//         ));

//     final formEndereco = Container(
//       child: Form(
//           key: _formKeyEndereco,
//           child: FormComponent(
//             label: 'Endereço',
//             content: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 InputComponent(
//                   label: 'CEP: ',
//                   inputFormatter: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     CepInputFormatter()
//                   ],
//                   onFieldSubmitted: carregarEndereco,
//                   controller: cepController,
//                   validator: (value) {
//                     if (isVazio(value)) {
//                       return 'Campo CEP vazio !';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 InputComponent(
//                   label: 'Logradouro: ',
//                   controller: logradouroController,
//                   validator: (value) {
//                     if (isVazio(value)) {
//                       return 'Campo logradouro vazio !';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 InputComponent(
//                   label: 'Número: ',
//                   controller: numeroController,
//                   validator: (value) {
//                     if (isVazio(value)) {
//                       return 'Campo número vazio !';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 InputComponent(
//                   label: 'Bairro: ',
//                   controller: bairroController,
//                   validator: (value) {
//                     if (isVazio(value)) {
//                       return 'Campo bairro vazio !';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 InputComponent(
//                   label: 'Cidade: ',
//                   controller: cidadeController,
//                   validator: (value) {
//                     if (isVazio(value)) {
//                       return 'Campo cidade vazio !';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 InputComponent(
//                   label: 'Estado: ',
//                   controller: estadoController,
//                   validator: (value) {
//                     if (isVazio(value)) {
//                       return 'Campo estado vazio !';
//                     }
//                     return null;
//                   },
//                 ),
//               ],
//             ),
//           )),
//     );

//     final listaProdutosWidget = FutureBuilder(
//         future: listaProdutos,
//         builder:
//             (BuildContext context, AsyncSnapshot<List<ProdutoModel>> snapshot) {
//           if (snapshot.hasData) {
//             // Data fetched successfully, display your data here

//             //Ordenar a lista de acordo com o parâmetro de busca
//             var listaProdutos = snapshot.data!.where((produto) {
//               return produto.nome
//                   .toLowerCase()
//                   .startsWith(nomeProdutoController.text.toLowerCase());
//             });

//             var listaProduto = listaProdutos.map((produto) {
//               return Column(
//                 children: [
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Container(
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             padding: EdgeInsets.all(10),
//                             color: colorCinza,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     TextComponent(label: 'Nome: '),
//                                     TextComponent(label: produto.nome),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     TextComponent(label: 'Categoria: '),
//                                     TextComponent(label: produto.nome),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     TextComponent(label: 'Preço: '),
//                                     TextComponent(
//                                         label: produto.valorVenda.toString()),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Container(
//                             child: Column(
//                               children: [
//                                 Container(
//                                     padding: EdgeInsets.all(10),
//                                     alignment: Alignment.center,
//                                     child: TextComponent(
//                                       label: 'Quantidade',
//                                     )),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         child: ElevatedButton(
//                                             style: ButtonStyle(
//                                                 backgroundColor:
//                                                     MaterialStateProperty.all<
//                                                         Color>(colorVerde),
//                                                 shape: MaterialStateProperty.all<
//                                                         RoundedRectangleBorder>(
//                                                     RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(0),
//                                                 ))),
//                                             onPressed: () {
//                                               //adicionarItemPedido(
//                                               //  produto);
//                                             },
//                                             child: TextComponent(
//                                               label: '+',
//                                             )),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         child: ElevatedButton(
//                                             style: ButtonStyle(
//                                                 backgroundColor:
//                                                     MaterialStateProperty.all<
//                                                         Color>(colorVermelho),
//                                                 shape: MaterialStateProperty.all<
//                                                         RoundedRectangleBorder>(
//                                                     RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(0),
//                                                 ))),
//                                             onPressed: () {
//                                               //adicionarItemPedido(
//                                               //  produto);
//                                             },
//                                             child: TextComponent(
//                                               label: '-',
//                                             )),
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             }).toList();

//             return Column(
//               children: [
//                 ...listaProduto,
//               ],
//             );
//           } else if (snapshot.hasError) {
//             // If something went wrong
//             return Text('Falha ao obter os dados da API');
//           }

//           // While fetching, show a loading spinner.
//           return CircularProgressIndicator();
//         });

//     final formProduto = FormComponent(
//       label: 'Produtos',
//       content: Column(
//         children: [
//           InputComponent(
//             label: 'Produto: ',
//             controller: nomeProdutoController,
//             onChange: changeProduto,
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           listaProdutosWidget
//         ],
//       ),
//     );

//     return Scaffold(
//         appBar: AppBarComponent(),
//         drawer: DrawerComponent(),
//         body: Container(
//           child: Column(
//             children: [
//               SubMenuComponent(
//                   titulo: 'Pedido',
//                   tituloPrimeiraRota: 'Cadastrar',
//                   primeiraRota: '/pedido_cadastrar',
//                   tituloSegundaRota: 'Consultar',
//                   segundaRota: '/pedido_consultar'),
//               Expanded(
//                 child: Stack(
//                   children: <Widget>[
//                     Expanded(
//                       child: SingleChildScrollView(
//                         padding: EdgeInsets.all(10),
//                         child: Column(
//                           children: [
//                             formConsultar,
//                             SizedBox(
//                               height: 10,
//                             ),
//                             formCliente,
//                             SizedBox(
//                               height: 10,
//                             ),
//                             formEndereco,
//                             SizedBox(
//                               height: 10,
//                             ),
//                             formProduto,
//                             SizedBox(
//                               height: 10.0,
//                             ),
//                             ButtonComponent(
//                               label: 'Cart',
//                               onPressed: abrirCarrinhoProduto,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: ProdutoCarrinhoWidget(
//                         active: _active,
//                         onTap: fecharCarrinhoProduto,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }
