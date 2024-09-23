// lib/modelos/item_compras.dart
class ItemCompras {
  final String nome;
  final String categoria;
  bool foiComprado;

  ItemCompras({
    required this.nome,
    required this.categoria,
    this.foiComprado = false,
  });
}