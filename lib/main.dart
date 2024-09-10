import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ЭФБО-03-22',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(), // Стартовый экран
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});



  @override
  Widget build(BuildContext context) {
    bool rememberMe = false;
    return Scaffold(
      // appBar: AppBar(title: const Text("Никита")),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 80),
            // Заголовок
            const Text(
              'Авторизация',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,

              ),
            ),
            const SizedBox(height: 120),


            // Поле для ввода Логина
            const TextField(
              decoration: InputDecoration(
                hintText: "Логин",
                filled: true,
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Поле для ввода Пароля
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Пароль",
                filled: true,
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Чекбокс "Запомнить меня"
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Центрирование содержимого
              children: [
                Checkbox(
                  value: rememberMe,
                  onChanged: null,
                ),
                const Text(
                  'Запомнить меня',
                  style: TextStyle(
                    color: Colors.grey, // Цвет, как у "Восстановить пароль"
                    fontSize: 16
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),


            // Кнопка "Войти"
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                "Войти",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),

            // Кнопка "Регистрация"
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              child: const Text(
                'Регистрация',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 6),

            // Ссылка "Восстановить пароль"
            TextButton(
              onPressed: () {},
              child: const Text(
                'Восстановить пароль',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
