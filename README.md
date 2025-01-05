# MyMovies

O **MyMovies** é uma aplicação iOS que permite aos usuários navegar por uma lista de filmes, acompanhar os últimos lançamentos e gerenciar uma lista personalizada de favoritos. Com recursos de pesquisa, paginação e navegação entre os detalhes dos filmes.

![App Demo](https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExZnBjeXkxM2hwcm5qbDA3ZDJtdjVyZTJ5OHBrZXZqcWV0Z2M2ZDloMiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/8tPZOxniIFv0Tz5nUb/giphy.gif)


## 📱 Funcionalidades Principais

1. **Listagem de Filmes**
   - Ao abrir o app, é exibida uma lista paginada de filmes (10 filmes por vez).
   - Cada filme exibe informações básicas, como título e status de favorito.
   - Os filmes favoritos têm um ícone destacado.

2. **Detalhes do Filme**
   - Ao clicar em um filme, o usuário acessa uma tela de detalhes.
   - Nesta tela, é possível favoritar ou desfavoritar o filme tanto pelo botão principal quanto pelo ícone de favoritos, ele será salvo em um banco de dados local e sempre estará disponível no seu dispositivo.

3. **Pesquisa**
   - Na tela de listagem, o usuário pode pesquisar por filmes já carregados pelo nome para facilitar a navegação.

4. **Favoritos**
   - Um segundo item na TabBar exibe uma lista de todos os filmes marcados como favoritos.
   - O usuário pode remover filmes dos favoritos deslizando para o lado ou acessando a tela de detalhes.


## 🛠 Arquitetura e Implementação

### **Arquitetura Utilizada**: VIP com Configurator, Workers e Router

- **View**: Responsável por renderizar a interface e receber eventos do usuário.
- **Interactor**: Contém a lógica de negócios da aplicação, processando dados e chamando os workers.
- **Presenter**: Formata os dados recebidos para exibição e comunica com a View.
- **Router**: Gerencia a navegação entre as cenas.
- **Configurator**: Centraliza a injeção de dependências para garantir que os módulos sejam criados com as dependências corretas.
- **Workers**: Lida com chamadas de serviços e do banco de dados local.

### **Camada de Rede**
- Um módulo separado, chamado **NetworkKit**, foi implementado para lidar com todas as requisições de rede.
- Utiliza **async/await** para lidar com concorrência, eliminando o uso excessivo de closures.
- Por ter sido criado em um módulo separado, pode ser integrado a outros projetos.

### **UI**
- Todas as telas foram construídas utilizando **UIKit** com **ViewCode**.


## 🌟 O Problema Resolvido

O **MyMovies** resolve a necessidade de ter sempre à mão uma lista atualizada de filmes, incluindo os últimos lançamentos. Além disso, permite ao usuário criar uma lista de favoritos personalizada para assistir filmes posteriormente, garantindo uma experiência prática e eficiente.

## 🔧 Tecnologias Utilizadas

- **Swift 5**
- **UIKit** (ViewCode)
- **Arquitetura VIP**
- **NetworkKit**
- **Async/Await**
- **SPM** (Gerenciador de Dependências)
- **SwiftData**
- **Testes Unitários com Mocks**


## 🚀 Melhorias Futuras

Se houvesse mais tempo, seriam implementadas as seguintes melhorias:

1. **Cache de Imagens**
   - Armazenar as imagens dos filmes carregados localmente para acesso offline, sem a necessidade de baixá-las novamente.

2. **Testes de UI, Snapshot, e Mais Testes Unitários**
   - Adicionar testes de interface para validar as interações dos usuários.
   - Testes de snapshot para garantir que não houve quebras visuais.
   - Testes unitários da `viewController` e testes mais robustos para a camada de rede.

3. **Filtros Avançados**
   - Opções de filtragem por gênero, data de lançamento, avaliação, etc.

4. **Pesquisa Global**
   - Permitir a pesquisa de todos os filmes disponíveis na API pública, não se limitando apenas aos filmes carregados.

Siga os passos abaixo para rodar o **MyMovies** no seu ambiente local:

1. **Clone o repositório**:
   ```bash
   git clone https://github.com/rodrigofran/MyMovies.git
   cd MyMovies
   cd MyMovies
   
2. **Abra o projeto no Xcode**:
   - Certifique-se de estar usando Xcode 14 ou superior.
   - Certifique-se de que o simulador ou dispositivo físico esteja configurado para iOS 15 ou superior.
OBS: Você também pode abrir o projeto pelo terminal. Após dar o cd MyMovies pela segunda vez digite o seguinte comando no terminal:
   ```bash
   xed .
  
3. **Execute o projeto**:
   - No Xcode, selecione um simulador e clique em Run (⌘ + R)
