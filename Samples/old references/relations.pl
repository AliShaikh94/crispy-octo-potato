parent(kim,holly).
parent(margaret,kim).
parent(margaret,kent).
parent(esther,margaret).
parent(herbert,margaret).
parent(herbert,jean).
parent(mary, jean).
parent(kim, marty).
parent(kent, alphonse).

grandparent(GP, GC):- parent(GP, P), parent(P,C).

greatgrandparent(GGP,GGC):- parent(GGP,GP), parent(GP,P), parent(P,GGC).

ancestor(X,Y) :- parent(X,Y).
ancestor(X,Y) :- parent(Z,Y), ancestor(X,Z).

sibling(X,Y):-  parent(P,X), parent(P,Y), not(X=Y).

cousin(X,Y):- sibling(P1, P2), parent(P1,X), parent(P2,Y), not(X=Y), not(P1=P2).
