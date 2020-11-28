choose_move(GameState, Player ,'hard', Move):-
    ai(GameState,Player,OutState),
    retract(moves(OutState,Move)),
    retractall(moves(_,_)).

choose_move(GameState, Player ,'easy', Move):-
    valid_moves(GameState,Player,ListOfMoves),
    random_member(Move,ListOfMoves),
    print(Move).

ai(GameState,Player,OutGameState):-
    getStates(GameState,Player,NewGameStates),
    getMaxSons(NewGameStates,Player,-99999,GameState,OutGameState,_).
getMaxSons([GameState|Rest],Player,InValue,InGameState,OutGameState,OutValue):-
    value(GameState,Player,NValue),
    getmax(NValue,GameState,InValue,InGameState,OValue,OGameState),
    getMaxSons(Rest,Player,OValue,OGameState,OutGameState,OutValue).
getMaxSons([GameState],Player,InValue,InGameState,OutGameState,OutValue):-
    value(GameState,Player,NValue),
    getmax(NValue,GameState,InValue,InGameState,OutValue,OutGameState).
    
getmax(Value1,State1,Value2,State2,OutValue,OutState):-
    Value1 > Value2,
    OutValue = Value1,
    OutState = State1,
    !.

getmax(Value1,State1,Value2,State2,OutValue,OutState):-
    Value1 < Value2,
    OutValue = Value2,
    OutState = State2,
    !.

getmax(Value1,State1,Value1,_,Value1,State1).

getStates(GameState,Player,NewGameStates):-
    valid_moves(GameState,Player,ListOfMoves),
    ListOfMoves \= [],
    getValidMovesStates(ListOfMoves,GameState,NewGameStates).

getValidMovesStates([[Colour,X,Y]|Moves],GameState,NewGameStates):-
    ext_to_int(CP,LP,Y,X),
    move(GameState,target(Colour,X, Y, CP, LP),NewGameState),
    assert(moves(NewGameState,[Colour,X,Y])),
    getValidMovesStates(Moves,GameState,GameStates),
    NewGameStates = [NewGameState|GameStates].
getValidMovesStates([],_,[]).