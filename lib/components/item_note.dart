import 'package:flutter/material.dart';

class ItemNote extends StatelessWidget {
  final String title;
  final String text;
  final String imageUrl;

  const ItemNote({
    super.key,
    required this.title,
    required this.text,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.blue,
          border: Border.all(color: Colors.white, width: 2), // Бортик
        ),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Padding(
          padding: const EdgeInsets.all(
              16.0), // Общие отступы для текста и изображения
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  title, // Отображаем заголовок
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Image.network(
                imageUrl,
                height: 100,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, size: 100, color: Colors.red);
                },
              ), // Отображаем изображение
              const SizedBox(height: 10),
              Text(text, // Отображаем краткий текст
                  style: const TextStyle(color: Colors.white),
                  maxLines: 6,
                  textAlign: TextAlign.center, // Текст выравнен по центру
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }
}
