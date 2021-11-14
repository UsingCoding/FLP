% Parents
parent(paul, jim).
parent(mary, jim).

parent(jim, bob).
parent(ann, bob).

parent(bil, ann).
parent(bil, joe).
parent(sue, ann).
parent(sue, joe).

parent(joe, tammy).

% Sex
male(paul).
male(jim).
male(bob).
male(joe).
male(bil).

female(ann).
female(mary).
female(sue).
female(tammy).

% 1.b
?- parent(X, bob), parent(Y, X), female(Y).

% 1.c
child(X, Y) :- parent(Y, X).
?- child(X, Y), child(Z, X), male(Z).

% 1.d
different(X, Y) :- X \= Y.
sister(X, Y) :- parent(Z, X), parent(Z, Y), female(X), different(X, Y).
?- sister(jim, X).

% 1.e
aunt(X, Y) :- parent(Z, Y), sister(X, Z).
?- aunt(ann,tammy).

% 1.f
equals(X, Y) :- X == Y.
cousin(X, Y) :- parent(Z, X), parent(K, Y), parent(D, Z), parent(D, K).
?- cousin(bob, tammy).


% 2.a
likes(ellen, reading).

likes(john, computers).
likes(john, badminton).
likes(john, photo).
likes(john, reading).

likes(leonard, badminton).

likes(eric, swimming).
likes(eric, reading).
likes(eric, chess).

likes(paul, swimming).

% 2.b

?- likes(X,A), likes(X,B), likes(X,C), likes(X,D), different(A,B), different(A,C), different(A,D), different(B,C), different(B,D), different(C,D),likes(X,A), likes(X,B), likes(X,C), likes(X,D), different(A,B), different(A,C), different(A,D), different(B,C), different(B,D), different(C,D).

% 2.c

?- likes(X, A), likes(Y, A), different(X, Y).
