:- use_module(library(lists)).
:- consult('display.pl').
:- consult('end.pl').
:- consult('moves.pl').
:- consult('board_map.pl').
:- consult('AI.pl').
%devolve o Board inicial
%board(-Board)
board([
            [' '],  
          [' ',' '],
        [' ',' ',' '],
      [' ',' ',' ',' '],
        [' ',' ',' '],
      [' ',' ',' ',' '],
        [' ',' ',' '],
      [' ',' ',' ',' '],
        [' ',' ',' '],
      [' ',' ',' ',' '],
        [' ',' ',' '],
          [' ',' '],
            [' '] 
]).
%unused_pieces(-UnusedPieces)
unused_pieces([10,5,5,10]).
%out_pieces(-OutPieces)
out_pieces([0,0,0,0]).
%player(-Player)
player(0).

%inicia o jogo e o estado de jogo mostrando depois o tabuleiro
play :-
	initial(GameState),
	get_player(GameState,Player),
	display_game(GameState,Player),
  format("~n~n",[]),
  loop(GameState).

loop(GameState,Winner) :-
  Winner = -1,
  format("Which piece to Use(r or b): ",[]),
  read(Read),
  (Read = 'r';Read = 'b'),
  format("Which Column to put It: ",[]),
  read(Column1),
  format("Which Line to put It: ",[]),
  read(Line1),
  verifyNotInVoid(Column1, Line1),
  ext_to_int(Column1, Line1, Line, Column),
  %format("~p ~p~n",[Line,Column]),
  Target =.. [target,Read,Column,Line,Column1,Line1],
  move(GameState,Target,NewGameState),
	get_player(NewGameState,Player),
  valid_moves(NewGameState,Player,ListOfMoves),
  format("~p~n",[ListOfMoves]),
  calcPoints(GameState,[P1,P2]),
  print([P1,P2]),
  minimax(GameState, BestPos, Val, NodesList,4),
  print('\n'),
  print([BestPos,Val,NodesList]),
  print('\n'),
  display_game(NewGameState,Player),
  game_over(NewGameState,Winner1),
  !,
  loop(NewGameState,Winner1).

loop(GameState,Winner) :-
  Winner = -1,
  game_over(GameState,Winner),
  format("Invalid Input~n",[]),
  !,
  loop(GameState,Winner).



loop(_,Winner) :-
  format("Winner: ~p~n",[Winner]).
loop(GameState) :-
  loop(GameState,-1).

%inicializar o GameState com uma lista de listas com informação do estado de jogo inicial
%initial(-GameState)
initial(GameState) :-
	board(Board),
	unused_pieces(UnusedPiecesL),
	out_pieces(OutPiecesL),
	player(Player),
  UnusedPieces =.. [unusedPieces|UnusedPiecesL],
  OutPieces =.. [outPieces|OutPiecesL],
	GameState =.. [gameState,Board,UnusedPieces,OutPieces,Player].
	
%percorre a lista gameState e devolve o player
%get_player(+GameState,-Player)
get_player(gameState(_,_,_,Player),Player).

%devolve verdade se o parâmetro for par
even(X) :- 0 is mod(X, 2).
%devolve verdade se o parâmetro for ímpar
odd(X) :- 1 is mod(X, 2).
    
