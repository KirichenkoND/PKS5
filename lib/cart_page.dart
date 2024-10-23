import 'globals.dart';
import 'card_template.dart';
import 'package:flutter/material.dart';
import 'position_model.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int calculateTotalPrice() {
    return items
        .where((item) => item.added > 0)
        .fold(0, (sum, item) => sum + (item.price * item.added));
  }

  @override
  Widget build(BuildContext context) {
    List<PositionModel> filteredItems = items.where((item) => item.added > 0).toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.only(top: 60, left: 30),
              child: Text(
                'Корзина',
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  height: 24 / 28,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Сумма',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${calculateTotalPrice()} ₽',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 60,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff1a6fee),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              'Перейти к оформлению заказа',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
