import 'package:flutter/material.dart';
import '../models/note.dart';

class NotePage extends StatelessWidget {
  final Note note;
  final VoidCallback onDelete;

  const NotePage({
    Key? key,
    required this.note,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use a `WillPopScope` to handle back navigation if needed
    return WillPopScope(
      onWillPop: () async {
        // You can perform any additional actions here
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(note.title),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Image.network(
                    note.imageUrl,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 100,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  note.text,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Confirm deletion
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Подтверждение удаления'),
                          content: const Text(
                              'Вы уверены, что хотите удалить этот товар?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Отмена'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Call the onDelete callback
                                onDelete();

                                // Close the dialog
                                Navigator.of(context).pop();

                                // Navigate back to the main page
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                              },
                              child: const Text('Удалить'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Center(child: const Text('Удалить')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
