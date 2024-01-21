import 'dart:math';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/change_notifier/imc_change_notifier_controler.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge.dart';
import 'package:intl/intl.dart';

class ImcChangeNotifierPage extends StatefulWidget {

  const ImcChangeNotifierPage({ super.key });

  @override
  State<ImcChangeNotifierPage> createState() => _ImcChangeNotifierPageState();
}

class _ImcChangeNotifierPageState extends State<ImcChangeNotifierPage> {

  //! isntaciamos a classe controler para buscar seus metodos
  final controler = ImcChangeNotifierControler();
  
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formkey = GlobalKey<FormState>();
  //! retiramos essa variável e colocamos na classe criada var imc = 0.0;

  // descartar os valores captados
  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    super.dispose();
  }
  
  //!1 - Removemos o calculo do imc
   @override
   Widget build(BuildContext context) {
       return Scaffold(
      appBar: AppBar(
        title: const Text('IMC CHANGE NOTIFIER'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey, //como usamos form precisamos realizar uma chave
          child: Padding(
            // PADDIN USADO PARA DAR ESPAÇO GERAL NA PAGINA
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                ImcGauge(imc: controler.imc),
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
                        
                        //!Alteramos aqui adiconando a classe do metodos
                        // _calcularIMC(peso: peso, altura: altura);
                        controler.calcularIMC(peso: peso, altura: altura);

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