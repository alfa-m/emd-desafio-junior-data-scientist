# Desafio Técnico - Cientista de Dados Júnior

## Descrição

Instruções do desafio técnico para a vaga de Cientista de Dados Júnior no campo de soluções de tecnologia e de Governo Digital para área pública no Rio de Janeiro! A **data limite** do último commit no repositório é de **01/09/2024 às 23:59 UTC-3**.

### Objetivo

O objetivo deste desafio é avaliar suas habilidades técnicas em manipulação de dados, análises exploratórias, integração com APIs, consulta SQL no Big Query, análise e visualização de dados.

### Conjunto de Dados

Os conjuntos de dados que serão utilizados neste desafio são:

- **Chamados do 1746:** Dados relacionados a chamados de serviços públicos na cidade do Rio de Janeiro. O caminho da tabela é : `datario.adm_central_atendimento_1746.chamado`
- **Bairros do Rio de Janeiro:** Dados sobre os bairros da cidade do Rio de Janeiro - RJ. O caminho da tabela é: `datario.dados_mestres.bairro`
- **Ocupação Hoteleira em Grandes Eventos no Rio**: Dados contendo o período de duração de alguns grandes eventos que ocorreram no Rio de Janeiro em 2022 e 2023 e a taxa de ocupação hoteleira da cidade nesses períodos. O caminho da tabela é: `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos`

### Ferramentas e Recursos

- Acesso ao Google Cloud Platform (GCP) para utilizar o BigQuery e consultar os dados públicos disponíveis no projeto `datario`. Além disso, será utilizada a biblioteca `basedosdados` em Python para acessar os dados do BigQuery.
- Tutorial para acessar dados no BigQuery, desde a criação da conta no GCP até consultar os dados utilizando SQL e Python: [Como acessar dados no BigQuery](https://docs.dados.rio/tutoriais/como-acessar-dados/)
- API [Public Holiday API](https://date.nager.at/Api)
- API [Open-Meteo Historical Weather API](https://open-meteo.com/)
- Todas as APIs utilizadas no desafio são públicas e possuem documentações com exemplos.

### Perguntas do Desafio

As perguntas do desafio estão detalhadas nos arquivos `perguntas_sql.md` e `perguntas_api.md`.

## Etapas

- [x] Siga o tutorial acima para criar sua conta no GCP e aprender como utilizar o BigQuery para consultar os dados.
- [x] Faça um fork desse repositório.
- [x] Utilize SQL para resolver todas as questões contidas no arquivo `perguntas_sql.md` no BigQuery. Salve suas respostas em um arquivo `analise_sql.sql`.
- [ ] Utilize Python e pandas para resolver todas as questões contidas no arquivo `perguntas_sql.md`. Salve suas respostas em um arquivo `analise_python.py` ou `analise_python.ipynb`. Para acessar os dados do BigQuery no python, siga o tutorial acima e utilize a biblioteca `basedosdados`.
- [ ] Utilize Python para resolver todas as questões contidas no arquivo `perguntas_api.md`. Salve suas respostas em um arquivo `analise_api.py` ou `analise_api.ipynb`.
- [ ] Utilize o LookerStudio, Power BI, StreamLit, Tableau ou qualquer outra ferramenta de visualização de sua preferência para criar visualizações informativas dos dados das tabelas e APIs. Suas visualizações não precisam se limitar apenas aos resultados das análises; é encorajado que você explore os dados e crie visualizações interessantes sobre eles.
- [ ] Faça commits incrementais à medida que trabalha no desafio e, finalmente, faça push do seu código para o seu repositório no GitHub. - - [ ] Seu repositório deve conter um README com todos os passos necessários para rodar seu código e ver a visualização de dados que você criou.

## Avaliação

Serão avaliados cada uma das categorias abaixo, com seus respectivos pesos:

- **SQL**: peso 1
- **Python**: peso 2
- **Visualização de Dados**: peso 1

Uma média ponderada será calculada e os melhores candidatos serão chamados para a etapa de entrevistas.

**Dica**: procure fazer algo diferente! Devido à grande quantia de candidatos, é possível que uma boa média não seja suficiente para te garantir uma entrevista. Tente se destacar!

## Dúvidas

Se tiver alguma dúvida ou precisar de esclarecimentos adicionais sobre o desafio, entre em contato pelo email escritoriodedados@gmail.com.

Boa sorte e estamos ansiosos para ver suas soluções!

---

**Escritório de Dados**  
**Prefeitura da Cidade do Rio de Janeiro**
