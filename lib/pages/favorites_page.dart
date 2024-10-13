import 'package:flutter/material.dart';
import '../models/note.dart';
import '../components/item_note.dart';
import 'note_page.dart';

class FavoritesPage extends StatelessWidget {
  final Set<Note> favoriteNotes;
  final Function(Note) onFavoriteToggle;
  final Function(Note) onAddToCart;

  const FavoritesPage({
    Key? key,
    required this.favoriteNotes,
    required this.onFavoriteToggle,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteNotesList = favoriteNotes.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: favoriteNotesList.isEmpty
          ? Center(
              child: Text(
                'Ваше избранное пусто',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
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
                            onFavoriteToggle(note);
                            Navigator.pop(context);
                          },
                          onAddToCart: onAddToCart,
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
                        isFavorite: favoriteNotes.contains(note),
                        onToggleFavorite: () => onFavoriteToggle(note),
                        onAddToCart: () => onAddToCart(note),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
