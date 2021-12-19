% #1
member(X,[X|_]) :- !.
member(X,[_|L]) :- member(X,L).
% красное, member(1, [1,2,3,1,2,1]), вернет true; true; true; false.

% #2
fib(X, _) :- X < 1, throw("X smaller than zero"), !.
fib(X, 1) :- !.
fib(X, N) :- fib(X-1, N1), fib(X-2, N2), N is N1 + N2.

% #4.1
common_call_4(Z) :- write("list? "), read(X), nl, call(Z, X, L2), write("answer: "), write(L2).

order(X, Y) :- X =< Y.

sorted([_]).
sorted([X, Y|T]) :- order(X, Y), sorted([Y|T]).

permutation(L, [H|T]) :- append(V, [H|U], L), append(V, U, W), permutation(W, T).
permutation([], []).

sort_41(L1, L2) :- permutation(L1, L2), sorted(L2), !.

sort_4_1 :- common_call_4(sort_41).

% #4.2
swap([X, Y|R], [Y, X|R]) :- order(Y, X).
swap([X|R], [X|R1]) :- swap(R, R1).

sort_42(L, S) :- swap(L, M), !, sort_42(M, S).
sort_42(L, L) :- !.

sort_4_2 :- common_call_4(sort_42).

% #4.3
sort_43([], []).
sort_43([X|L], M) :- sort_43(L, N), insortx(X, N, M).
insortx(X, [A|L], [A|M]) :- order(A, X), !, insortx(X, L, M).
insortx(X, L, [X|L]).

sort_4_3 :- common_call_4(sort_43).

% #4.4
sort_44([], []).
sort_44([H|Tail], S) :- split(H, Tail, Small, Big),
                        sort_44(Small, Small1),
                        sort_44(Big, Big1),
                        append(Small1, [H|Big1], S).

split(H, [A|Tail], [A|Small], Big) :- order(A, H), !, split(H, Tail, Small, Big).
split(H, [A|Tail], Small, [A|Big]) :- split(H, Tail, Small, Big).
split(_, [], [], []).

sort_4_4 :- common_call_4(sort_44).

% #4.5
set_list([], []).
set_list([Head|Tail], L2) :- member(Head, Tail), !, set_list(Tail, L2).
set_list([Head|Tail], [Head|L2]) :- set_list(Tail, L2).

common(L1, L2, L3) :- append(L1, L2, Temp), set_list(Temp, Temp2), sort_44(Temp2, L3), !.
