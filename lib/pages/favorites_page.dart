// lib/pages/favorites_page.dart
import 'package:flutter/material.dart';
import '../models/note.dart';
import '../components/item_note.dart';
import 'note_page.dart';

class FavoritesPage extends StatefulWidget {
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
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final favoriteNotesList = widget.favoriteNotes.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: favoriteNotesList.isEmpty
          ? const Center(
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
                            widget.onFavoriteToggle(note);
                            Navigator.pop(context);
                          },
                          onAddToCart: widget.onAddToCart,
                          onToggleFavorite: widget.onFavoriteToggle,
                          isFavorite: true,
                        ),
                      ),
                    ).then((_) {
                      setState(() {
                      });
                    });
                  },
                  child: ItemNote(
                    title: note.title,
                    text: note.text,
                    imageUrl: note.imageUrl,
                    price: note.price,
                    isFavorite: widget.favoriteNotes.contains(note),
                    onToggleFavorite: () => widget.onFavoriteToggle(note),
                    onAddToCart: () => widget.onAddToCart(note),
                  ),
                );
              },
            ),
    );
  }
}
