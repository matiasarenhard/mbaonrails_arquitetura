# Avaliação MBA on Rails
## Disciplina: Arquitetura de Aplicações Web com Rails 
----------------------------------------
Aluno: Matias Arenhard <br/>
Email: m.arenhard@gmail.com

# Coin Price Tracker
Este é um projeto desenvolvido como parte do curso de Ruby on Rails. O objetivo é aplicar os conceitos aprendidos em aula. Esta simples API tem o objetivo de salvar o histórico de preços de moedas. 

## 📦 Tecnologias Utilizadas
- [Ruby](https://www.ruby-lang.org/pt/) 3.3.4
- [Ruby on Rails](https://rubyonrails.org/) 8.0.2
- [PostgreSQL](https://www.postgresql.org/) 

## 🚀 Como rodar o projeto localmente
Este projeto utiliza DevContainer. Lembre-se de instalar a extensão no VSCode, caso ainda não tenha

```bash
# Clone o repositório
git clone git@github.com:matiasarenhard/mbaonrails_arquitetura.git
cd mbaonrails_arquitetura

# Abra o VSCode
code .

# Abra um terminal dentro do VSCode e execute os comandos:
bundle install
bin/rails db:create db:migrate db:seed
bin/rails dev:cache
bin/rails s
```

## ✅ Funcionalidades implementadas
- CRUD de moedas
- Criar/Listar mudanças de preço da moeda

## 🧠 Conceitos aplicados

### 1. **Solid Process**
Aproveitei a oportunidade para utilizar a gem [solid-process](https://github.com/solid-process/solid-process) com o objetivo de experimentar uma nova abordagem para organizar a lógica de criação de um [novo histórico de alterações de moeda.](https://github.com/matiasarenhard/mbaonrails_arquitetura/blob/main/app/process/create_coin_log_process.rb)

### 2. **Solid Cache**
Estava realmente curioso sobre o [solid cache](https://github.com/rails/solid_cache), então aproveitei a oportunidade para [usar](https://github.com/matiasarenhard/mbaonrails_arquitetura/blob/main/app/queries/coin_log_query.rb#L11) e fiquei impressionado como é simples.

### 3. **Concern**
O concern [soft_deletable](https://github.com/matiasarenhard/mbaonrails_arquitetura/blob/main/app/models/concerns/soft_deletable.rb) permite ocultar registros sem removê-los fisicamente do banco de dados, preservando a consistência das informações. Ele é de fácil reutilização: basta incluí-lo no model desejado e adicionar um campo deleted_at na respectiva tabela.

### 4. **Query Object + pagy**
Esse pattern tem a intenção de centralizar uma [consulta](https://github.com/matiasarenhard/mbaonrails_arquitetura/blob/main/app/queries/coin_log_query.rb) em uma única classe, permitindo sua reutilização em diferentes partes do sistema. Para a paginação dos registros, utilizei a gem [Pagy](https://rubygems.org/gems/pagy/versions/0.6.0?locale=pt-BR).

### 5. **API namespaces**
Utilizado para versionar e separar endpoints, isso pode facilitar a migração, permitindo que versões antigas e novas funcionem simultaneamente.

----------------------------------------

### Endpoints: 
Listar todas as moedas: 
```
 curl -X GET http://localhost:3000/api/v1/coins
```
Nova moeda: 
```
  curl -X POST http://localhost:3000/api/v1/coins \
  -H "Content-Type: application/json" \
  -d '{"coin": {"name": "TestCoin", "symbol": "TSC"}}'
```
Atualizar moeda: 
```
curl -X PATCH http://localhost:3000/api/v1/coins/COIN_ID \
  -H "Content-Type: application/json" \
  -d '{"coin": {"name": "NewCoin", "symbol": "NWC"}}'
```
Detalhes de uma moeda: 
```
 curl -X GET http://localhost:3000/api/v1/coins/COIN_ID
```

Gravar atualização de preço de uma moeda: 
```
curl -X POST http://localhost:3000/api/v1/coin_logs \
  -H "Content-Type: application/json" \
  -d '{"coin_log": {"coin_id": COIN_ID, "price": 123.45}}'
```
Listar histórico de preço de uma moeda: 
```
 curl -X GET "http://localhost:3000/api/v1/coin_logs?coin_id=381801073&date_start=2025-07-01T00:00:00Z&date_end=2030-01-01T23:59:59Z"
```
Deletar moeda:
```
  curl -X DELETE http://localhost:3000/api/v1/coins/COIN_ID
```

