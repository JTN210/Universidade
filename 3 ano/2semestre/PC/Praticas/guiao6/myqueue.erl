-module(myqueue).
-export([create/0, enqueue/2, dequeue/1, test/0]).

% feito como lista que insere no fim
create() -> [].

enqueue(Queue, Item) -> Queue ++ [Item].

dequeue([]) -> empty; 
dequeue([H | T]) -> {T,H}.
 
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
