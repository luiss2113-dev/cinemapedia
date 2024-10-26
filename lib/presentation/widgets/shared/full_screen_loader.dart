import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<Widget> getLoadingMessages() {
    const messages = <Widget>[
      Text('Cargado peliculas'),
      Text("Comprando palomitas de maíz"),
      Text("Cargando populares"),
      Text("Llamando a mi novia pa las pelis"),
      Text("Ya casitoooooo!"),
      Text("Esto está tardando más que el fin de semana"),
    ];

    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return FadeIn(
        key: UniqueKey(),
        child: messages[step],
      );
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere por favor'),
          const SizedBox(
            height: 10,
          ),
          const CircularProgressIndicator(),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text('Cargando...');
              }

              return snapshot.data!;
            },
          )
        ],
      ),
    );
  }
}
