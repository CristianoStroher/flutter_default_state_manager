//!criamos essa classe para ser a controle do bloc, muito parecido como change notifier porém
//!com streams
import 'dart:async';
import 'dart:math';
import 'package:flutter_default_state_manager/bloc_pattern/imc_state.dart';

class ImcBlocPatternController {

final _imcStreamController = StreamController<ImcState>()
  ..add(ImcState(imc: 0.0)); //instaciar uma StreamContrller escolhendo 
  //o tipo que é uma classe de estado e ja fazer ele inicar com um dado que é 0 (adiciona um valor a stream)
Stream<ImcState> get imcOut => _imcStreamController.stream;
//pode usar o Sink... mas usa mais esse abaixo.

//!inserir o calculo do imc
Future<void> calcularImc ({ required double peso, required double altura}) async {
  _imcStreamController.add(ImcState(imc: 0.0));
  await Future.delayed(const Duration(seconds: 1));
  final imc = peso / pow(altura, 2);
  _imcStreamController.add(ImcState(imc: imc));
  }

//ela precisa ser fechada essa conexão
void dispose(){
  _imcStreamController.close();
}
  
}