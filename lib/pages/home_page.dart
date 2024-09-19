import 'package:flutter/material.dart';
import 'package:flutter_application_3/components/item_note.dart';
import '../models/note.dart';
import 'note_page.dart';

final List<Note> notes = [
  Note(
      "6.1 Смартфон Apple iPhone 15 128 ГБ черный",
      "Смартфон Apple iPhone 14 – компактная модель с безрамочным дисплеем OLED 6.1 дюйма. Стеклянный корпус мобильного устройства соответствует стандарту защищенности IP68 – он устойчив к воздействию влаги и пыли. Передняя панель обладает покрытием Ceramic Shield для защиты экрана от появления царапин и различных дефектов. Основная сдвоенная камера 12+12 Мп со вспышкой True Tone и целым рядом режимов позволяет создавать снимки профессионального качества в любых условиях освещенности. Камера 12 Мп на передней стороне предназначена для селфи и качественной видеосвязи. Среди особенностей Apple iPhone 14 – чип Apple A15 Bionic с 5-ядерным GPU, широкий набор интерфейсов (NFC, 5G, GPS, Wi-Fi и Bluetooth), длительное время автономности, поддержка аксессуаров и устройств MagSafe с магнитной беспроводной зарядкой.",
      "https://c.dns-shop.ru/thumb/st1/fit/320/250/5cbace062696b0104c9c2f01cf18cc33/2258685cc32bbd96de406852bd9b2d94916029658cd6fa120a9f97a4bc0af297.jpg"),
  Note(
      "6.1 Смартфон Apple iPhone 14 128 ГБ черный",
      "Основная сдвоенная камера 12+12 Мп со вспышкой True Tone и целым рядом режимов позволяет создавать снимки профессионального качества в любых условиях освещенности. Камера 12 Мп на передней стороне предназначена для селфи и качественной видеосвязи. Среди особенностей Apple iPhone 14 – чип Apple A15 Bionic с 5-ядерным GPU, широкий набор интерфейсов (NFC, 5G, GPS, Wi-Fi и Bluetooth), длительное время автономности, поддержка аксессуаров и устройств MagSafe с магнитной беспроводной зарядкой.",
      "https://c.dns-shop.ru/thumb/st4/fit/300/300/0f85b550e02daeb3688bb4e4658b2e90/79b6b9cbb58bf72e530b8f421054342f84e2ad9e8066e381150639afb3b80917.jpg"),
  Note(
      "6.1 Смартфон Apple iPhone 14 512 ГБ черный",
      "Основная сдвоенная камера 12+12 Мп со вспышкой True Tone и целым рядом режимов позволяет создавать снимки профессионального качества в любых условиях освещенности. Камера 12 Мп на передней стороне предназначена для селфи и качественной видеосвязи. Среди особенностей Apple iPhone 14 – чип Apple A15 Bionic с 5-ядерным GPU, широкий набор интерфейсов (NFC, 5G, GPS, Wi-Fi и Bluetooth), длительное время автономности, поддержка аксессуаров и устройств MagSafe с магнитной беспроводной зарядкой.",
      "https://c.dns-shop.ru/thumb/st4/fit/300/300/0f85b550e02daeb3688bb4e4658b2e90/79b6b9cbb58bf72e530b8f421054342f84e2ad9e8066e381150639afb3b80917.jpg"),
];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Витрина Айфонов"),
      ),
      body: ListView.builder(
        itemCount: notes.length, // Используем длину списка notes
        itemBuilder: (BuildContext context, int index) {
          final note = notes[index]; // Получаем текущую заметку
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      NotePage(note: note), // Передаем заметку
                ),
              );
            },
            child: ItemNote(
              title: note.title,
              text: note.text,
              imageUrl: note.imageUrl,
            ),
          );
        },
      ),
    );
  }
}
