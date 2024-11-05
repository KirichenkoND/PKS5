// lib/pages/edit_note_page.dart
import 'package:flutter/material.dart';
import '../models/note.dart';
import '../api/api_service.dart';

class EditNotePage extends StatefulWidget {
  final Note note;

  const EditNotePage({Key? key, required this.note}) : super(key: key);

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  bool _isSubmitting = false;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note.title;
    _textController.text = widget.note.text;
    _imageUrlController.text = widget.note.imageUrl;
    _priceController.text = widget.note.price.toString();
  }

  void _submit() async {
    final String title = _titleController.text;
    final String text = _textController.text;
    final String imageUrl = _imageUrlController.text;
    final double? price = double.tryParse(_priceController.text);

    if (title.isNotEmpty &&
        text.isNotEmpty &&
        imageUrl.isNotEmpty &&
        price != null) {
      final updatedNote = Note(
        title,
        text,
        imageUrl,
        price,
        id: widget.note.id,
      );

      setState(() {
        _isSubmitting = true;
      });

      try {
        await _apiService.updateNote(updatedNote);
        Navigator.pop(context, updatedNote);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка при обновлении товара: $e')),
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
        title: const Text('Редактировать товар'),
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
                      child: const Text('Сохранить изменения'),
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
