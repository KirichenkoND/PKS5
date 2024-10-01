// components/item_mote.dart
import 'package:flutter/material.dart';

class ItemNote extends StatelessWidget {
  final String title;
  final String text;
  final String imageUrl;

  const ItemNote({
    Key? key,
    required this.title,
    required this.text,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 100,
                );
              },
            ),
          ),
          ListTile(
            title: Text(title),
            subtitle: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
