import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

 double taxa = 0;
  double totalconta = 0, totalpagar = 0, comissao = 0;
  int qtdpessoas = 0;

  TextEditingController txttotal = TextEditingController();
  TextEditingController txtqtd = TextEditingController();

  void calcularconta() {
    setState(() {
      totalconta = double.parse(txttotal.text);
      qtdpessoas = int.parse(txtqtd.text);

      comissao = (taxa * totalconta) / 100;

      totalpagar = (totalconta + comissao) / qtdpessoas;

      showDialog(
        
        context: context,
        builder: (context) => AlertDialog(
          
          title: Text("Total a pagar por pessoa"),
          content: Column(
            
            children: [
              Image.asset(
                "assets/smile-removebg-preview.png",
                width: 60,
              ),
              Text("O Total da conta: é $totalconta"),
              Text("Taxa do garçon: é $comissao"),
              Text("Total por pessoa: é $totalpagar"),
            ],
            
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Fechar"),
            )
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RACHA CONTA"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: SvgPicture.asset('assets/icons8-carteira-96.svg'),
              ),
              TextField(
                controller: txttotal,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(labelText: "Total da conta"),
                style: TextStyle(fontSize: 18),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Taxa de serviços %",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    value: taxa,
                    onChanged: (double valor) {
                      setState(() {
                        taxa = valor;
                      });
                    },
                    min: 0,
                    max: 10,
                    label: "$taxa%",
                    divisions: 10,
                    activeColor: Colors.orange,
                    inactiveColor: Colors.grey,
                  )
                ],
              ),
              TextField(
                controller: txtqtd,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(labelText: "Qtd pessoas"),
                style: TextStyle(fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: calcularconta,
                    child: Text("Calcular", style: TextStyle(fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      textStyle: const TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
