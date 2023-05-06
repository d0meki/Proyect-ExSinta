import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proy_sistemas_expertos/provider/base_conocimiento_provider.dart';
import 'package:proy_sistemas_expertos/provider/formulario_new_regla.dart';

class ListRules extends StatelessWidget {
  const ListRules({super.key});
  @override
  Widget build(BuildContext context) {
    final baseConocimientoProvider = context.watch<BaseConocimientoProvider>();

    return Scaffold(
      appBar: AppBar(
        title: (baseConocimientoProvider.nameFile == "")
            ? const Text('Lista Reglas')
            : Text('Lista Reglas \nDoc: ${baseConocimientoProvider.nameFile}'),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            child: const Icon(Icons.add_sharp),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return PersonalAlertDialog(
                        baseConocimientoProvider: baseConocimientoProvider);
                  });
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              child: const Icon(Icons.folder_open_outlined),
              onTap: () {
                baseConocimientoProvider.getListArchivos();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return PersonalDialog(
                          baseConocimientoProvider: baseConocimientoProvider);
                    });
              },
            ),
          )
        ],
      ),
      body: (baseConocimientoProvider.baseConocimiento.reglas.isNotEmpty &&
              baseConocimientoProvider.baseConocimiento.variables.isNotEmpty)
          ? ListView.builder(
              itemCount:
                  baseConocimientoProvider.baseConocimiento.reglas.length,
              itemBuilder: (context, index) {
                if (baseConocimientoProvider
                    .baseConocimiento.reglas.isNotEmpty) {
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text("Regla ${index + 1}"),
                      subtitle: Text(baseConocimientoProvider
                          .baseConocimiento.reglas[index].nombre),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      onTap: (() {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DialogoOpciones(
                                baseConocimientoProvider:
                                    baseConocimientoProvider,
                                posicion: index,
                              );
                            });
                      }),
                    ),
                  );
                }
                return const Center(
                  child: Text("Esta BCM no tiene Reglas"),
                );
              },
            )
          : const Center(
              child: Text("Reglas [ ], Variables[ ]"),
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 1,
            onPressed: (baseConocimientoProvider.nameFile.isNotEmpty)
                ? () async {
                    if (baseConocimientoProvider
                        .baseConocimiento.variables.isNotEmpty) {
                      Navigator.pushNamed(context, 'new_rule');
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const VariablesVacias();
                        },
                      );
                    }
                  }
                : null,
            label: const Text('Nueva Regla'),
            icon: const Icon(Icons.thumb_up),
            backgroundColor: Colors.pink,
          ),
          const SizedBox(
            height: 5,
          ),
          FloatingActionButton.extended(
            heroTag: 2,
            onPressed: (baseConocimientoProvider.nameFile.isNotEmpty)
                ? () {
                    Navigator.pushNamed(context, 'list_variable');
                  }
                : null,
            label: const Text('Variables'),
            icon: const Icon(Icons.remove_red_eye),
            backgroundColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}

class VariablesVacias extends StatelessWidget {
  const VariablesVacias({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: const Text('No puede crear Reglas si no tiene Variables'),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}

class PersonalAlertDialog extends StatelessWidget {
  PersonalAlertDialog({
    Key? key,
    required this.baseConocimientoProvider,
  }) : super(key: key);
  final BaseConocimientoProvider baseConocimientoProvider;
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        SizedBox(
          height: 150,
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                  child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                    icon: Icon(Icons.abc), labelText: "Nombre de la BCM"),
              ))),
        ),
        TextButton(
          child: const Text('Crear BCM'),
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              baseConocimientoProvider
                  .setNuevaBaseConocimiento(_controller.text);
            }
            Navigator.pop(context);
          },
        ),
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this
    );
  }
}

class PersonalDialog extends StatelessWidget {
  const PersonalDialog({
    Key? key,
    required this.baseConocimientoProvider,
  }) : super(key: key);
  final BaseConocimientoProvider baseConocimientoProvider;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: SizedBox(
        width: 300.0,
        height: baseConocimientoProvider.tamanioDialog,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
            itemCount: baseConocimientoProvider.listaArchivos.length,
            itemBuilder: (context, index) {
              return Card(
                child: GestureDetector(
                  child: ListTile(
                    title: Text(baseConocimientoProvider.listaArchivos[index]),
                  ),
                  onDoubleTap: () {
                    baseConocimientoProvider.setBaseConocimiento(
                        baseConocimientoProvider.listaArchivos[index]);
                    Navigator.pop(context);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class DialogoOpciones extends StatelessWidget {
  const DialogoOpciones(
      {Key? key,
      required this.baseConocimientoProvider,
      required this.posicion})
      : super(key: key);

  final BaseConocimientoProvider baseConocimientoProvider;
  final int posicion;

  @override
  Widget build(BuildContext context) {
    final formRegla = context.watch<FormularioNewReglaProvider>();
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: SizedBox(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Text(
                'OPCIONES',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      baseConocimientoProvider.setReglaPosicion(posicion);
                      formRegla.listLiteral = baseConocimientoProvider
                          .baseConocimiento.reglas[posicion].premisa.literal;
                      formRegla.listHecho = baseConocimientoProvider
                          .baseConocimiento.reglas[posicion].hecho;
                      baseConocimientoProvider.setReglaPosicion(posicion);
                      Navigator.pushNamed(context, 'edit_rule');
                    },
                    child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/img/edit.png',
                                height: 60,
                                width: 60,
                              ),
                              const Text('Editar'),
                            ],
                          ),
                        )),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      baseConocimientoProvider.deLeteRegla(posicion);
                    },
                    child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/img/delete.png',
                                height: 60,
                                width: 60,
                              ),
                              const Text('Eliminar'),
                            ],
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
