// lib/telas/tela_criacao_lista.dart
import 'package:flutter/material.dart';
import '../modelos/item_compras.dart';
import '../modelos/lista_compras.dart';
import '../widgets/secao_categoria.dart';
import '../utils/categorias_compras.dart';

class TelaCriacaoLista extends StatefulWidget {
  final Function(ListaCompras) onAddList;

  const TelaCriacaoLista({Key? key, required this.onAddList}) : super(key: key);

  @override
  _TelaCriacaoListaState createState() => _TelaCriacaoListaState();
}

class _TelaCriacaoListaState extends State<TelaCriacaoLista> {
  final TextEditingController _nomeListaController = TextEditingController();
  final TextEditingController _nomeItemController = TextEditingController();
  String _categoriaSelecionada = categoriasCompras[0];
  Map<String, List<ItemCompras>> itensCategoricos = {
    for (var categoria in categoriasCompras) categoria: []
  };

  void _adicionarItem() {
    if (_nomeItemController.text.isEmpty) return;
    final novoItem = ItemCompras(nome: _nomeItemController.text, categoria: _categoriaSelecionada);
    setState(() {
      itensCategoricos[_categoriaSelecionada]?.add(novoItem);
    });
    _nomeItemController.clear();
  }

  void _removerItem(String categoria, int indice) {
    setState(() {
      itensCategoricos[categoria]?.removeAt(indice);
    });
  }

  void _criarLista() {
    if (_nomeListaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira um nome para a lista.')),
      );
      return;
    }

    final novaLista = ListaCompras(
      nome: _nomeListaController.text,
      itens: itensCategoricos,
    );
    widget.onAddList(novaLista);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Lista de Compras'),
        backgroundColor: const Color(0xFFE1D772), // Cor Secundária
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
                children: itensCategoricos.entries
                    .map((entry) => SecaoCategoria(
                  categoria: entry.key,
                  itens: entry.value,
                  aoRemoverItem: _removerItem,
                  aoMarcarComprado: null, // Sem checkbox na criação
                ))
                    .toList(),
              ),
            ),
            ElevatedButton(
              onPressed: _criarLista,
              child: const Text('Criar Lista'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE1D772), // Cor Secundária
              ),
            ),
          ],
        ),
      ),
    );
  }
}
