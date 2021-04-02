# Declaração de Escopo - PROJETO


**Gerentes de Projeto:**

* Arthur Gramiscelli Branco, arthurgbranco@gmail.com
* Arthur Henrique Souza Braga, arthebraga@gmail.com
* Isabella Carine Cruz Nicácio, iccnicacio@gmail.com
* Lucas Alves Gusmão, lalvesgusmao@gmail.com
* Samuel Alves de Castro Baker, sacbaker@gmail.com

---

**Professores:**

* Hugo Bastos de Paula
* Pedro Alves de Oliveira

---

_Curso de Engenharia de Software, Unidade Praça da Liberdade_

_Instituto de Informática e Ciências Exatas – Pontifícia Universidade de Minas Gerais (PUC MINAS), Belo Horizonte – MG – Brasil_

---


## Descrição do Escopo


## Requisitos (do produto e/ou do projeto) |

<a name="requisitos"></a>
# 1. Requisitos

## 1.1. Requisitos Funcionais

| **ID** | **Descrição** | **Prioridade** |
| --- | --- | --- |
| RF01 | Cadastro de usuário | alta
| RF02 | Login de usuário | alta
| RF03 | Usuário adicionar ou remover tags de seus interesses | alto
| RF04 | Usuário entrar em chat com pessoa aleatória com base em interesses | alto
| RF05 | Gerenciar tags | alta
| RF06 | Gerenciar categorias | alta
| RF07 | Usuário entrar em chat com pessoa com base em uma tag específica | médio
| RF08 | Usuário entrar em chamada de vídeo com pessoa | médio
| RF09 | Remover usuários da plataforma (administrador) | baixa
| RF10 | Usuário sugerir tag para administrador | baixa


## 1.2. Requisitos Não-Funcionais

| **ID** | **Descrição** |
| --- | --- |
| RNF001 | O sistema deve providenciar comunicação em tempo real |
| RNF002 | A aplicação web deve ter uma interface responsiva |
| RNF003 | As aplicações devem ter um visual em conformidade com o Material Design |
| RNF004 | A autenticação deve utilizar o protocolo OAuth 2 |
| RNF005 | Os dados devem ser persistidos em um banco de dados relacional |
| RNF006 | O sistema deve possuir uma interface de administrador com as rotas protegidas |

## Entregáveis
1. Diagrama BPMN;
2. Diagrama de Classes;
3. Business Model Canvas;
4. Diagrama de Componentes;
5. Documento de Arquitetura;
6. Diagrama de casos de uso;
7. Declaração de escopo;
8. Estrutura Analítica de Projeto (EAP);
9. Modelo do Banco de Dados;
10. Front-end da aplicação WEB;
11. Aplicativo Móvel;
12. API Rest de Gerenciamento dos Usuários;
13. Serviço de fila (PubSub);
14. Microserviço WebRTC para relacionar os usuários e estabelecer a comunicação entre eles.

## Limites

Não será desenvolvido um protocolo de comunicação nem uma biblioteca de UI ou de componentes. Serão utilizados o protocolo WebRTC, a biblioteca Svelte e Svelte Material UI para suprir estas necessidades.
## Restrições

Para o desenvolvimento das duas aplicações, web e móvel, serão utilizadas tecnologias de ponta de desenvolvimento de software, focadas em escalabilidade, experiência de usuário e performance.

No desenvolvimento móvel será utilizado o framework Flutter, por permitir o desenvolviemnto de aplicações multiplataforma com uma boa experiência de usuário. Já na web, será utilizado o framework Svelte, utilizado para o desenvolvimento de interfaces web rápidas e leves em comparação com suas alternativas, como o React e Vue.

Já no back-end, será utilizada uma arquitetura de microsserviços distribuídos. Haverão 2 microsserviços com objetivos distintos:

1. Permanência e manipulação de dados, fila de mensagens, match de usuários (Python, Flask)
2. Comunicação entre usuários (NodeJS, Typescript, Express, Socket.io)

O SGBD utilizado para a persistência de dados será o PostgreSQL.

## Premissas

1. O projeto será realizado do dia 25 de fevereiro de 2021 até 10 de junho de 2021.
2. O projeto seguirá a metodologia scrum e terá suas tarefas dividas em 6 sprints que possuem entre 2 e 3 semanas de duração

## Marcos agendados

| Nome do Marco | Entregáveis Previstos |
| --- | --- |
| Sprint 1 | Definição da ideia do projeto |
| Sprint 2 | Documentos 1 até 7 (Seção 1 e 2 Documento de Arquitetura) |
| Sprint 3 | Seção 3 Documento de Arquitetura, API Rest de Gerenciamento dos Usuários, Protótipos de UI, Telas de login e cadastro |
| Sprint 4 | Telas de gerenciamento de perfil e de tags, API de comunicação WebRTC |
| Sprint 5 | Telas de chat, integração com API de comunicação WebRTC |
| Sprint 6 | Documento de Arquitetura de Software (versão final, completa e atualizada), código finalizado, Avaliação da Arquitetura, Relatório de encerramento do projeto, Vídeo de apresentação do projeto (pitch), Autoavaliação e avaliação por pares |
