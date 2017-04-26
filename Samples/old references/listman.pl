:- use_module(library(lists)).
run :- 
	write('\n*********************************************************************************'),
	write('\n#################################################################################'),
	write('\n*********************************************************************************\n'),
	write('Enter an option:'),
		write('\n\t \'listhelp.\'->help on program use'),
		write('\n\t \'addto(initlist, data, finallist).\' add elements to a  list'),
		write('\n\t \'show(list).\' display a list'),
	write('\n*********************************************************************************'),
	write('\n#################################################################################'),
	write('\n*********************************************************************************\n'),
	read(Input),
	call(Input),
	run.

listhelp :-
	write('\n###############################################################\n'),
	write('Usage Help:'),
	write('\n==========='),
	write('This is how you use this nifty software\n'),
	write('\n###############################################################\n').
	
size([],0):- write('empty\n').
size([H|T],N) :- size(T,N1), N is N1+1.
	
 
addto([],A,L)   :- L = [A].
addto([Head|Tail], A, [Head|Result]):-  
     append(Tail, A, Result).
	 
show([]):- [], write('\nend of list \n').
show([X]):- write(X), write('single char\n'), !.
show([H|T]) :-  write(H), write('recusive show'), show([T]).