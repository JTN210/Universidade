-module(raid).
-export(create/1, join/3, players/1, waitStart/1, leave/1,manager/6,raid/5).

create(R) -> spawn(fun()->manager(R, 0, [], [], 0, []) end). 

join(Manager, Name, Min) -> 
    Manager ! {join, Name, Min, self()},
    receive {raid, Raid} -> Raid.


players(Raid) -> 
    Raid ! {players, self()},
    receive {names, Names } -> Names
end.

waitStart(Raid) -> 
    Raid ! {waitStart, self()},
    receive started -> ok
end.


leave(Raid) -> 
    Raid ! leave.


manager(R,Maxmin, Names, Players, Running, Pending) when Maxmin =:= length(Names)->
    Self = self(),
    Raid = spawn(fun()-> raid(Names, length(Names), false, 0, Self) end),
    [Pid !  {raid, Raid} || Pid <- Players],
    if Running < R -> 
        Raid ! start,
        manager(R, 0, [], [], Running + 1, Pending);
    true -> manager(R, 0, [], [], Running, Pending ++ [Raid])
    end;

manager(R,Maxmin, Names, Players, Running, Pending) ->
    receive 
        {join, Name, Min, From} -> 
            manager(R,max(Maxmin,Min),[Name | Names], [From | Players], Running, Pending);
        finished -> 
            case Pending of
                [Raid | Rest] ->
                    Raid ! start,
                    manager(R,Maxmin, Names, Players, Running, Rest);
                [] ->
                    manager(R,Maxmin, Names, Players, Running - 1, Pending)
            end
    end.
raid(Names, Playing, Started, Waiting, Manager) when Playing =:= 0 ->
    Manager ! finished;

raid(Names, Playing, Started, Waiting, Manager) -> 
    receive
        {players, From} -> 
            From ! {names, Names},
            raid(Names, Playing, Started, Waiting, Manager);
        {waitStart,From} ->
            case Started of
                true ->
                    From ! started,
                    raid(Names, Playing, Started, Waiting, Manager);
                false -> 
                    raid(Names, Playing, Started, [From | Waiting], Manager)
            end;
        leave ->
            raid(Names, Playing - 1, Started, Waiting, Manager);
        start -> 
            [Pid ! started || Pid <- Waiting], 
            raid(Names, Playing, true, [], Manager)
    end.