# MyMovies

O MyMovies é uma aplicação iOS que permite aos usuários navegar por uma lista de filmes, acompanhar os últimos lançamentos e gerenciar uma lista personalizada de favoritos. Com recursos de pesquisa, paginação e navegação entre detalhes dos filmes.

___

📱 Funcionalidades Principais
	1.	Listagem de Filmes
	  •	Ao abrir o app, é exibida uma lista paginada de filmes (10 filmes por vez).
	  •	Cada filme exibe informações básicas, como título e status de favorito.
	  •	Os filmes favoritos têm um ícone destacado.
	2.	Detalhes do Filme
  	•	Ao clicar em um filme, o usuário acessa uma tela de detalhes.
  	•	Nesta tela, é possível favoritar ou desfavoritar o filme tanto pelo botão principal, quanto pelo ícone de favoritos.
	3.	Pesquisa
	  •	Na tela de listagem, o usuário pode pesquisar por filmes já carregados pelo nome para facilitar a navegação.
	4.	Favoritos
  	•	Um segundo item na TabBar exibe uma lista de todos os filmes marcados como favoritos.
  	•	O usuário pode remover filmes dos favoritos deslizando para o lado ou acessando a tela de detalhes.

___

🛠 Arquitetura e Implementação

Arquitetura Utilizada: VIP com Configurator, Workers e Router
	•	View: Responsável por renderizar a interface e receber eventos do usuário.
	•	Interactor: Contém a lógica de negócios da aplicação, processando dados e chamando os workers.
	•	Presenter: Formata os dados recebidos para exibição e comunica com a View.
	•	Router: Gerencia a navegação entre as cenas.
	•	Configurator: Centraliza a injeção de dependências para garantir que os módulos sejam criados com as dependências corretas.
  •	Workers: Lida com a chamada de serviçoes e de banco de dados local.

 Camada de Rede
	•	Um módulo separado, chamado NetworkKit, foi implementado para lidar com todas as requisições de rede. Neste módulo está sendo usado async await para lidar com concorrência, eliminando o uso excessivo de closures. Como foi criado em um módulo separado, pode ser integrado em outros projetos.

  UI 
	•	Todas as telas foram construídas utilizando UIKit com viewCode.

___

🌟 O Problema Resolvido

O Movies App resolve a necessidade de ter sempre à mão uma lista atualizada de filmes, incluindo os últimos lançamentos. Além disso, permite ao usuário criar uma lista de favoritos personalizada para assistir filmes posteriormente, garantindo uma experiência prática e eficiente.

___

🔧 Tecnologias Utilizadas
	•	Swift 5
	•	UIKit
	•	Arquitetura VIP
	•	NetworkKit
	•	UIKit (ViewCode)
  •	Async await
  •	SPM (Gerenciador de dependências)
  •	SwiftData
	•	Testes Unitários com Mocks

***

🚀 Melhorias Futuras

Se houvesse mais tempo, eu adicionaria:
	1.	Cache de imagens
	•	Armazenar as imagens dos filmes carregados localmente para acesso offline sem a necessidade de baixa-la novamente.
	2.	Testes de UI, Snapshot, testes unitários da viewController e teste da camada de Network
	•	Adicionar testes de interface para validar as interações dos usuários, snapshot para garantir que nao quebrou nada visual, testes unitários da viewController e testes do NetworkKit.
	3.	Filtros Avançados
	•	Opções de filtragem por gênero, data de lançamento, avaliação, etc.
  4. Pesquisa de todos os filmes
  •	Caso tenha a opção na API public de filmes, seria interessanter ter a pesquisa de todos os filmes não se limitando aos filmes carregados.
