import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proy_sistemas_expertos/provider/base_conocimiento_provider.dart';
import 'package:proy_sistemas_expertos/provider/formulario_new_regla.dart';
import 'package:proy_sistemas_expertos/provider/formulario_provider.dart';
import 'package:proy_sistemas_expertos/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((_) => BaseConocimientoProvider())),
        ChangeNotifierProvider(create: ((_) => FormularioProvider())),
        ChangeNotifierProvider(create: ((_) => FormularioNewReglaProvider())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        initialRoute: Routes.initialRoute,
        routes: Routes.routes,
      ),
    );
  }
}
