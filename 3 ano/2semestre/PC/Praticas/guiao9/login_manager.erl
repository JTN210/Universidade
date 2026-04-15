-module(login_manager).
-export([create_account/2, close_account/2, login/2, logout/1, online/0]).
% funções de interface
%%% Username == {Password, login}           login = True/False
start() -> 
    Pid = spawn(fun() -> loop(#{}) end),
    register(?MODULE, Pid).

requests(Request) ->
    ?MODULE ! {Request,self()},
    receive {?MODULE, Res} -> Res end.

create_account(Username, Passwd) -> requests({create_account,Username, Passwd}).
  
close_account(Username, Passwd) -> requests({close_account,Username, Passwd}).

login(Username, Passwd) -> requests({login,Username, Passwd}).

logout(Username) -> requests({logout,Username}).

online() -> requests(online).

% processo de server
%loop(state) é o codigo generico de como podiamos fazer o loop ja que a maior parte é igual 
% loop(State) -> 
%     receive
%       {Request,From} ->
%         {Res, NextState} = handle(Request, State),
%         From ! {?MODULE, Res}, 
%         loop(NextState)
%     end;

% handle({create_account,Username, Passwd}, Map) -> 
%             case maps:find(Username, Map) of 
%                 error ->  
%                     loop(maps:put(Username, {Passwd, true}, Map));
%                 {ok,_} -> 
%                     {user_exists,Map}
%             end;
% handle({close_account,Username, Passwd}, Map) -> 
%             case maps:find(Username, Map) of 
%                 {ok,{Passwd,_}} ->
%                     loop(maps:remove(Username, Map));
%                 _ ->
%                 {invalid,Map}
%             end;
% handle({login,Username, Passwd}, Map) -> 
%             case maps:find(Username, Map) of 
%                 {ok,{Passwd,_}} ->
%                     loop(maps:update(Username,{Passwd,true}, Map));
%                 _ ->
%                 {invalid,Map}
%             end;
% handle({logout,Username, Passwd}, Map) -> 
%             case maps:find(Username, Map) of 
%                 {ok,{Passwd,_}} ->
%                     loop(maps:update(Username,{Passwd,false}, Map));
%                 _ ->
%                 {invalid,Map}
%             end;



loop(Map) -> 
    receive 
        {{create_account,Username, Passwd}, From} ->
            case maps:find(Username, Map) of 
                error -> 
                    From ! {?MODULE, ok}, 
                    loop(maps:put(Username, {Passwd, true}, Map));
                {ok,_} -> 
                    From ! {?MODULE, user_exists},
                    loop(Map)
            end;

        {{close_account,Username, Passwd}, From} ->
            case maps:find(Username, Map) of
                {ok,{Passwd,_}} ->
                    From ! {?MODULE, ok},
                    loop(maps:remove(Username, Map));
                _ ->
                From ! {?MODULE, invalid},
                loop(Map)
            end;
        
        {{login,Username, Passwd}, From} ->
            case maps:find(Username, Map) of 
                {ok,{Passwd,_}} -> 
                    From ! {?MODULE, ok},
                    loop(maps:put(Username,{Passwd, true}, Map));
                _ -> 
                    From ! {?MODULE, invalid},
                    loop(Map)
            end;
        {{logout,Username, Passwd}, From} ->
            case maps:find(Username, Map) of 
                {ok,{Passwd,_}} -> 
                    From ! {?MODULE, ok},
                    loop(maps:put(Username,{Passwd, false}, Map));
                _ -> 
                    From ! {?MODULE, ok},
                    loop(Map)
            end
       %% {{online},From} ->  temos de ver quem no login == true
    end.