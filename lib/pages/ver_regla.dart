import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proy_sistemas_expertos/provider/base_conocimiento_provider.dart';

class VerRegla extends StatelessWidget {
  const VerRegla({super.key});

  @override
  Widget build(BuildContext context) {
    final baseConocimientoProvider = context.watch<BaseConocimientoProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Regla')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'IF',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          Flexible(
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                itemCount: baseConocimientoProvider
                    .baseConocimiento
                    .reglas[baseConocimientoProvider.reglaPosicion]
                    .premisa
                    .literal
                    .length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, top: 5),
                    child: (index > 0 && index < (baseConocimientoProvider
                    .baseConocimiento
                    .reglas[baseConocimientoProvider.reglaPosicion]
                    .premisa
                    .literal
                    .length-1))
                        ? Text(
                            '${baseConocimientoProvider.baseConocimiento.reglas[baseConocimientoProvider.reglaPosicion].premisa.literal[index].variable} ${baseConocimientoProvider.baseConocimiento.reglas[baseConocimientoProvider.reglaPosicion].premisa.literal[index].operadorLogico} ${baseConocimientoProvider.baseConocimiento.reglas[baseConocimientoProvider.reglaPosicion].premisa.literal[index].valor}',
                          )
                        : Text(
                            'AND ${baseConocimientoProvider.baseConocimiento.reglas[baseConocimientoProvider.reglaPosicion].premisa.literal[index].variable} ${baseConocimientoProvider.baseConocimiento.reglas[baseConocimientoProvider.reglaPosicion].premisa.literal[index].operadorLogico} ${baseConocimientoProvider.baseConocimiento.reglas[baseConocimientoProvider.reglaPosicion].premisa.literal[index].valor}',
                          ),
                  );
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('THEN',
                style: TextStyle(
                  color: Colors.red,
                )),
          ),
          Flexible(
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                itemCount: baseConocimientoProvider
                    .baseConocimiento
                    .reglas[baseConocimientoProvider.reglaPosicion]
                    .hecho
                    .length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, top: 5),
                    child: Text(
                      '${baseConocimientoProvider.baseConocimiento.reglas[baseConocimientoProvider.reglaPosicion].hecho[i].variable} = ${baseConocimientoProvider.baseConocimiento.reglas[baseConocimientoProvider.reglaPosicion].hecho[i].valor}',
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
