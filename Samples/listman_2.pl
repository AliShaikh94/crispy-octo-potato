:- use_module(library(lists)).

del_head([]):-.
del_head([Hd|Tl]) :-  delete([Hd|Tl],Hd,T2), delhead([T2]).

show_list([]).
show_list([H|T]):-
        write(H),write(' '),
    show_list(T).
	
size([]):- write('size: 0').
size([H|T]):-length([H|T],X), write('size: '), write(X), write('\n').

run:-
 
write('List A\n'),
A=[1,2,-5,3],
show_list(A),
size(A),write('\n'),

delete(A,-5,B),
write('List B\n'),
show_list(B),
size(B),write('\n'),

write('List C\n'),
C=[4,5],
show_list(C),
size(C),write('\n'),

append(B,C,Result),
write('after appending C to B\n'),
write('List B\n'),
show_list(B),write('\n'),

write('List C\n'),
show_list(C),write('\n'),

write('Result:\n'),
show_list(Result),
size(Result).