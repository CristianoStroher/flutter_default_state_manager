//!criamos essa classe para ser a controle do bloc, muito parecido como change notifier porém
//!com streams
import 'dart:async';

import 'package:flutter_default_state_manager/bloc_pattern/imc_state.dart';

class ImcBlocPatternController {

final _imcStreamController = StreamController<ImcState>()
  ..add(ImcState(imc: 0)); //instaciar uma StreamContrller escolhendo 
  //o tipo que é uma classe de estado e ja fazer ele inicar com um dado que é 0
Stream<ImcState> get imcOut => _imcStreamController.stream;

//ela precisa ser fechada essa conexão
void dispose(){
  _imcStreamController.close();
}
  
}