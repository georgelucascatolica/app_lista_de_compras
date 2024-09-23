// lib/telas/tela_inicial.dart
import 'package:flutter/material.dart';
import 'tela_criacao_lista.dart';
import 'tela_edicao_lista.dart';
import 'tela_detalhes_lista.dart';
import '../modelos/lista_compras.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  List<ListaCompras> listasCompras = [];

  void _adicionarLista(ListaCompras lista) {
    setState(() {
      listasCompras.add(lista);
    });
  }

  void _atualizarLista(int indice, ListaCompras listaAtualizada) {
    setState(() {
      listasCompras[indice] = listaAtualizada;
    });
  }

  void _removerLista(int indice) {
    setState(() {
      listasCompras.removeAt(indice);
    });
  }

  Future<void> _confirmarRemocao(int indice) async {
    final bool? deveRemover = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar Deleção'),
          content: const Text('Você tem certeza que deseja apagar esta lista de compras?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Não apagar
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirmar apagar
              },
              child: const Text(
                'Apagar',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (deveRemover != null && deveRemover) {
      String nomeRemovido = listasCompras[indice].nome;
      _removerLista(indice);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lista "$nomeRemovido" apagada.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listas de Compras'),
        backgroundColor: const Color(0xFFE1D772), // Cor Secundária
      ),
      body: listasCompras.isEmpty
          ? const Center(
        child: Text(
          'Nenhuma lista criada ainda.\nClique no + para adicionar uma nova lista.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: listasCompras.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(listasCompras[index].nome),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaDetalhesLista(
                    listaCompras: listasCompras[index],
                  ),
                ),
              );
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min, // Limita o tamanho do Row
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () async {
                    final ListaCompras? listaAtualizada = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaEdicaoLista(
                          listaCompras: listasCompras[index],
                        ),
                      ),
                    );

                    if (listaAtualizada != null) {
                      _atualizarLista(index, listaAtualizada);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Lista "${listaAtualizada.nome}" atualizada.')),
                      );
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _confirmarRemocao(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TelaCriacaoLista(onAddList: _adicionarLista)),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFFF06B50), // Cor Terciária
      ),
    );
  }
}
