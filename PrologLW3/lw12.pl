% #1
member(X,[X|_]) :- !.
member(X,[_|L]) :- member(X,L).
% красное, member(1, [1,2,3,1,2,1]), вернет true; true; true; false.

% #2
fib(X, _) :- X < 1, throw("bad x"), !.
fib(1, 1) :- !.
fib(2, 1) :- !.
fib(X, N) :-  X1 is X - 1, X2 is X - 2, fib(X1, Rest1), fib(X2, Rest2), N is Rest1 + Rest2.

% #3.1
d(1, Len, Res) :- Res is Len // 2 + Len mod 2, !.
d(I, Len, Res) :- DecrementedI is I - 1, d(DecrementedI, Len, Ans), Res is Ans // 2 + Ans mod 2, !. 

take(N, _, Xs) :- N =< 0, !, N =:= 0, Xs = [].
take(_, [], []).
take(N, [X|Xs], [X|Ys]) :- M is N-1, take(M, Xs, Ys).

shell(List, Res) :- length(List, LengthOfList), shellGapIterator(List, LengthOfList, 1, Res).

shellGapIterator(List, LengthOfList, D, Res) :- 
    d(D, LengthOfList, Gap)
    , shellIterator(Gap, List, Res)
    , Gap is 1
    , !
    .
shellGapIterator(List, LengthOfList, D, Res) :- 
    d(D, LengthOfList, Gap)
    , shellIterator(Gap, List, Ans)
    , IncrementedD is D + 1
    , shellGapIterator(Ans, LengthOfList, IncrementedD, Res)
    .

shellIterator(_, [], []) :- !.
shellIterator(Gap, List, List) :- length(List, ListLength), Gap > ListLength - 1, !.
shellIterator(Gap, List, [H|Res]) :- swapInGap(Gap, List, [H|Ans]), shellIterator(Gap, Ans, Res).

swapInGap(Gap, List, Res) :- 
    take(Gap, List, [H1|Left])
    , append([H1|Left], [H2|Right], List)
    , swapIfGreater(H1, H2, HRes1, HRes2)
    , append([HRes1|Left], [HRes2|Right], Res)
    .

swapIfGreater(X1, X2, X2, X1) :- X1 > X2, !.
swapIfGreater(X1, X2, X1, X2).

% #3.2
sort_3() :-
    write('list? ')
    , read(InputList)
    , nl
    , write('answer: ')
    , shell(InputList, Res)
    , write(Res)
    .
    
% #4.1
sortn(L1, L2) :- permutation(L1, L2), sorted(L2),!.
permutation(L, [H|T]) :- append(V, [H|U], L), append(V, U, W), permutation(W, T).
permutation([], []).
sorted([_]).
sorted([X,Y|T]) :- order(X,Y), sorted([Y|T]).
order(X, Y) :- X =< Y.

sort_4_1() :-
    write('list? ')
    , read(InputList)
    , nl
    , write('answer: ')
    , sortn(InputList, Res)
    , write(Res)
    .
    
% #4.2
busort(L, S) :- swap(L, M), !, busort(M, S).
busort(L, L) :- !.
swap([X, Y|R], [Y, X|R]) :- order(Y, X).
swap([X|R], [X|R1]) :- swap(R, R1).

sort_4_2() :-
    write('list? ')
    , read(InputList)
    , nl
    , write('answer: ')
    , busort(InputList, Res)
    , write(Res)
    .
    
% #4.3
insort([], []).
insort([X|L], M) :- insort(L, N), insortx(X, N, M).
insortx(X, [A|L], [A|M]) :- order(A, X), !, insortx(X, L, M).
insortx(X, L, [X|L]).

sort_4_3() :-
    write('list? ')
    , read(InputList)
    , nl
    , write('answer: ')
    , insort(InputList, Res)
    , write(Res)
    .
    
% #4.4
qsort([], []).
qsort([H|Tail], S) :- split(H, Tail, Small, Big), qsort(Small,Small1), qsort(Big, Big1), append(Small1, [H|Big1], S).
split(H, [A|Tail], [A|Small], Big) :- order(A, H), !, split(H, Tail, Small, Big).
split(H, [A|Tail], Small, [A|Big]) :- split(H, Tail, Small, Big).
split(_, [], [], []). 

sort_4_4() :-
    write('list? ')
    , read(InputList)
    , nl
    , write('answer: ')
    , qsort(InputList, Res)
    , write(Res)
    .
    
% #4.5
common(L1, L2, Res) :- append(L1, L2, List), qsort(List, SortedList), makeUnique(SortedList, Res).

makeUnique([], []) :- !.
makeUnique([H,H|Tail], Res) :- makeUnique([H|Tail], Res), !.
makeUnique([H|Tail], [H|Res]) :- makeUnique(Tail, Res).

% #4.7
most_oft(List, Elems) :- qsort(List, SortedList), count_recur(SortedList, ['none'], 0, Elems, _).

count_recur(List, MaxElems, MaxAmount, MaxElemsRes, MaxAmountRes) :-
    append([H|Left], [H2|Rest], List),
    append(_, [H], [H|Left]),
    H \= H2,
    length([H|Left], NewAmount),
    (
        MaxAmount > NewAmount,
        append([], MaxElems, NewMaxElems),
        NewMaxAmount is MaxAmount
    ;
        MaxAmount < NewAmount,
        NewMaxElems is H,
        % append([], [H], NewMaxElems),
        NewMaxAmount is NewAmount
    ;
        MaxAmount is NewAmount,
        (
            is_list(MaxElems),
            append([H], MaxElems, NewMaxElems)
        ;
            not(is_list(MaxElems)),
            append([H], [MaxElems], NewMaxElems)
        
        ),
        NewMaxAmount is MaxAmount
    ),
    count_recur([H2|Rest], NewMaxElems, NewMaxAmount, MaxElemsRes, MaxAmountRes),
    !
    .
    
count_recur(List, MaxElems, MaxAmount, MaxElemsRes, MaxAmountRes) :-
    append([H], Left, List),
    length([H|Left], NewAmount),
    (
        MaxAmount > NewAmount,
        append([], MaxElems, MaxElemsRes),
        MaxAmountRes is MaxAmount
    ;
        MaxAmount < NewAmount,
        MaxElemsRes is H,
        % append([], [H], MaxElemsRes),
        MaxAmountRes is NewAmount
    ;
        MaxAmount is NewAmount,
        (
            is_list(MaxElems),
            append([H], MaxElems, MaxElemsRes)
        ;
            not(is_list(MaxElems)),
            append([H], [MaxElems], MaxElemsRes)
        
        ),
        MaxAmountRes is MaxAmount
    ),
    !
    .