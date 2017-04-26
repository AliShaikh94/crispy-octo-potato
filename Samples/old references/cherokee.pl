

verbpref(ge, i).
verbsuff(s, pt).
verb(ia,walk).
verb(vsata, ride).

word(V,S):- verb(V,C),verbsuff(S,E).
nclause(P,V,S) :- verbpref(P,X), verb(V,C), verbsuff(S,E).
eclause(P,V,S) :- verbpref(X,P), verb(Y,V), verbsuff(Z,S).
 