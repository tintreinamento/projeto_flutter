// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import 'package:projeto_flutter/componentes/AppBarComponent.dart';
// import 'package:projeto_flutter/componentes/ButtonComponent.dart';
// import 'package:projeto_flutter/componentes/DrawerComponent.dart';
// import 'package:projeto_flutter/componentes/InputComponent.dart';
// import 'package:projeto_flutter/componentes/MoldulraComponent.dart';
// import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
// import 'package:projeto_flutter/componentes/TextComponent.dart';
// import 'package:projeto_flutter/componentes/styles.dart';
// import 'package:projeto_flutter/controllers/CategoriaController.dart';
// import 'package:projeto_flutter/controllers/EstoqueController.dart';
// import 'package:projeto_flutter/controllers/FornecedorController.dart';
// import 'package:projeto_flutter/controllers/ProdutoController.dart';
// import 'package:projeto_flutter/models/CategoriaModel.dart';
// import 'package:projeto_flutter/models/EstoqueModel.dart';
// import 'package:projeto_flutter/models/FornecedorModel.dart';
// import 'package:projeto_flutter/models/ProdutoModel.dart';

// class EstoqueView extends StatefulWidget {
//   @override
//   _EstoqueViewState createState() => _EstoqueViewState();
// }

// class ProdutoCategoriaFornecedorModel {
//   var produto = new ProdutoModel();
//   var categoriaModel = new CategoriaModel();
//   var fornecedorModel = new FornecedorModel();
//   var estoques = new List.empty(growable: true);
// }

// class _EstoqueViewState extends State<EstoqueView> {
//   bool _active = false;
//   ProdutoModel? produtoModel;
//   ProdutoCategoriaFornecedorModel? produtoCFMG;

//   var formkeyConsulta = GlobalKey<FormState>();
//   var nomePedidoController = TextEditingController();
//   var nomeEstoqueController = TextEditingController();
//   var quantidadeEstoqueController = TextEditingController();

//   obtenhaEstoques(int id) async {
//     return await new EstoqueController().obtenhaEstoqueProduto(id);
//   }

//   consultarEstoque() async {
//     _active = !_active;

//     var nome = nomePedidoController.text;
//     var produtos =
//         (await new ProdutoController().obtenhaTodosComCategoriaFornecedor())
//             .where((element) =>
//                 element.produto.nome.toLowerCase().contains(nome.toLowerCase()))
//             .toList();

//     produtos.forEach((element) async {
//       element.estoques = await obtenhaEstoques(element.produto.id);
//     });

//     if (produtos.length > 1) {
//       abraDialogConsulta(produtos);
//     } else if (produtos.length == 1) {
//       produtos.single.estoques =
//           await obtenhaEstoques(produtos.single.produto.id);
//       produtoModel = produtos.single.produto;
//       produtoCFMG = produtos.single;
//     } else {
//       produtoModel = null;
//     }

//     setState(() {});
//   }

//   atualizeEstoqueAoCadastrar(
//       ProdutoCategoriaFornecedorModel? _produtoCFMG) async {
//     _produtoCFMG!.estoques = await obtenhaEstoques(_produtoCFMG.produto.id);
//     produtoCFMG = _produtoCFMG;
//     produtoModel = _produtoCFMG.produto;

//     setState(() {});
//   }

//   cadastrarEstoque() {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//               actions: [
//                 InputComponent(
//                   label: 'Nome',
//                   controller: nomeEstoqueController,
//                 ),
//                 InputComponent(
//                   label: 'Quantidade',
//                   controller: quantidadeEstoqueController,
//                 ),
//                 ButtonComponent(
//                   label: 'Cadastrar',
//                   onPressed: () async {
//                     await new EstoqueController().crie(EstoqueModel(
//                         nome: nomeEstoqueController.text,
//                         quantidade: int.parse(quantidadeEstoqueController.text),
//                         idProduto: produtoModel?.id));
//                     atualizeEstoqueAoCadastrar(produtoCFMG);
//                     setState(() {});
//                     Navigator.pop(context);
//                   },
//                 )
//               ],
//             ));
//   }

//   abraDialogConsulta(List<ProdutoCategoriaFornecedorModel> produtos) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               AlertDialog(
//                 content: Container(
//                   height: MediaQuery.of(context).size.height * .7,
//                   width: MediaQuery.of(context).size.height * .5,
//                   child: ListView.builder(
//                     itemCount: produtos.length,
//                     itemBuilder: (context, position) {
//                       return cardProduto(context, produtos[position]);
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           );
//         });
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarComponent(),
//       drawer: DrawerComponent(),
//       body: Container(
//         child: Column(children: [
//           SubMenuComponent(
//               titulo: 'Estoque',
//               tituloPrimeiraRota: '',
//               primeiraRota: '/estoque',
//               tituloSegundaRota: '',
//               segundaRota: ''),
//           Expanded(
//             child: Container(
//                 padding: paddingPadrao,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       FormConsulta(
//                         formKeyConsultar: formkeyConsulta,
//                         onPressed: consultarEstoque,
//                         nomePedidoController: nomePedidoController,
//                       ),
//                       if (produtoModel != null)
//                         Container(
//                           child: Column(
//                             children: [
//                               DetalheProduto(
//                                 produtoModel: this.produtoModel,
//                               ),
//                               Estoque(produtoModel: this.produtoCFMG),
//                               ButtonComponent(
//                                   label: 'Cadastrar Novo',
//                                   onPressed: cadastrarEstoque)
//                             ],
//                           ),
//                         ),
//                     ],
//                   ),
//                 )),
//           )
//         ]),
//       ),
//     );
//   }

//   var formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

//   Widget cardProduto(
//       BuildContext context, ProdutoCategoriaFornecedorModel produtoCFM) {
//     return InkWell(
//       onTap: () {
//         produtoModel = produtoCFM.produto;
//         produtoCFMG = produtoCFM;
//         setState(() {});
//         Navigator.of(context).pop();
//       },
//       child: ConstrainedBox(
//         constraints: BoxConstraints(minWidth: 340.0),
//         child: Container(
//           color: Color.fromRGBO(255, 255, 255, 0),
//           padding: EdgeInsets.only(bottom: 10.0),
//           child: Container(
//             padding: EdgeInsets.all(10.0),
//             width: MediaQuery.of(context).size.width,
//             color: Color.fromRGBO(235, 231, 231, 1),
//             child: Stack(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         TextComponent(
//                           label: 'ID Produto: ',
//                           fontWeight: FontWeight.w700,
//                         ),
//                         Text(produtoCFM.produto.id.toString()),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         TextComponent(
//                           label: 'Nome: ',
//                           fontWeight: FontWeight.w700,
//                         ),
//                         Expanded(
//                             child: Text(produtoCFM.produto.nome.toString()))
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         TextComponent(
//                           label: 'Descrição: ',
//                           fontWeight: FontWeight.w700,
//                         ),
//                         Expanded(
//                             child: Text(produtoCFM.produto.descricao ?? ""))
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         TextComponent(
//                           label: 'Categoria: ',
//                           fontWeight: FontWeight.w700,
//                         ),
//                         Expanded(child: Text(produtoCFM.categoriaModel.nome))
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TextComponent(
//                           label: 'Valor Compra: ',
//                           fontWeight: FontWeight.w700,
//                         ),
//                         Text(formatter.format(produtoCFM.produto.valorCompra))
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TextComponent(
//                           label: 'Valor Venda: ',
//                           fontWeight: FontWeight.w700,
//                         ),
//                         Text(formatter.format(produtoCFM.produto.valorVenda))
//                       ],
//                     ),
//                     SizedBox(
//                       height: 5,
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class FormConsulta extends StatelessWidget {
//   GlobalKey<FormState>? formKeyConsultar;
//   Function? onPressed;
//   TextEditingController? nomePedidoController;

//   FormConsulta(
//       {this.formKeyConsultar, this.onPressed, this.nomePedidoController});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Form(
//         key: formKeyConsultar,
//         child: MolduraComponent(
//             label: 'Buscar Produto',
//             content: Column(
//               children: [
//                 InputComponent(
//                   label: 'Nome:',
//                   controller: nomePedidoController,
//                 ),
//                 ButtonComponent(label: 'Consultar', onPressed: this.onPressed)
//               ],
//             )),
//       ),
//     );
//   }
// }

// class DetalheProduto extends StatefulWidget {
//   ProdutoModel? produtoModel;

//   DetalheProduto({Key? key, this.produtoModel}) : super(key: key);

//   @override
//   _DetalheProdutoState createState() => _DetalheProdutoState();
// }

// class _DetalheProdutoState extends State<DetalheProduto> {
//   CategoriaModel? categoriaModel;
//   FornecedorModel? fornecedorModel;

//   NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

//   getCategoria() async {
//     CategoriaController categoriaController = CategoriaController();
//     categoriaModel = await categoriaController
//         .obtenhaPorId(widget.produtoModel!.idCategoria);

//     setState(() {});
//   }

//   getFornecedor() async {
//     FornecedorController forncedorController = FornecedorController();
//     fornecedorModel = await forncedorController
//         .obtenhaPorId(widget.produtoModel!.idFornecedor);

//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//     getCategoria();
//     getFornecedor();
//   }

//   Widget cardProduto() {
//     return ConstrainedBox(
//         constraints: BoxConstraints(minWidth: 340.0),
//         child: Container(
//           child: MolduraComponent(
//               label: 'Produto',
//               content: Column(
//                 children: [
//                   Row(
//                     children: [
//                       TextComponent(label: 'Nome: '),
//                       TextComponent(
//                         label: widget.produtoModel!.nome,
//                       )
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       TextComponent(label: 'Categoria: '),
//                       TextComponent(
//                         label: categoriaModel!.nome,
//                       )
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       TextComponent(label: 'Fornecedor: '),
//                       TextComponent(label: fornecedorModel!.nome)
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       TextComponent(label: 'Descrição: '),
//                       TextComponent(
//                         label:
//                             widget.produtoModel!.descricao ?? "Sem descrição",
//                       )
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       TextComponent(label: 'Valor Compra: '),
//                       TextComponent(
//                         label:
//                             formatter.format(widget.produtoModel!.valorCompra),
//                       )
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       TextComponent(label: 'Valor Venda: '),
//                       TextComponent(
//                         label:
//                             formatter.format(widget.produtoModel!.valorVenda),
//                       )
//                     ],
//                   ),
//                 ],
//               )),
//         ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(child: cardProduto());
//   }
// }

// class Estoque extends StatefulWidget {
//   ProdutoCategoriaFornecedorModel? produtoModel;
//   Estoque({Key? key, this.produtoModel}) : super(key: key);

//   @override
//   _EstoqueState createState() => _EstoqueState();
// }

// class _EstoqueState extends State<Estoque> {
//   List<EstoqueModel>? listaEstoqueModel;

//   @override
//   void initState() {
//     super.initState();
//   }

//   atualizarEstoque(EstoqueModel estoqueModel, int quantidade) async {
//     estoqueModel.quantidade += quantidade;

//     var estoqueController = new EstoqueController();

//     await estoqueController.atualize(estoqueModel);

//     setState(() {});
//   }

//   removerEstoque(EstoqueModel estoqueModel, int quantidade) async {
//     estoqueModel.quantidade -= quantidade;

//     var estoqueController = new EstoqueController();

//     await estoqueController.atualize(estoqueModel);

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: MediaQuery.of(context).size.height * .4,
//         width: MediaQuery.of(context).size.height * .4,
//         child: ListView.builder(
//           itemCount: widget.produtoModel!.estoques.length,
//           itemBuilder: (context, position) {
//             return ItemEstoqueCard(
//               itemEstoque: widget.produtoModel!.estoques[position],
//               atualizarEstoque: atualizarEstoque,
//               removerEstoque: removerEstoque,
//             );
//           },
//         ));
//   }
// }

// class ItemEstoqueCard extends StatefulWidget {
//   EstoqueModel? itemEstoque;
//   Function? atualizarEstoque;
//   Function? removerEstoque;

//   ItemEstoqueCard(
//       {Key? key, this.itemEstoque, this.atualizarEstoque, this.removerEstoque})
//       : super(key: key);

//   @override
//   _ItemEstoqueCardState createState() => _ItemEstoqueCardState();
// }

// class _ItemEstoqueCardState extends State<ItemEstoqueCard> {
//   TextEditingController quantidadeController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: EdgeInsets.only(bottom: 10.0),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 3,
//               child: Container(
//                 color: colorCinza,
//                 padding: paddingPadrao,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TextComponent(
//                       label: widget.itemEstoque!.nome.toString(),
//                       fontWeight: FontWeight.bold,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     TextComponent(
//                       label: 'Quantidade: ' +
//                           widget.itemEstoque!.quantidade.toString(),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//                 flex: 2,
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: paddingPadrao,
//                       color: colorBranco,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Expanded(
//                               child: ElevatedButton(
//                             style: ButtonStyle(
//                                 backgroundColor:
//                                     MaterialStateProperty.all<Color>(
//                                         Color.fromRGBO(0, 94, 181, 1)),
//                                 shape: MaterialStateProperty.all<
//                                         RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(100),
//                                 ))),
//                             onPressed: () => showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) => AlertDialog(
//                                       actions: [
//                                         InputComponent(
//                                           label: 'Quantidade',
//                                           controller: quantidadeController,
//                                         ),
//                                         ButtonComponent(
//                                           label: 'Salvar',
//                                           onPressed: () {
//                                             widget.atualizarEstoque!(
//                                                 widget.itemEstoque!,
//                                                 int.parse(
//                                                     quantidadeController.text));
//                                             Navigator.pop(context);
//                                           },
//                                         )
//                                       ],
//                                     )),
//                             child: TextComponent(
//                               fontWeight: FontWeight.bold,
//                               tamanho: 15,
//                               label: '+',
//                             ),
//                           ))
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//             Expanded(
//                 flex: 2,
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: paddingPadrao,
//                       color: colorBranco,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Expanded(
//                               child: ElevatedButton(
//                             style: ButtonStyle(
//                                 backgroundColor:
//                                     MaterialStateProperty.all<Color>(
//                                         Color.fromRGBO(0, 94, 181, 1)),
//                                 shape: MaterialStateProperty.all<
//                                         RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(100),
//                                 ))),
//                             onPressed: () => showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) => AlertDialog(
//                                       actions: [
//                                         InputComponent(
//                                           label: 'Quantidade',
//                                           controller: quantidadeController,
//                                         ),
//                                         ButtonComponent(
//                                           label: 'Remove',
//                                           onPressed: () {
//                                             widget.atualizarEstoque!(
//                                                 widget.itemEstoque!,
//                                                 int.parse(
//                                                     quantidadeController.text));
//                                             Navigator.pop(context);
//                                           },
//                                         )
//                                       ],
//                                     )),
//                             child: TextComponent(
//                               fontWeight: FontWeight.bold,
//                               tamanho: 15,
//                               label: '-',
//                             ),
//                           ))
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//           ],
//         ));
//   }
// }
