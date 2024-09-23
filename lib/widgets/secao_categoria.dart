// lib/widgets/secao_categoria.dart
import 'package:flutter/material.dart';
import '../modelos/item_compras.dart';

class SecaoCategoria extends StatelessWidget {
  final String categoria;
  final List<ItemCompras> itens;
  final Function(String, int)? aoRemoverItem;
  final Function(String, int)? aoMarcarComprado;

  const SecaoCategoria({
    Key? key,
    required this.categoria,
    required this.itens,
    this.aoRemoverItem,
    this.aoMarcarComprado,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(categoria),
      children: itens
          .asMap()
          .entries
          .map(
            (entry) => ListTile(
          title: Text(
            entry.value.nome,
            style: TextStyle(
              decoration: entry.value.foiComprado
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (aoMarcarComprado != null)
                IconButton(
                  icon: Icon(
                    entry.value.foiComprado
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: entry.value.foiComprado ? Colors.green : Colors.grey,
                  ),
                  onPressed: () {
                    if (aoMarcarComprado != null) {
                      aoMarcarComprado!(categoria, entry.key);
                    }
                  },
                ),
              if (aoRemoverItem != null)
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    if (aoRemoverItem != null) {
                      aoRemoverItem!(categoria, entry.key);
                    }
                  },
                ),
            ],
          ),
        ),
      )
          .toList(),
    );
  }
}
