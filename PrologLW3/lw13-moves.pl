go:-  go(state(left,left,left,left),state(right,right,right,right)).

goB:- go(state(left,left,left,left),state(left,right,right,right)).

goC:- go(state(left,left,left,right),state(right,right,right,right)).

goD:- go(state(left,left,left,left),state(right,right,right,left)).

goE:- go(state(left,left,right,left),state(right,right,right,right)).

goC2:- go(state(right,right,right,left),state(left,left,left,left)).

goD2:- go(state(right,right,right,right),state(left,left,left,right)).

goE2:- go(state(right,right,left,right),state(left,left,left,left)).


go(S,G):-
    path(S,G,[S],L3),
    nl,write('A solution is:'),nl,
    write_path(L3),
    fail.
go(_,_).

path(S,G,L,L1):-
    move(S,S1),
    not( unsafe(S1) ),
    not( member(S1,L) ),
    path( S1,G,[S1|L],L1),!.
path(G,G,T,T):-!.   /* The final state is reached  */

move(state(X,X,G,C),state(Y,Y,G,C)):-opposite(X,Y). /* FARMER + WOLF    */
move(state(X,W,X,C),state(Y,W,Y,C)):-opposite(X,Y). /* FARMER + GOAT    */
move(state(X,W,G,X),state(Y,W,G,Y)):-opposite(X,Y). /* FARMER + CABBAGE */
move(state(X,W,G,C),state(Y,W,G,C)):-opposite(X,Y). /* ONLY FARMER   */

opposite(left,right).
opposite(right,left).

unsafe( state(F,X,X,_) ):- opposite(F,X).  /* The wolf eats the goat    */
unsafe( state(F,_,X,X) ):- opposite(F,X).  /* The goat eats the cabbage */

member(X,[X|_]).
member(X,[_|L]):-member(X,L).

write_move(state(X,W,G,C), state(Y,W,G,C) ) :- !,
    write('The farmer crosses the river from '),
        write(X),
        write(' to '),
        write(Y),nl.
write_move( state(X,X,G,C), state(Y,Y,G,C) ) :-!,
    write('The farmer takes the Wolf from '),
        write(X),
        write(' of the river to '),
        write(Y),nl.
write_move( state(X,W,X,C), state(Y,W,Y,C) ) :-!,
    write('The farmer takes the Goat from ' ),
        write(X),
        write(' of the river to '),
        write(Y),nl.
write_move( state(X,W,G,X), state(Y,W,G,Y) ) :-!,
    write('The farmer takes the cabbage from '),
        write(X),
        write(' of the river to '),
        write(Y),nl.

write_path( [H1,H2|T] ) :- !,
    write_move(H1,H2),write_path([H2|T]).
    write_path( _ ).


door(a,b).
door(b,c).
door(b,e).
door(c,d).
door(d,e).
door(d,h).
door(h,f).
door(e,j).
door(j,g).
door(g,j).
door(f,e).
door(f,i).
door(i,k).
door(i,j).
door(k,l).
door(l,j).
treasure(g).
treasure(l).
path([]).

window(a, 0).
window(b, 1).
window(c, 1).
window(d, 0).
window(e, 0).
window(f, 1).
window(g, 0).
window(h, 3).
window(i, 1).
window(j, 1).
window(k, 2).
window(l, 1).



different(X, Y):-X=Y, !, fail; true.

/*5.2 Напечатать список комнат, через которые лежит путь к комнате G, выбранный Прологом. */
path2(S, E, P):- (door(S,Z);door(Z,S)), not(member(Z,P)), path2(Z,E,[Z|P]).
path2(E, E, P):- write(P), nl.

/*5.3 При входе в комнату X печатать "entering room X" */

path3(S, E, P):- (door(S,Z);door(Z,S)), not(member(Z,P)), write('entering room '), write(Z), nl, path3(Z,E,[Z|P]),!.
path3(E, E, P):- write(P).

/*5.4 посчитать и напечатать количество комнат, через которые надо пройти к G*/

path4(S, E, P, C):- (door(S,Z);door(Z,S)), not(member(Z,P)), path4(Z,E,[Z|P], C1),
C is C1 + 1, !.
path4(E, E, P, C):- write(P), C is 0.

/*5.5 Пройти к комнате L ,не входя в комнату E. */

path5(S, E, P):- (door(S,Z);door(Z,S)), not(member(Z,P)), Z \= e, path5(Z,E,[Z|P]), !.
path5(E, E, P):- write(P).

/*[l,k,i,f,h,d,c,b]*/

/*5.6 Найти и напечатать все возможные пути из комнаты А  в комнату L.*/

path6(S, E, P):- path2(S, E, P), not(path(P)), assert(path(P)), write(P), nl, path6(S, E, _).
path6(E, E, _).

/*5.7 #2  В некоторых комнатах есть окна. Например, в комнате H их целых три.  Надо посчитать количество окон в комнатах, через которые лежит путь  к комнате L.*/
path7 :- windowPath(a, l, [], Res, 0, Windows), write(Res), write(" "), write(Windows), nl, !.

windowPath(Goal, Goal, Ans, Ans, Windows, WindowsRes) :- window(Goal , WindowsInThisRoom), WindowsRes is Windows + WindowsInThisRoom.
windowPath(Start, Goal, List, Res, Windows, WindowsRes) :-
    isDoor(Start, Next),
    \+ member(Next, List),  % no backtrack
    append(List, [Next], NewList),
    window(Start , WindowsInThisRoom),
    NewWindows is Windows + WindowsInThisRoom,
    windowPath(Next, Goal, NewList, Res, NewWindows, WindowsRes)
    .
