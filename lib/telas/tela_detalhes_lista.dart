// lib/telas/tela_detalhes_lista.dart
import 'package:flutter/material.dart';
import '../modelos/lista_compras.dart';
import '../widgets/secao_categoria.dart';

class TelaDetalhesLista extends StatefulWidget {
  final ListaCompras listaCompras;

  const TelaDetalhesLista({Key? key, required this.listaCompras}) : super(key: key);

  @override
  _TelaDetalhesListaState createState() => _TelaDetalhesListaState();
}

class _TelaDetalhesListaState extends State<TelaDetalhesLista> {
  void _marcarComoComprado(String categoria, int indice) {
    setState(() {
      widget.listaCompras.itens[categoria]![indice].foiComprado =
      !widget.listaCompras.itens[categoria]![indice].foiComprado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.listaCompras.nome),
        backgroundColor: const Color(0xFFE1D772), // Cor Secundária
      ),
      body: ListView(
        children: widget.listaCompras.itens.entries.map((entry) {
          return SecaoCategoria(
            categoria: entry.key,
            itens: entry.value,
            aoMarcarComprado: _marcarComoComprado,
            aoRemoverItem: null, // Sem remover itens na visualização
          );
        }).toList(),
      ),
    );
  }
}
