/*size of a list */


size([],0).
size([H|T],N) :- size(T,N1), N is N1+1.


addto(A,[],L)   :- L = [A].
addto(A,[H|T],L) :- L = .(A,[H|T]).


show([]):- [], nl.
show([X]) :-    write(X), !.
show([H|T]) :-  write(H), show([T]), nl.


/*
append(X,[],Y):- Y=[X].
append(Z,[H|T], L):-  T2=.(Z,T), L = [H|T2].
*/




addtolist(B|T):-
append([a],[],L),
append([b],L,R),
append([c],R,B),
write('showing B'), show([B]), nl.



/*use with addtolist(B|[]).*/


listsplit([H|T], H, T).

addtolist(0, B):- !.

addtolist(X, C):-

/*listsplit(B,H,T),
write('X:'),write(X), write('  H:'), write(H), nl,*/


write('next value '), 

read(Y), 
nl,

append([Y],C,B), 

write('showing B'), 
show([B|T]), 
nl, 

Z is X-1,

addtolist(Z,B).



genlist(X):-
Z is X-1,

T=[],

write('first entry? '), 

read(Y), 
nl,

append([Y],T, B),

write('in genlist'), 
nl,

show([B|T]), 
nl,

addtolist(Z,B).




