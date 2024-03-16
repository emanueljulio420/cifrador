import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class generador extends StatefulWidget {
  @override
  State<generador> createState() => _generadorState();
}

class _generadorState extends State<generador> {
  List<String> abecedario = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];

  List<String> numeros = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];

  List<String> simbolos = [
    "@",
    "/",
    "?",
    "¿",
    "¡",
    "!",
    "",
    "#",
    "%",
    "&",
    "(",
    ")",
    "|",
    "°",
    "[",
    "]",
    "{",
    "}",
    "+",
    "^",
    "¬",
    "~"
  ];

  Map<String, dynamic> values = {
    'tipoDeLectura': "",
    'mayusculas': false,
    'minusculas': false,
    'numeros': false,
    'simbolos': false,
    'enableNumeros': true,
    'enableSimbolos': true,
    'sliderValue': 0
  };

  double sliderValue = 0;

  TextEditingController _lengthPasswordcontroller = TextEditingController();

  TextEditingController _Passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              getTextFieldPassword(),
              Container(
                color: Colors.white38,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    const Text(
                      "Personalice su contraseña",
                      style: TextStyle(fontSize: 24),
                    ),
                    getSlider(),
                    getRadios(),
                    getCheacks()
                  ]),
                ),
              )
            ],
          )),
    );
  }

  Column getCheacks() {
    return Column(children: [
      CheckboxListTile(
        enabled: values["enableMayusculas"],
        title: const Text("Mayúsculas"),
        value: values["mayusculas"],
        onChanged: (newValue) {
          values["mayusculas"] = newValue;
          setState(() {});
        },
      ),
      CheckboxListTile(
        enabled: values["enableMinusculas"],
        title: const Text("Minúsculas"),
        value: values["minusculas"],
        onChanged: (newValue) {
          values["minusculas"] = newValue;
          setState(() {});
        },
      ),
      CheckboxListTile(
        enabled: values["enableNumeros"],
        title: const Text("Números"),
        value: values["numeros"],
        onChanged: (newValue) {
          values["numeros"] = newValue;
          setState(() {});
        },
      ),
      CheckboxListTile(
        enabled: values["enableSimbolos"],
        title: const Text("Símbolos"),
        value: values["simbolos"],
        onChanged: (newValue) {
          values["simbolos"] = newValue;
          setState(() {});
        },
      )
    ]);
  }

  Column getRadios() {
    return Column(
      children: [
        RadioListTile(
          title: const Text("Facil de decir"),
          value: 'Decir',
          groupValue: values["tipoDeLectura"],
          onChanged: (newValue) {
            values["tipoDeLectura"] = newValue;
            values["mayusculas"] = true;
            values["minusculas"] = true;
            values["enableNumeros"] = false;
            values["enableSimbolos"] = false;
            values["numeros"] = false;
            values["simbolos"] = false;
            setState(() {});
          },
        ),
        RadioListTile(
          title: const Text("Todos los caracteres"),
          value: 'Todos',
          groupValue: values["tipoDeLectura"],
          onChanged: (newValue) {
            values["tipoDeLectura"] = newValue;
            values["mayusculas"] = true;
            values["minusculas"] = true;
            values["numeros"] = true;
            values["simbolos"] = true;
            values["enableNumeros"] = true;
            values["enableSimbolos"] = true;
            setState(() {});
          },
        )
      ],
    );
  }

  Row getSlider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            width: 40,
            child: TextField(
              keyboardType: TextInputType.number,
              maxLength: 2,
              textAlign: TextAlign.center,
              controller: _lengthPasswordcontroller,
              onChanged: (value) {
                sliderValue = double.parse(_lengthPasswordcontroller.text);
                values["sliderValue"] =
                    double.parse(_lengthPasswordcontroller.text);
                setState(() {});
              },
            )),
        Slider(
            value: sliderValue,
            min: 0,
            max: 99,
            divisions: 99,
            onChanged: (double newValue) {
              _lengthPasswordcontroller.text = '${sliderValue.ceil()}';
              values["sliderValue"] = sliderValue.ceil();
              setState(() {
                sliderValue = newValue;
              });
            })
      ],
    );
  }

  LayoutBuilder getTextFieldPassword() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
            color: Colors.white38,
            child: Row(
              children: [
                Container(
                    width: constraints.maxWidth * 0.8,
                    child: TextField(
                        controller: _Passwordcontroller,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center)),
                Container(
                  alignment: Alignment.center,
                  width: constraints.maxWidth * 0.2,
                  child: IconButton(
                      onPressed: generatePassword,
                      icon: const Icon(Icons.refresh)),
                )
              ],
            ));
      },
    );
  }

  void generatePassword() {
    String password = "";
    var random = Random();
    int j = 0;
    int k = 0;

    for (var i = 0; i < values["sliderValue"] + 1; i++) {
      j = random.nextInt(4);

      if (j == 0 && values["mayusculas"]) {
        k = random.nextInt(abecedario.length);
        password = password + "${abecedario[k]}";
      }

      if (j == 1 && values["minusculas"]) {
        k = random.nextInt(abecedario.length);
        password = password + "${abecedario[k].toLowerCase()}";
      }

      if (j == 2 && values["numeros"]) {
        k = random.nextInt(numeros.length);
        password = password + "${numeros[k]}";
      }

      if (j == 3 && values["simbolos"]) {
        k = random.nextInt(simbolos.length);
        password = password + "${simbolos[k]}";
      }

      if (password.length < i) {
        i--;
      }
    }
    _Passwordcontroller.text = password;
  }
}
