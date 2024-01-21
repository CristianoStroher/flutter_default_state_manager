
import 'dart:math';

import 'package:flutter/material.dart';

class ImcChangeNotifierControler extends ChangeNotifier{
  var imc = 0.0;

  Future<void> calcularIMC ({required double peso, required double altura}) async {
    imc = 0;
    notifyListeners(); //! esss classe vai ficar escutando as respostas nesse caso o 0
    await Future.delayed(const Duration(seconds: 1));
    imc = peso / pow(altura, 2);
    notifyListeners(); //! agora para o calculo do imc

  }

  
}