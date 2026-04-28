-module(ex1).
-export([create/0, participa/1, adivinha/2]).

create() -> 
    spawn(fun() -> jogo([]) end).


participa(Jogo) -> 
    Jogo ! {participa, self()},
    receive {partida, Partida} -> Partida end.

adivinha(Partida, N) -> 
    Partida ! {adivinha, N, self()},
    receive {result, Res} -> Res end.

jogo(Jogadores) when length(Jogadores) =:= 4 -> 
    Partida = spawn(fun() -> init_partida() end),
    [Jogador ! {partida, Partida} || Jogador <- Jogadores],
    jogo([]);
jogo(Jogadores) ->
    receive
      {participa, Jogador} -> jogo([Jogador | Jogadores])
    end.

init_partida() -> 
    Self = self(),
    spawn(fun() -> receive after 60000 -> Self ! timeout end end),
    Numero = rand:uniform(100),
    partida(Numero,false, false , 0).

partida(Numero, Timeout, Ganhou, Tentativas) -> 
    receive
    { adivinha, N, Jogador} ->
       Res =
        if
            Ganhou -> "PERDEU";
            Timeout -> "TEMPO";
            Tentativas  >= 100 -> "TENTATIVAS";
            Numero < N -> "MENOR";
            Numero > N -> "MAIOR";
            Numero =:= N -> "GANHOU"
        end,
        Jogador ! {result, Res},
        partida(Numero, Timeout, Ganhou orelse Numero =:= N, Tentativas + 1);
    timeout -> partida(Numero, true, Ganhou, Tentativas)
    end.

    