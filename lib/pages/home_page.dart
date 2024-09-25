// pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_3/components/item_note.dart';
import '../models/note.dart';
import '../data/notes_data.dart';
import 'note_page.dart';
import 'add_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> currentNotes = List.from(notes); // Копируем текущий список notes

  void _addNote(Note note) {
    setState(() {
      currentNotes.add(note); // Добавляем новый товар в список
    });
  }

  // Функция для удаления товара
  void _deleteNoteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Подтверждение удаления'),
          content: const Text('Вы уверены, что хотите удалить этот товар?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Закрыть диалог без удаления
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  currentNotes.removeAt(index); // Удаляем товар
                });
                Navigator.of(context).pop(); // Закрыть диалог
              },
              child: const Text('Удалить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Витрина Айфонов"),
      ),
      body: ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (BuildContext context, int index) {
          final note = currentNotes[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotePage(note: note),
                ),
              );
            },
            child: Stack(
              children: [
                ItemNote(
                  title: note.title,
                  text: note.text,
                  imageUrl: note.imageUrl,
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _deleteNoteConfirmation(
                          context, index); // Подтверждение удаления
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNotePage(
                onNoteAdded: _addNote, // Передача функции добавления
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
