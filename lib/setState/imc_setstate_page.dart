import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge_range.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcSetstatePage extends StatefulWidget {

  const ImcSetstatePage({ super.key });

  @override
  State<ImcSetstatePage> createState() => _ImcSetstatePageState();
}

class _ImcSetstatePageState extends State<ImcSetstatePage> {

  // preciso recuperar os valores informados nos campos de peso e altura.
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();

  // descartar os valores captados
  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    super.dispose();
  }


   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('IMC SETSTATE'),),
           body: SingleChildScrollView(
            child: Padding( // PADDIN USADO PARA DAR ESPAÇO GERAL NA PAGINA
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const ImcGauge(imc: 0),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: pesoEC,
                    decoration: const InputDecoration(labelText: 'Peso'),
                    keyboardType: TextInputType.number, // coloca o teclado como numerico
                    inputFormatters: [ //formatamos os numeros desse imput usando packged baixado
                      CurrencyTextInputFormatter(
                        locale: 'pt_BR', //qual teclado vai usar
                        symbol: '', 
                        turnOffGrouping: true, //sem o ponto decimal entre os mil
                        decimalDigits: 2, //quantidade decimal

                      )
                    ],
                  ),
                  TextFormField(
                    controller: alturaEC,
                    decoration: const InputDecoration(labelText: 'Altura'),
                    keyboardType: TextInputType.number, // coloca o teclado como numerico
                    inputFormatters: [ //formatamos os numeros desse imput usando packged baixado
                      CurrencyTextInputFormatter(
                        locale: 'pt_BR', //qual teclado vai usar
                        symbol: '', 
                        turnOffGrouping: true, //sem o ponto decimal entre os mil
                        decimalDigits: 2, //quantidade decimal

                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(onPressed: (){}, child: const Text('Calcular IMC'))
                ],

              ),),
           ),
       );
  }
}