import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/change_notifier/imc_change_notifier_page.dart';
import 'package:flutter_default_state_manager/setState/imc_setstate_page.dart';
import 'package:flutter_default_state_manager/value_notifier/value_notifier_page.dart';

class HomePage extends StatelessWidget {

  const HomePage({ super.key });

  //medodo criado que quando chamado ele abre determinada pagina.
  // ele pede dois argumentos, o Buuidcontex  context inicial e depois a pagina que deve ser direcionada,
  // e ele abrira essa pagina e atualizará a mesma com o novo contexto.
  void _goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  } //*

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Home Page'),),
           body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
             children: [
               ElevatedButton(
                onPressed: () => _goToPage(context, const ImcSetstatePage()),
                child: const Text('SetState')),
                 ElevatedButton(
                onPressed: () => _goToPage(context, const ValueNotifierPage()),
                child: const Text('ValueNotifier')
                ),
                 ElevatedButton(
                onPressed: () => _goToPage(context, const ImcChangeNotifierPage()),
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

/* comentarios:

* void _goToPage(BuildContext context, Widget page): Esta é uma função chamada _goToPage que recebe dois parâmetros. O primeiro é um BuildContext chamado context, que é utilizado para obter informações sobre a árvore de widgets e realizar navegação entre páginas. O segundo é um Widget chamado page, que representa a página para a qual você deseja navegar.

Navigator.of(context): Navigator é uma classe no Flutter que gerencia a pilha de
navegação. O método of é usado para obter o Navigator associado ao contexto fornecido.

.push(MaterialPageRoute(builder: (context) => page)): Este é o método crucial que
realiza a navegação para a nova página. Aqui está o que acontece em cada parte:

.push: Este método adiciona uma nova rota à pilha de navegação. Ele empurra a nova
página para a frente da pilha, tornando-a a página ativa.
MaterialPageRoute: Este é um tipo específico de rota que representa uma página comum
em um aplicativo Material Design. Ele aceita um construtor de página chamado builder.
builder: (context) => page: Este é um callback que constrói a página que será exibida.
O contexto (context) é passado para este callback, e você pode usá-lo para obter
informações sobre a árvore de widgets. Neste caso, a página a ser construída é a que
foi passada como parâmetro para a função _goToPage.
Portanto, quando você chama _goToPage(context, page), você está instruindo o aplicativo
a empurrar a nova página (page) para a frente na pilha de navegação, fazendo com que
ela se torne a página ativa. Isso resulta na transição para a nova página na interface
do usuário.

** quando usar um ou outro
Use a navegação direta quando você tem um aplicativo menor, com uma estrutura de navegação
simples e não precisa de recursos avançados de roteamento.
Use a navegação por rota quando você tem um aplicativo maior, com uma estrutura de
navegação complexa e precisa de um controle mais detalhado sobre a navegação, como a
definição de rotas nomeadas e transições personalizadas.

*/