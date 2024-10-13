import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Добавляем intl для форматирования чисел и цен
import '../models/note.dart';

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
    // Форматирование валюты
    final NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'ru_RU', // Задаем локаль для России (рубли)
      symbol: '₽', // Символ рубля
      decimalDigits: 2, // Оставляем два знака после запятой
    );

    // Считаем общую сумму
    double totalAmount = cartItems.entries
        .fold(0, (sum, entry) => sum + entry.key.price * entry.value);

    // Если корзина пуста
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

    // Страница с корзиной
    return Scaffold(
      appBar: AppBar(title: const Text('Корзина')),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final note = cartItems.keys.elementAt(index);
          final quantity = cartItems[note]!;

          // Форматируем цену и итоговую стоимость для товара
          final formattedPrice = currencyFormat.format(note.price);
          final formattedTotal = currencyFormat.format(note.price * quantity);

          return ListTile(
            leading: Image.network(note.imageUrl,
                width: 50, height: 50, fit: BoxFit.cover),
            title: Text(note.title),
            subtitle: Text(
                'Цена: $formattedPrice x $quantity = $formattedTotal'), // Красиво форматированная строка
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
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
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
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Общая сумма: ${currencyFormat.format(totalAmount)}', // Форматируем общую сумму
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
