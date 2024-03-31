import 'package:flutter/material.dart';
import 'dart:math' as math;
// import 'package:flutter/widgets.dart';

void main() {
  runApp(const ListaAfazeres());
}

class ListaAfazeres extends StatefulWidget {
  const ListaAfazeres({super.key});

  @override
  State<ListaAfazeres> createState() => _ListaAfazeresState();
}

class _ListaAfazeresState extends State<ListaAfazeres> {
  List<Tarefa> tarefas = [];
  TextEditingController controlador = TextEditingController();
  String modo = 'add';
  String addOuEditar = 'Adicionar';
  int indiceLista = -1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de tarefas',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de tarefas'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: tarefas.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(tarefas[index].titulo),
                        trailing: Container(
                          width: 70,
                          child: Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  value: tarefas[index].status,
                                  onChanged: (bool? novoValor) {
                                    setState(() {
                                      tarefas[index].status = novoValor!;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  onPressed: (){
                                    addOuEditar = 'Alterar';
                                    controlador.text = tarefas[index].titulo;
                                    modo = 'editar';
                                    indiceLista = index;
                                  }, 
                                  icon: const Icon(Icons.edit),
                                ),
                              ), 
                              Expanded(
                                child: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      tarefas.remove(tarefas[index]);
                                      modo = 'add';
                                      addOuEditar = 'Adicionar';
                                      controlador.clear();
                                    });
                                  }, 
                                  icon: const Icon(Icons.delete),
                                ), 
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Descrição',
                        border: OutlineInputBorder(),
                      ),
                      controller: controlador,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (controlador.text.isNotEmpty && modo == 'add') {
                          setState(() {
                            tarefas.add(Tarefa(
                                titulo: controlador.text, status: false));
                            controlador.clear();
                          });
                        }else if (controlador.text.isNotEmpty && modo == 'editar'){
                          setState(() {
                            tarefas[indiceLista].titulo = controlador.text;
                            modo = 'add';
                            addOuEditar = 'Adicionar';
                            controlador.clear();
                          });
                        }
                      },
                      child: Text(addOuEditar),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Tarefa {
  String titulo;
  bool status;

  Tarefa({required this.titulo, required this.status});
}