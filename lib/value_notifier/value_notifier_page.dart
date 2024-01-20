import 'dart:math';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge.dart';
import 'package:intl/intl.dart';

class ValueNotifierPage extends StatefulWidget {
  const ValueNotifierPage({ super.key });

 @override
  State<ValueNotifierPage> createState() => _ValueNotifierPageState();
}

class _ValueNotifierPageState extends State<ValueNotifierPage> {

  // preciso recuperar os valores informados nos campos de peso e altura.
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formkey = GlobalKey<FormState>();
  //! 1 - no imc será uma classe ValueNotifier deste gerenciamento de estado e dentro vai receber o valor.
  // var imc = 0.0; aantes
  var imc = ValueNotifier(0.0);

  //! aqui mudamos também porque não usamos o setstate
  //metodo que calcula o imc
  Future<void> _calcularIMC(
      {required double peso, required double altura}) async {
    //criamos outro setstate para rebildar a pagina e voltar a zero antes de aplicar o novo comando
    //!antes
    // setState(() {
    //   imc = 0;
    // });
    //! agora
    imc.value = 0;
    await Future.delayed(const Duration(seconds: 1));
    // colocamos essa função setState que é a classe que chamamos para a pagina ser rebildada.
    // setState(() {
    //   imc = peso / pow(altura, 2);
    // });
    //!agora
    imc.value = peso / pow(altura, 2);
  }

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
      appBar: AppBar(
        title: const Text('IMC SETSTATE'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey, //como usamos form precisamos realizar uma chave
          child: Padding(
            // PADDIN USADO PARA DAR ESPAÇO GERAL NA PAGINA
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                //!acrescentamos esse widged para encapsular o imcgauge
                ValueListenableBuilder<double>(
                  valueListenable:  imc, //quem ele fica escutando
                  builder: ( _, imcValue, __) {
                    return ImcGauge (imc: imcValue);
                  },
                ),
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
                        
                        _calcularIMC(peso: peso, altura: altura);
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