unique([]):-!.
unique([H|T]):-
member(H,T),!,fail;  % fail operator - used to stop searching and execute another branch of searching
unique(T).

man("Morozov").
man("Vasilev").
man("Tokarev").

lesson("Biology").
lesson("French").
lesson("English").
lesson("History").
lesson("Mathemathic").
lesson("Geography").

teacher(S,L1,L2).
solve(Solve):-
Solve = [teacher(X,XL1,XL2),teacher(Y,YL1,YL2),teacher(Z,ZL1,ZL2)],

man(X), man(Y), man(Z), not(X=Y),not(Y=Z),not(X=Z),
lesson(XL1),lesson(XL2),
lesson(YL1),lesson(YL2),
lesson(ZL1),lesson(ZL2),
unique([XL1,XL2,YL1,YL2,ZL1,ZL2]),
not(member(teacher(_,"Geography","French"),Solve)),
not(member(teacher(_,"French","Geography"),Solve)),
not(member(teacher("Tokarev","Biology";_,"French";_),Solve)),
not(member(teacher("Tokarev","French";_,"Biology";_),Solve)),
not(member(teacher(_,"Biology","French"),Solve)),
not(member(teacher(_,"French","Biology"),Solve)),
not(member(teacher("Morozov","Biology",_),Solve)),
not(member(teacher("Morozov",_,"Biology"),Solve)),
not(member(teacher(_,"Biology","Mathemathic"),Solve)),
not(member(teacher(_,"Mathemathic","Biology"),Solve)),
not(member(teacher(_,"English","Mathemathic"),Solve)),
not(member(teacher(_,"Mathemathic","English"),Solve)),
not(member(teacher("Morozov",_,"English"),Solve)),
not(member(teacher("Morozov","English",_),Solve)),
not(member(teacher("Morozov",_,"Mathemathic"),Solve)),
not(member(teacher("Morozov","Mathemathic",_),Solve)).

?-solve(X),write(X).
