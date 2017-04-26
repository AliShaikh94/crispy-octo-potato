
showList([]) :- write('\n\n'), !.
showList([Hd|Tl]) :-
	showListBackend([Hd|Tl], 10, 10).

showListBackend([], _, _) :- write('\n\n'), !.
showListBackend([Hd|Tl], EntriesPerLine, Counter) :-
	
	(Counter > 0, write(Hd), write(' '), NewCounter is (Counter-1), showListBackend(Tl, EntriesPerLine, NewCounter));
	(Counter =:= 0, write('\n'), write(Hd), write(' '), NewCounter is EntriesPerLine, showListBackend(Tl, EntriesPerLine, NewCounter)).
 
size([],0).
size([Hd|Tl],N) :- size(Tl,N1), N is N1+1.

 run :-
	X=6,
	L=[1,'bob',2,'mary',4, 5, X, 7, 8, 9],
	M=[10, 11,'ted',12,'alice',13],
	write('List L contents:'),
	showList(L),
	size(L,S),
	write('size of L = '), write(S), write('\n'),
	write('\nList M contents:'),
	showList(M),
	append(L,M,N),
	write('\nList N contents:'),
	showList(N).