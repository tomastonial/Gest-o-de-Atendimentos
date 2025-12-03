# Atendimento Flutter

Este é um aplicativo Flutter para gerenciar atendimentos. Ele permite criar, editar, listar, excluir e ativar/desativar atendimentos. Cada atendimento pode ter um nome, descrição, preço, data e foto.

## Objetivo

O objetivo do projeto é fornecer uma maneira simples de gerenciar atendimentos em um sistema local (sem necessidade de internet). Ele usa **SQLite** para armazenar os dados localmente e fornece uma interface gráfica simples para interação.

## Funcionalidades

- **Listar Atendimentos**: Exibe todos os atendimentos cadastrados.
- **Cadastrar Atendimento**: Adiciona um novo atendimento com nome, descrição, preço, data e foto.
- **Editar Atendimento**: Permite editar os dados de um atendimento existente.
- **Excluir Atendimento**: Exclui um atendimento da lista.
- **Ativar/Desativar Atendimento**: Marca um atendimento como ativo ou inativo.
- **Filtrar Atendimentos**: Exibe apenas os atendimentos ativos ou inativos.

## Tecnologias

- **Flutter**: Framework para desenvolvimento do app.
- **Sqflite**: Banco de dados local (SQLite) para armazenar os atendimentos.
- **Flutter_bloc**: Gerenciamento de estado do aplicativo.
- **Image_picker**: Biblioteca para selecionar ou tirar fotos.
- **Get_it / Injectable**: Injeção de dependências.