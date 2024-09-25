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
                maxLines: null, // Поле автоматически расширяется
                keyboardType:
                    TextInputType.multiline, // Поддержка переноса строки
              ),
              TextField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'URL изображения'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final String title = _titleController.text;
                  final String text = _textController.text;
                  final String imageUrl = _imageUrlController.text;

                  if (title.isNotEmpty &&
                      text.isNotEmpty &&
                      imageUrl.isNotEmpty) {
                    final Note newNote = Note(title, text, imageUrl);
                    widget.onNoteAdded(newNote);
                    Navigator.pop(context);
                  }
                },
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
    super.dispose();
  }
}
