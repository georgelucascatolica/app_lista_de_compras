// lib/telas/tela_edicao_lista.dart
import 'package:flutter/material.dart';
import '../modelos/item_compras.dart';
import '../modelos/lista_compras.dart';
import '../widgets/secao_categoria.dart';
import '../utils/categorias_compras.dart';

class TelaEdicaoLista extends StatefulWidget {
  final ListaCompras listaCompras;

  const TelaEdicaoLista({Key? key, required this.listaCompras}) : super(key: key);

  @override
  _TelaEdicaoListaState createState() => _TelaEdicaoListaState();
}

class _TelaEdicaoListaState extends State<TelaEdicaoLista> {
  late TextEditingController _nomeListaController;
  final TextEditingController _nomeItemController = TextEditingController();
  String _categoriaSelecionada = categoriasCompras[0];
  late Map<String, List<ItemCompras>> itensCategoria;

  @override
  void initState() {
    super.initState();
    _nomeListaController = TextEditingController(text: widget.listaCompras.nome);
    itensCategoria = {
      for (var categoria in categoriasCompras)
        categoria: List.from(widget.listaCompras.itens[categoria] ?? [])
    };
  }

  void _adicionarItem() {
    if (_nomeItemController.text.isEmpty) return;
    final novoItem = ItemCompras(nome: _nomeItemController.text, categoria: _categoriaSelecionada);
    setState(() {
      itensCategoria[_categoriaSelecionada]?.add(novoItem);
    });
    _nomeItemController.clear();
  }

  void _removerItem(String categoria, int indice) {
    setState(() {
      itensCategoria[categoria]?.removeAt(indice);
    });
  }

  void _salvarAlteracoes() {
    if (_nomeListaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira um nome para a lista.')),
      );
      return;
    }

    final listaAtualizada = ListaCompras(
      nome: _nomeListaController.text,
      itens: itensCategoria,
    );
    Navigator.of(context).pop(listaAtualizada);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Lista de Compras'),
        backgroundColor: const Color(0xFFE1D772), // Cor Secundária
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _salvarAlteracoes,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeListaController,
              decoration: const InputDecoration(labelText: 'Nome da Lista'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nomeItemController,
              decoration: const InputDecoration(labelText: 'Nome do Item'),
            ),
            DropdownButton<String>(
              value: _categoriaSelecionada,
              items: categoriasCompras
                  .map((categoria) => DropdownMenuItem(
                value: categoria,
                child: Text(categoria),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _categoriaSelecionada = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: _adicionarItem,
              child: const Text('Adicionar Item'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF06B50), // Cor Terciária
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: itensCategoria.entries
                    .map((entry) => SecaoCategoria(
                  categoria: entry.key,
                  itens: entry.value,
                  aoRemoverItem: _removerItem,
                  aoMarcarComprado: null, // Sem checkbox na edição
                ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
