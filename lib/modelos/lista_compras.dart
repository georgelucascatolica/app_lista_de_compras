// lib/modelos/lista_compras.dart
import 'item_compras.dart';

class ListaCompras {
  String nome;
  Map<String, List<ItemCompras>> itens;

  ListaCompras({required this.nome, required this.itens});
}