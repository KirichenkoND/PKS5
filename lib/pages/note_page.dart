// lib/pages/note_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/note.dart';
import 'edit_note_page.dart'; // Импортируем страницу редактирования

class NotePage extends StatefulWidget {
  final Note note;
  final VoidCallback onDelete;
  final Function(Note) onAddToCart;
  final Function(Note) onToggleFavorite;
  final bool isFavorite;

  const NotePage({
    Key? key,
    required this.note,
    required this.onDelete,
    required this.onAddToCart,
    required this.onToggleFavorite,
    required this.isFavorite,
  }) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  void _toggleFavorite() {
    widget.onToggleFavorite(widget.note);
    setState(() {
      isFavorite = !isFavorite;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite
              ? '${widget.note.title} добавлен в избранное'
              : '${widget.note.title} удалён из избранного',
        ),
      ),
    );
  }

  void _navigateToEditPage() async {
    final updatedNote = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNotePage(note: widget.note),
      ),
    );

    if (updatedNote != null && updatedNote is Note) {
      // Обновляем данные товара после редактирования
      setState(() {
        widget.note.title = updatedNote.title;
        widget.note.text = updatedNote.text;
        widget.note.imageUrl = updatedNote.imageUrl;
        widget.note.price = updatedNote.price;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${widget.note.title} успешно обновлён')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'ru_RU',
      symbol: '₽',
      decimalDigits: 2,
    );

    final formattedPrice = currencyFormat.format(widget.note.price);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note.title),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: const Icon(Icons.edit), // Иконка карандаша
            onPressed: _navigateToEditPage, // Обработчик нажатия
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                widget.note.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Image.network(
                widget.note.imageUrl,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 100,
                  );
                },
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
                widget.note.text,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final shouldDelete = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Подтверждение удаления'),
                        content: const Text(
                            'Вы уверены, что хотите удалить этот товар?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Отмена'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Удалить'),
                          ),
                        ],
                      );
                    },
                  );

                  if (shouldDelete == true) {
                    widget.onDelete();
                    Navigator.of(context).pop();
                  }
                },
                child: const Center(child: Text('Удалить')),
              ),
              ElevatedButton(
                onPressed: () {
                  widget.onAddToCart(widget.note);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${widget.note.title} добавлен в корзину'),
                    ),
                  );
                },
                child: const Center(child: Text('Добавить в корзину')),
              ),
              const SizedBox(height: 8),
              Center(
                child: ElevatedButton(
                  onPressed: _toggleFavorite,
                  child: Center(
                    child: Text(
                      isFavorite
                          ? 'Удалить из избранного'
                          : 'Добавить в избранное',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
