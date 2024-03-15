import 'package:cifrador/views/widgets/Generador.dart';
import 'package:flutter/material.dart';

class PageGenerador extends StatefulWidget {
  @override
  State<PageGenerador> createState() => _PageGeneradorState();
}

class _PageGeneradorState extends State<PageGenerador> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: generador(),
      ),
    );
  }
}
