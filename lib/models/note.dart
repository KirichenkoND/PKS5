// lib/models/note.dart
class Note {
  final int? id;
  final String title;
  final String text;
  final String imageUrl;
  final double price;

  Note(this.title, this.text, this.imageUrl, this.price, {this.id});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      json['name'],
      json['description'],
      json['image_url'],
      (json['price'] as num).toDouble(),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
      'description': text,
      'image_url': imageUrl,
      'price': price,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Note && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
