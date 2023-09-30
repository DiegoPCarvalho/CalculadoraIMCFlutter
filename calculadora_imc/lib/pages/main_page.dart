import 'package:calculadora_imc/model/peso_altura.dart';
import 'package:calculadora_imc/repository/peso_altura_repository.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var pesoController = TextEditingController();
  var alturaController = TextEditingController();
  var _pesoAltura = const <PesoAltura>[];

  var pesoAlturaRepository = PesoAlturaRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obterDados();
  }

  void obterDados() async {
    _pesoAltura = await pesoAlturaRepository.listarCalculo();
  }

  resultado(imc) {
    if (imc < 16) {
      return Text("IMC: ${imc.toStringAsFixed(1)} - Magreza Grave");
    } else if ((imc >= 16) && (imc < 17)) {
      return Text("IMC: ${imc.toStringAsFixed(1)} - Magreza Moderada");
    } else if ((imc >= 17) && (imc < 18.5)) {
      return Text("IMC: ${imc.toStringAsFixed(1)} - Magreza Leve");
    } else if ((imc >= 18.5) && (imc < 25)) {
      return Text("IMC: ${imc.toStringAsFixed(1)} - Saudável");
    } else if ((imc <= 25) && (imc < 30)) {
      return Text("IMC: ${imc.toStringAsFixed(1)} - Sobrepeso");
    } else if ((imc <= 30) && (imc < 35)) {
      return Text("IMC: ${imc.toStringAsFixed(1)} - Obesidade Grau I");
    } else if ((imc <= 35) && (imc < 40)) {
      return Text(
          "IMC: ${imc.toStringAsFixed(1)} - Obesidade Grau II - (Severa)");
    } else {
      return Text(
          "IMC: ${imc.toStringAsFixed(1)} - Obesidade Grau III - (Mórbida)");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Calculadora IMC",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            backgroundColor: Colors.greenAccent[400],
          ),
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.calculate),
              onPressed: () {
                pesoController.text = "";
                alturaController.text = "";
                showDialog(
                    context: context,
                    builder: (BuildContext bc) {
                      return AlertDialog(
                        title: const Text(
                          "Calcule o seu IMC",
                          style: TextStyle(fontSize: 20),
                        ),
                        content: Wrap(
                          children: [
                            const Text("Peso"),
                            TextField(
                              controller: pesoController,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Altura"),
                            TextField(
                              controller: alturaController,
                            )
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancelar")),
                          TextButton(
                              onPressed: () async {
                                double peso = double.parse(pesoController.text);
                                double altura =
                                    double.parse(alturaController.text);

                                double resultado = (peso / (altura * altura));
                                await pesoAlturaRepository.adicionar(
                                    PesoAltura(peso, altura, resultado));
                                Navigator.pop(context);
                                setState(() {});
                              },
                              child: const Text("Calcular"))
                        ],
                      );
                    });
              }),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListView.builder(
                itemCount: _pesoAltura.length,
                itemBuilder: (BuildContext bc, int index) {
                  var pesoAltura = _pesoAltura[index];
                  // String peso = pesoAltura.peso.toString();
                  // return Row(
                  //   children: [
                  //     Text("Peso: ${pesoAltura.peso.toString()}"),
                  //     Text("Altura: ${pesoAltura.altura.toString()}"),
                  //     Text("IMC: ${pesoAltura.resultado.toString()}")
                  //   ],
                  // );
                  return Card(
                    child: ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext bc) {
                              return AlertDialog(
                                title: resultado(pesoAltura.resultado),
                              );
                            });
                      },
                      title: Text("Peso: ${pesoAltura.peso.toString()} Kg"),
                      subtitle:
                          Text("Altura: ${pesoAltura.altura.toString()} M"),
                      trailing: Text(
                          "IMC: ${pesoAltura.resultado.toStringAsFixed(1)}"),
                    ),
                  );
                }),
          )),
    );
  }
}
