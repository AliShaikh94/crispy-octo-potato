parent(kim,holly).
parent(margaret,kim).
parent(margaret,kent).
parent(esther,margaret).
parent(herbert,margaret).
parent(herbert,jean).
parent(mary, jean).
parent(kim, marty).
parent(kent, alphonse).
parent(herbert,wilamina).
parent(wilamina,joseph).


grandparent(GP,GC) :- parent(GP, P), parent(P,GC).

greatgrandparent1(GGP,GGC):- parent(GGP,GP), parent(GP,P), parent(P,GGC).
greatgrandparent2(GGP,GGC) :- grandparent(GGP, P), parent(P, GGC).
ancestor(X,Y) :- parent(X,Y).
ancestor(X,Y) :- parent(Z,Y), ancestor(X,Z).

sibling(X,Y) :- parent(P1,X), parent(P1,Y), not(X=Y).
cousin(X,Y) :- sibling(P1,P2), parent(P1,X), parent(P2,Y), not(X=Y), not(P1=P2).





















