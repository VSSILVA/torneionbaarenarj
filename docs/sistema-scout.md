# Sistema de scout do Torneio NBA Arena RJ

Documento relacionado: [Reformulação do site](reformulacao-site.md).

## Objetivo

Criar um sistema simples e rapido para uma unica pessoa operar a mesa, acompanhar o jogo e registrar estatisticas ao vivo. Os dados devem alimentar automaticamente o site do torneio com placar, estatisticas, destaques e MVP da partida.

## Tela principal da mesa

- Placar fixo no topo, com nomes e logos dos dois times.
- Periodo, cronometro e status da partida visiveis junto ao placar.
- Seletor do time que recebera a proxima acao.
- Jogadores em quadra exibidos em cards grandes e faceis de tocar.
- Banco de reservas separado dos jogadores em quadra.
- Ao selecionar um jogador, mostrar botoes para:
  - Arremesso de 2 pontos errado.
  - Arremesso de 3 pontos errado.
  - Cesta de 2 pontos.
  - Cesta de 3 pontos.
  - Assistencia.
  - Toco.
  - Rebote ofensivo.
  - Rebote defensivo.
  - Roubo de bola.
  - Turnover.
- Botao de desfazer sempre visivel para corrigir rapidamente a ultima acao.

## Substituicoes

- Sidebar com duas areas: `Em quadra` e `Banco`.
- Arrastar um jogador do banco sobre um jogador em quadra realiza a substituicao automaticamente.
- Registrar na timeline quem entrou, quem saiu e o momento da troca.
- Oferecer tambem uma alternativa por toque: selecionar quem entra e depois quem sai. Isso evita depender apenas do drag and drop em telas pequenas.
- Usar as substituicoes e o cronometro para calcular o tempo em quadra de cada jogador.

## Timeline e regras das acoes

A timeline sera a fonte principal dos dados da partida. Cada acao deve guardar:

- Partida, time e jogador.
- Tipo da acao.
- Periodo e tempo do jogo.
- Momento real do registro.
- Identificador unico para permitir edicao, exclusao e sincronizacao sem duplicidade.

O placar e as estatisticas serao calculados a partir da timeline. Editar ou desfazer uma acao deve recalcular tudo automaticamente.

Para manter a operacao rapida, uma cesta pode abrir uma pergunta opcional: `Quem deu a assistencia?`. O mesario pode escolher um companheiro ou fechar sem registrar assistencia.

## Estatisticas geradas

Por jogador:

- Pontos.
- Cestas e tentativas de 2 pontos.
- Cestas e tentativas de 3 pontos.
- Aproveitamento de 2, 3 e geral.
- Assistencias.
- Rebotes ofensivos, defensivos e totais.
- Roubos de bola.
- Tocos.
- Turnovers.
- Tempo em quadra.

Por equipe:

- Placar e aproveitamentos.
- Rebotes, assistencias, roubos, tocos e turnovers.
- Lideres da partida em cada categoria.

## MVP da partida

Primeira proposta: o MVP sera o jogador com maior `Impact Score` entre os atletas do time vencedor.

```text
Impact Score =
  pontos
  + (assistencias x 1,5)
  + (rebotes ofensivos x 1,5)
  + (rebotes defensivos x 1,0)
  + (roubos x 2,0)
  + (tocos x 2,0)
  - (arremessos errados x 0,8)
  - (turnovers x 2,0)
```

Essa formula premia producao completa. Por exemplo, 10 pontos, 10 assistencias e 5 rebotes podem valer mais que 20 pontos com pouca participacao nas demais categorias. Os pesos devem ser testados com partidas reais antes de serem definitivos.

Desempates sugeridos: maior Impact Score por minuto, depois mais assistencias e, por ultimo, mais rebotes.

## Integracao com o site

- O sistema de mesa envia as acoes para uma API.
- O site recebe atualizacoes do placar e das estatisticas em tempo real.
- A pagina da partida mostra timeline, box score, lideres e MVP.
- As paginas dos times e jogadores acumulam os dados do torneio.
- Encerrar a partida congela o resultado, mas um administrador ainda pode corrigir a timeline e republicar os calculos.

## Confiabilidade

- Salvamento automatico apos cada acao.
- Operacao offline no dispositivo da mesa, com sincronizacao quando a conexao voltar.
- Indicador claro de `salvo`, `sincronizando` ou `offline`.
- Confirmacao antes de encerrar a partida.
- Historico de correcoes para saber o que foi alterado.
- Interface otimizada primeiro para tablet e notebook, com botoes grandes e poucos passos.

## Ordem de implementacao

1. Prototipo local da interface de mesa com dois times e dados simulados.
2. Timeline, placar, estatisticas, desfazer e substituicoes.
3. Persistencia local e funcionamento offline.
4. API, autenticacao simples do mesario e sincronizacao.
5. Integracao ao vivo com o site.
6. Box score, destaques, rankings e MVP automatico.

## Decisoes para a proxima conversa

- Dispositivo principal da mesa: tablet, notebook ou celular.
- Regras do cronometro e quantidade de periodos do proximo torneio.
- Se o cronometro sera controlado dentro do sistema ou apenas informado manualmente.
- Quem podera criar partidas, editar elencos e corrigir a timeline.
- Se o MVP ficara sempre restrito ao time vencedor ou se uma atuacao excepcional do perdedor podera concorrer.
- Onde o backend e o banco de dados serao hospedados.
