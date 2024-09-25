// pages/note_page.dart

import 'package:flutter/material.dart';
import '../models/note.dart';

class NotePage extends StatelessWidget {
  final Note note;

  const NotePage({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title), // Отображаем заголовок заметки
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title, // Отображаем заголовок
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
                    ); // Иконка ошибки при невозможности загрузки изображения
                  },
                ), // Отображаем изображение
              ),
              // Отображаем изображение
              const SizedBox(height: 16),
              Text(
                note.text, // Отображаем полный текст заметки
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
