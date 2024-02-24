import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String nome = '';
  String data = '';
  final RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
  Map<String, List<String>> guardaData = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Novo Lembrete')),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Nome do evento'),
                onChanged: (text) {
                  setState(() {
                    nome = text;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Insira a data do evento (no formato dd/mm/yyyy)'),
                onChanged: (text) {
                  setState(() {
                    data = text;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Row(
                  children: [
                    Text(
                      'Lista de Lembretes',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (nome.isEmpty || data.isEmpty) {
                            throw Exception(
                                "Os campos são obrigatórios a serem preenchidos");
                          } else if (!dateRegex.hasMatch(data)) {
                            throw Exception("Formato de data inválido");
                          } else {
                            
                            if (guardaData.containsKey(data)) {
                              
                              guardaData[data]!.add(nome);
                            } else {
                              
                              guardaData[data] = [nome];
                            }
                          }
                        });
                      },
                      child: Text('Criar'),
                    ),
                  ],
                ),
              ),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var entry in guardaData.entries)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Data: ${entry.key}',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  
                                  guardaData.remove(entry.key);
                                });
                              },
                              child: Image.asset(
                                'assets/image/botao-x.png',
                                height: 20,
                                width: 40,
                              ),
                            ),
                          ],
                        ),
                        for (var int in entry.value)
                          Text(' - $int'),
                        Divider(), 
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
