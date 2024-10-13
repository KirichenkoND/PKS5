import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/note.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartPage extends StatelessWidget {
  final Map<Note, int> cartItems;
  final Function(Note) onAdd;
  final Function(Note) onRemove;
  final Function(Note) onDelete;

  const CartPage({
    Key? key,
    required this.cartItems,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'ru_RU',
      symbol: '₽',
      decimalDigits: 2,
    );

    double totalAmount = cartItems.entries
        .fold(0, (sum, entry) => sum + entry.key.price * entry.value);

    if (cartItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Корзина')),
        body: Center(
          child: Text(
            'Ваша корзина пуста',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Корзина')),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final note = cartItems.keys.elementAt(index);
          final quantity = cartItems[note]!;

          final formattedPrice = currencyFormat.format(note.price);
          final formattedTotal = currencyFormat.format(note.price * quantity);

          return Slidable(
            key: ValueKey(note),
            startActionPane: ActionPane(
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    // Подтверждение удаления
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Подтверждение удаления'),
                          content: const Text(
                              'Вы уверены, что хотите удалить этот товар из корзины?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Отмена'),
                            ),
                            TextButton(
                              onPressed: () {
                                onDelete(note);
                                Navigator.of(context).pop();
                              },
                              child: const Text('Удалить'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Удалить',
                ),
              ],
            ),
            child: ListTile(
              leading: Image.network(note.imageUrl,
                  width: 50, height: 50, fit: BoxFit.cover),
              title: Text(note.title),
              subtitle:
                  Text('Цена: $formattedPrice x $quantity = $formattedTotal'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => onRemove(note),
                  ),
                  Text('$quantity'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => onAdd(note),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Общая сумма: ${currencyFormat.format(totalAmount)}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
