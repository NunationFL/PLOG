%mapeamento de coordenadas externas para internas e vice-sersa
%ext_to_int(?Coluna,?Linha,?Y,?X)
ext_to_int(1,1,0,3).
ext_to_int(1,2,0,5).
ext_to_int(1,3,0,7).
ext_to_int(1,4,0,9).

ext_to_int(2,1,0,2).
ext_to_int(2,2,0,4).
ext_to_int(2,3,0,6).
ext_to_int(2,4,0,8).
ext_to_int(2,5,0,10).

ext_to_int(3,1,0,1).
ext_to_int(3,2,1,3).
ext_to_int(3,3,1,5).
ext_to_int(3,4,1,7).
ext_to_int(3,5,1,9).
ext_to_int(3,6,0,11).

ext_to_int(4,1,0,0).
ext_to_int(4,2,1,2).
ext_to_int(4,3,1,4).
ext_to_int(4,4,1,6).
ext_to_int(4,5,1,8).
ext_to_int(4,6,1,10).
ext_to_int(4,7,0,12).

ext_to_int(5,1,1,1).
ext_to_int(5,2,2,3).
ext_to_int(5,3,2,5).
ext_to_int(5,4,2,7).
ext_to_int(5,5,2,9).
ext_to_int(5,6,1,11).

ext_to_int(6,1,2,2).
ext_to_int(6,2,2,4).
ext_to_int(6,3,2,6).
ext_to_int(6,4,2,8).
ext_to_int(6,5,2,10).

ext_to_int(7,1,3,3).
ext_to_int(7,2,3,5).
ext_to_int(7,3,3,7).
ext_to_int(7,4,3,9).

%falha se a Col e Line estiverem numa zona de Void
%verify_not_in_void(+Col,+Line)
verify_not_in_void(Col,Line):-
    Col > 1,
    Col < 7,
    Line > 1,
    Line < 7,
    (Col = 4 ; ((Col = 2; Col = 6), Line < 5 ); ((Col = 3; Col = 5), Line < 6)).

%falha se a Col e Line estiverem fora do tabuleiro(tabuleiro inclui a zona void)
%verify_in_board(+Col,+Line)
verify_in_board(Col,Line):-
    Col > 0,
    Col < 8,
    Line > 0,
    Line < 8,
    (Col = 4 ; Col = 1; Col = 7; ((Col = 2; Col = 6), Line < 6 ); ((Col = 3; Col = 5), Line < 7)).