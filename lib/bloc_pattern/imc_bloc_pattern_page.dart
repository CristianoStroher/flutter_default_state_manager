import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/bloc_pattern/imc_bloc_pattern_controller.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge.dart';
import 'package:intl/intl.dart';

class ImcBlocPatternPage extends StatefulWidget {

  const ImcBlocPatternPage({ super.key });

  @override
  State<ImcBlocPatternPage> createState() => _ImcBlocPatternPageState();
}

class _ImcBlocPatternPageState extends State<ImcBlocPatternPage> {

  // preciso recuperar os valores informados nos campos de peso e altura.
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final controller = ImcBlocPatternController(); //!instanciamos a controller na pagina do bloc
 

  // descartar os valores captados
  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    super.dispose();
    controller.dispose(); //!fechamos a controller tmb para nao perder memoria
  }

   @override
   Widget build(BuildContext context) {
       return Scaffold(
      appBar: AppBar(
        title: const Text('IMC BLOC PATTERN'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey, //como usamos form precisamos realizar uma chave
          child: Padding(
            // PADDIN USADO PARA DAR ESPAÇO GERAL NA PAGINA
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const ImcGauge(imc: 0),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: pesoEC,
                  decoration: const InputDecoration(labelText: 'Peso'),
                  keyboardType:
                      TextInputType.number, // coloca o teclado como numerico
                  inputFormatters: [
                    //formatamos os numeros desse imput usando packged baixado
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR', //qual teclado vai usar
                      symbol: '',
                      turnOffGrouping: true, //sem o ponto decimal entre os mil
                      decimalDigits: 2, //quantidade decimal
                    )
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Peso Obrigatorio';
                    }
                  },
                ),
                TextFormField(
                  controller: alturaEC,
                  decoration: const InputDecoration(labelText: 'Altura'),
                  keyboardType:
                      TextInputType.number, // coloca o teclado como numerico
                  inputFormatters: [
                    //formatamos os numeros desse imput usando packged baixado
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR', //qual teclado vai usar
                      symbol: '',
                      turnOffGrouping: true, //sem o ponto decimal entre os mil
                      decimalDigits: 2, //quantidade decimal
                    )
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Altura Obrigatoria';
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      var formValid = formkey.currentState?.validate() ?? false;

                      if (formValid) {
                        // converter e usamos o pacote intl 0.17.0
                        var formater = NumberFormat.simpleCurrency(
                          locale: 'pt_BR',
                          decimalDigits: 2,
                        );
                        double peso = formater.parse(pesoEC.text)
                            as double;
                        double altura = formater.parse(alturaEC.text)
                            as double; //como o dado vem em string precisamos
                        
                        // _calcularIMC(peso: peso, altura: altura);
                      }
                    },
                    child: const Text('Calcular IMC'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}