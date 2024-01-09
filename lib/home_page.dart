import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  const HomePage({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Home Page'),),
           body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
             children: [
               ElevatedButton(
                onPressed: () {},
                child: const Text('SetState')),
                 ElevatedButton(
                onPressed: () {},
                child: const Text('ValueNotifier')
                ),
                 ElevatedButton(
                onPressed: () {},
                child: const Text('ChangeNotifier')
                ),
                 ElevatedButton(
                onPressed: () {},
                child: const Text('Bloc Pattern (Streams)')
                ),
             ],
           )),
       );
  }
}