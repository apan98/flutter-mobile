import 'package:flutter/material.dart';
import 'link_list_screen.dart';  // не забудьте импортировать link_list_screen.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LinkListScreen(),  // здесь мы заменили MyHomePage на LinkListScreen
    );
  }
}
