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
    return Scaffold(
      // appBar: AppBar(title: const Text("Никита")),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Image.network("https://i.pinimg.com/736x/11/b1/a1/11b1a1407248ed7e7e9919cbce18c525.jpg"),

          const Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(decoration: InputDecoration(
              hintText: "Login",
              border: OutlineInputBorder(),
            ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(decoration: InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(),
            ),
            ),
          ),

          ElevatedButton(onPressed: (){}, child: const Text("LogIn")),

        TextButton(onPressed: (){}, child: Text('Registration')),


          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Center(
          //     child: Container(color: Colors.amberAccent, width: 200, height: 100,
          //       child: const Center(child: Text("5", style: TextStyle(fontSize: 30,)
          //       )
          //       ),
          //     ),
          //   ),
          // ),

        ],
      ),
    );
  }
}
