// pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_3/components/item_note.dart';
import '../models/note.dart';
import '../data/notes_data.dart';
import 'note_page.dart';
import 'add_note_page.dart';

class HomePage extends StatefulWidget {
  final Set<Note> favoriteNotes;
  final Function(Note) onFavoriteToggle;
  final Function(Note) onAddToCart;

  const HomePage({
    Key? key,
    required this.favoriteNotes,
    required this.onFavoriteToggle,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Note> currentNotes = List.from(notes);

  void _addNote(Note note) {
    setState(() {
      currentNotes.add(note);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Витрина Айфонов"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        itemCount: currentNotes.length,
        itemBuilder: (BuildContext context, int index) {
          final note = currentNotes[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotePage(
                    note: note,
                    onDelete: () {
                      setState(() {
                        currentNotes.removeAt(index);
                        widget.favoriteNotes.remove(note);
                      });
                      Navigator.pop(context);
                    },
                    onAddToCart: widget.onAddToCart,
                  ),
                ),
              );
            },
            child: Stack(
              children: [
                ItemNote(
                  title: note.title,
                  text: note.text,
                  imageUrl: note.imageUrl,
                  price: note.price,
                  isFavorite: widget.favoriteNotes.contains(note),
                  onToggleFavorite: () => widget.onFavoriteToggle(note),
                  onAddToCart: () => widget.onAddToCart(note),
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
                onNoteAdded: _addNote,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
