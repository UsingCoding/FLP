seg(1, point(1, 11), point(14, 11)).
seg(2, point(2, 4), point(13, 4)).
seg(3, point(2, 2), point(9, 2)).
seg(5, point(7, 10), point(13, 10)).

seg(4, point(3, 1), point(3, 10)).
seg(6, point(8, 0), point(8, 13)).
seg(7, point(10, 3), point(10, 12)).
seg(8, point(11, 3), point(11, 13)).
seg(9, point(12, 2), point(12, 12)).

horiz(N):-seg(N, point(_,Y), point(_,Y)).

vertical(N):-seg(N, point(X,_), point(X,_)).

cross(N, M, point(X, Y), L1, L2):-seg(M, point(X1, Y), point(X2, Y)), seg(N, point(X, Y3), point(X, Y4)),
Y4 > Y, Y3 < Y, X > X1, X < X2, L1 is Y4 - Y3, L2 is X2 - X1.

perimetr(N1, N2, N3, N4, P, S):-cross(N1, N2, point(X1, Y1), Len1, Len2),
cross(N3, N2, point(X2, Y1), Len3, Len4),
cross(N3, N4, point(X2, Y2), Len5, Len6),
cross(N1, N4, point(X1, Y2), Len7, Len8),
P is (X2 - X1) * 2 + (Y1 - Y2)  * 2,
S is (X2 - X1) * (Y1 - Y2), P > 0, S > 0.
