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

addtolist([]):-
write('adding '), 
write(a), 
nl,

Q=[a],

append(Q,[],L),


write('showing L'), 
show([L]), 
nl,

write('adding '), 
write(b), 
nl,

append([b],L,R),

write('showing R'), 
show([R]), 
nl,

write(c),
nl,

append([c],R,S),

write('showing S'), 
show([S]), 
nl.

 