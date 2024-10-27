// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import '../models/note.dart';
import '../components/item_note.dart';
import '../pages/note_page.dart';
import '../pages/add_note_page.dart';
import '../api/api_service.dart';

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
  List<Note> currentNotes = [];
  final ApiService _apiService = ApiService();
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchNotes();
  }

  Future<void> _fetchNotes() async {
    try {
      final notes = await _apiService.getNotes();
      if (!mounted) return;
      setState(() {
        currentNotes = notes;
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Ошибка при загрузке данных';
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при обновлении данных: $e')),
      );
    }
  }

  void _addNote(Note note) async {
    try {
      final newNote = await _apiService.createNote(note);
      if (!mounted) return;
      setState(() {
        currentNotes.add(newNote);
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при добавлении товара: $e')),
      );
    }
  }

  void _deleteNote(Note note) async {
    try {
      await _apiService.deleteNote(note.id!);
      if (!mounted) return;
      setState(() {
        currentNotes.remove(note);
        widget.favoriteNotes.remove(note);
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при удалении товара: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Витрина Айфонов"),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Витрина Айфонов"),
        ),
        body: Center(child: Text(_errorMessage!)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Витрина Айфонов"),
      ),
      body: RefreshIndicator(
        onRefresh: _fetchNotes,
        child: currentNotes.isEmpty
            ? const Center(
                child: Text(
                  'Нет доступных товаров',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemCount: currentNotes.length,
                itemBuilder: (BuildContext context, int index) {
                  final note = currentNotes[index];
                  final isFavorite = widget.favoriteNotes.contains(note);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotePage(
                            note: note,
                            onDelete: () => _deleteNote(note),
                            onAddToCart: widget.onAddToCart,
                            onToggleFavorite: widget.onFavoriteToggle,
                            isFavorite: isFavorite,
                          ),
                        ),
                      ).then((_) {
                        setState(() {});
                      });
                    },
                    child: ItemNote(
                      title: note.title,
                      text: note.text,
                      imageUrl: note.imageUrl,
                      price: note.price,
                      isFavorite: isFavorite,
                      onToggleFavorite: () => widget.onFavoriteToggle(note),
                      onAddToCart: () => widget.onAddToCart(note),
                    ),
                  );
                },
              ),
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
