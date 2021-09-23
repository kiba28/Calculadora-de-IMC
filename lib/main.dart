import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _infoText = "Informe seus dados.";

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText =
            "Seu IMC é: ${imc.toStringAsPrecision(4)} \nVocê está abaixo do peso.";
      } else if (imc >= 18.6 && imc < 25) {
        _infoText =
            "Seu IMC é: ${imc.toStringAsPrecision(4)} \nVocê está com um peso saudável.";
      } else if (imc >= 25 && imc < 30) {
        _infoText =
            "Seu IMC é: ${imc.toStringAsPrecision(4)} \nVocê está com sobrepeso.";
      } else if (imc >= 30 && imc < 35) {
        _infoText =
            "Seu IMC é: ${imc.toStringAsPrecision(4)} \nVocê está com obsesidade grau 1.";
      } else if (imc >= 35 && imc < 40) {
        _infoText =
            "Seu IMC é: ${imc.toStringAsPrecision(4)} \nVocê está com obsesidade grau 2.";
      } else {
        _infoText =
            "Seu IMC é: ${imc.toStringAsPrecision(4)} \nVocê está com obesidade grau 3 (obesidade mórbida).";
      }
    });
  }

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          actions: [
            IconButton(
              onPressed: _resetFields,
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.person_outline,
                      size: 120.0, color: Colors.deepPurple),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Peso (kg):",
                        labelStyle: TextStyle(color: Colors.deepPurple)),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.deepPurple, fontSize: 25.0),
                    controller: weightController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Insira seu peso!";
                      }
                    },
                  ),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: "Altura (cm):",
                          labelStyle: TextStyle(color: Colors.deepPurple)),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.deepPurple, fontSize: 25.0),
                      controller: heightController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Insira sua Altura!";
                        }
                      }),
                  Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _calculate();
                          }
                        },
                        child: const Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                          fixedSize: const Size.fromHeight(50),
                        ),
                      )),
                  Text(
                    _infoText,
                    style: const TextStyle(
                        color: Colors.deepPurple, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )));
  }
}
