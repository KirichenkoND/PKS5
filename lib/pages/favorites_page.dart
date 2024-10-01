import 'package:flutter/material.dart';
import '../models/note.dart';
import '../components/item_note.dart';
import 'note_page.dart';

class FavoritesPage extends StatelessWidget {
  final Set<Note> favoriteNotes;
  final Function(Note) onFavoriteToggle;

  const FavoritesPage({
    Key? key,
    required this.favoriteNotes,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteNotesList = favoriteNotes.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75, // Adjust as needed
        ),
        itemCount: favoriteNotesList.length,
        itemBuilder: (BuildContext context, int index) {
          final note = favoriteNotesList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotePage(
                    note: note,
                    onDelete: () {
                      // Optional: Remove from favorites on delete
                      onFavoriteToggle(note);
                      Navigator.pop(context);
                    },
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
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      onFavoriteToggle(note);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
