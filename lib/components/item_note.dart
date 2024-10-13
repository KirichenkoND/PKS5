// components/item_mote.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemNote extends StatelessWidget {
  final String title;
  final String text;
  final String imageUrl;
  final double price;
  final VoidCallback onAddToCart;
  final VoidCallback onToggleFavorite;
  final bool isFavorite;

  const ItemNote({
    Key? key,
    required this.title,
    required this.text,
    required this.imageUrl,
    required this.price,
    required this.onAddToCart,
    required this.onToggleFavorite,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'ru_RU',
      symbol: '₽',
      decimalDigits: 2,
    );

    final formattedPrice = currencyFormat.format(price);
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Column(
            children: [
              Image.network(
                imageUrl,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 100,
                  );
                },
              ),
              ListTile(
                title: Text(
                  title,
                  style: const TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              Text(
                'Цена: $formattedPrice',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: onToggleFavorite,
                ),
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: onAddToCart,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
