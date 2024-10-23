import 'globals.dart';
import 'card_template.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.only(top: 60, left: 30),
            child: Text(
              'Каталог услуг',
              textAlign: TextAlign.left,
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 24 / 28
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CardTemplate(
                      item: item,
                      onQuantityChanged: () {
                        setState(() {});
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
