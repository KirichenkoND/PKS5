import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/note.dart';

class NotePage extends StatelessWidget {
  final Note note;
  final VoidCallback onDelete;
  final Function(Note) onAddToCart;

  const NotePage({
    Key? key,
    required this.note,
    required this.onDelete,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'ru_RU',
      symbol: '₽',
      decimalDigits: 2,
    );

    final formattedPrice = currencyFormat.format(note.price);

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(note.title),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Image.network(
                    note.imageUrl,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 100,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Цена: $formattedPrice',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  note.text,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Подтверждение удаления'),
                          content: const Text(
                              'Вы уверены, что хотите удалить этот товар?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Отмена'),
                            ),
                            TextButton(
                              onPressed: () {
                                onDelete();

                                Navigator.of(context).pop();

                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                              },
                              child: const Text('Удалить'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Center(child: const Text('Удалить')),
                ),
                ElevatedButton(
                  onPressed: () {
                    onAddToCart(note);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${note.title} добавлен в корзину'),
                      ),
                    );
                  },
                  child: Center(child: const Text('Добавить в корзину')),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: Center(child: const Text('Добавить в избранное')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
