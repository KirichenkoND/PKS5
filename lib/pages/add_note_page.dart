// lib/pages/add_note_page.dart
import 'package:flutter/material.dart';
import '../models/note.dart';

class AddNotePage extends StatefulWidget {
  final Function(Note) onNoteAdded;

  const AddNotePage({Key? key, required this.onNoteAdded}) : super(key: key);

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  bool _isSubmitting = false;

  void _submit() async {
    final String title = _titleController.text;
    final String text = _textController.text;
    final String imageUrl = _imageUrlController.text;
    final double? price = double.tryParse(_priceController.text);

    if (title.isNotEmpty &&
        text.isNotEmpty &&
        imageUrl.isNotEmpty &&
        price != null) {
      final Note newNote = Note(title, text, imageUrl, price);

      setState(() {
        _isSubmitting = true;
      });

      try {
        widget.onNoteAdded(newNote);
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка при добавлении товара: $e')),
        );
      } finally {
        setState(() {
          _isSubmitting = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Пожалуйста, заполните все поля корректно')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить новый товар'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Название товара'),
              ),
              TextField(
                controller: _textController,
                decoration: const InputDecoration(labelText: 'Описание товара'),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              TextField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'URL изображения'),
              ),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Цена товара'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              _isSubmitting
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submit,
                      child: const Text('Добавить товар'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    _imageUrlController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
