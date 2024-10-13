import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/home_page.dart';
import 'package:flutter_application_3/pages/favorites_page.dart';
import 'package:flutter_application_3/pages/profile_page.dart';
import 'models/note.dart';
import 'pages/cart_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter ПКС5_6',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final Set<Note> favoriteNotes = {};
  Map<Note, int> cartItems = {};

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleFavorite(Note note) {
    setState(() {
      if (favoriteNotes.contains(note)) {
        favoriteNotes.remove(note);
      } else {
        favoriteNotes.add(note);
      }
    });
  }

  void _addToCart(Note note) {
    setState(() {
      if (cartItems.containsKey(note)) {
        cartItems[note] = cartItems[note]! + 1;
      } else {
        cartItems[note] = 1;
      }
    });
  }

  void _removeFromCart(Note note) {
    setState(() {
      if (cartItems.containsKey(note)) {
        if (cartItems[note]! > 1) {
          cartItems[note] = cartItems[note]! - 1;
        } else {
          cartItems.remove(note);
        }
      }
    });
  }

  void _deleteFromCart(Note note) {
    setState(() {
      cartItems.remove(note);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePage(
        favoriteNotes: favoriteNotes,
        onFavoriteToggle: _toggleFavorite,
        onAddToCart: _addToCart,
      ),
      FavoritesPage(
        favoriteNotes: favoriteNotes,
        onFavoriteToggle: _toggleFavorite,
        onAddToCart: _addToCart,
      ),
      CartPage(
        cartItems: cartItems,
        onAdd: _addToCart,
        onRemove: _removeFromCart,
        onDelete: _deleteFromCart,
      ),
      const ProfilePage(),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),
                if (cartItems.isNotEmpty)
                  Positioned(
                    right: 0,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        '${cartItems.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Корзина',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
