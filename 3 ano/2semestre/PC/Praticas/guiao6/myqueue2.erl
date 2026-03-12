-module(myqueue2).
-export([create/0, enqueue/2, dequeue/1, test/0, invert/1, invert/2]).

% feito com 2 listas de forma eficiente
create() -> {[],[]}.

invert(L)-> invert(L,[]).
invert([],A) -> A;
invert([H|T],A) -> invert([T],[H,A]).

enqueue({[In,Out]}, Item) -> {[Item |In],Out}.

dequeue({[],[]}) -> empty; 
dequeue({In,[]}) -> dequeue({[],invert(In)});
dequeue({In, [H | T]}) -> {{In, T}, H}.
test() ->
    Q = create(),
    Q1 = enqueue(Q,1),
    Q2 = enqueue(Q1,2),
    Q3 = enqueue(Q2,3),
    Q4 = enqueue(Q3,4),
    Q5 = enqueue(Q4,5),
    empty = dequeue(Q),
    {Q6, 1} = dequeue(Q1),
    empty = dequeue(Q6),
    {Q7, 1} = dequeue(Q5),
    {Q8, 2} = dequeue(Q7),
    {_, 3} = dequeue(Q8),
    ok.
