:- dynamic day/1, containScore/1, infectScore/1.
day(0).
containScore(0.1). 
infectScore(0.1).


incrementDay :-	
	retract(day(DayNum)),
	NewDayNum is DayNum+1,
	assert(day(NewDayNum)).	

set(A,B) :- set(A, B, []).
set([],[],_).
set([H|T],[H|Out],Seen) :- not(member(H,Seen)), set(T,Out, [H|Seen]).
set([H|T],Out, Seen) :- member(H,Seen), set(T,Out,Seen).

%% currDayGrps(X) :- setof(Loc, currDayUniqueLocs(Loc), X). 

%% currDayUniqueLocs(L) :- findall( X, (person(_,_,_,_,_,_,_,_,_,C,_), member(X, C)) , L).

currDayGrps(X) :- setof(Loc, currDayUniqueLocs(Loc), X). 

currDayUniqueLocs(L) :- bagof( C, person(_,_,_,_,_,_,_,_,_,[C|_],_), L).

%% aggregate_all(count, person( _, _, _, _, _, _, _, _, _, _), PopulationTotal).
contaminate(IDListHd) :-
	person(IDListHd, Age, Resistance, FamID, Sympts, DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList),
	(
		retract(person(IDListHd, Age, Resistance, FamID, Sympts, DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList)), 
		assert(person(IDListHd, Age, Resistance, FamID, 'exposed', DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList)) 
	).

infect(IDListHd) :-
	person(IDListHd, Age, Resistance, FamID, Sympts, DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList),
	(
		retract(person(IDListHd, Age, Resistance, FamID, Sympts, DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList)), 
		assert(person(IDListHd, Age, Resistance, FamID, 'fever', DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList)) 
	).
	

initialInfect([]) :- !
.
initialInfect([IDListHd|IDListTl]) :-
	person(IDListHd, Age, Resistance, FamID, Sympts, DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList),
	(
		random_between(1, 16, RandNum),
		X= RandNum * (1/16*  1/20),
		aggregate_all(count, person( _, _, _,_, 'exposed', _, _, _, _, _, _), Size),
		%% findall(ID, (person(ID,_, _,_, X, _, _, _, _, _, _),not(X='notex') ), Size),
		%% Con is 1-((1-X) ^ Size), write('CON: '), write(Con),
		%% Inf is (1-((1-X) ^ NewSize))^Resistance,
		Con is 1/3,
		maybe(Con) -> (
			NewSize is Size+1,
			contaminate(IDListHd),
			Inf is 1/3,
			maybe(Inf) -> infect(IDListHd);true
			);true

	), initialInfect(IDListTl).




updateSymptoms([]) :- !.

updateSymptoms([IDListHd|IDListTl]) :-
	person(IDListHd, Age, Resistance, FamID, Sympts, DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList),
	(
		(

	 		( (Sympts \='dead'), 
				(DaysSinceExposed =:= IncubateDays), 
					retract(person(IDListHd, Age, Resistance, FamID, Sympts, DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList)), 
					assert(person(IDListHd, Age, Resistance, FamID, 'fever', DaysSinceExposed+ 1, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList)) );
	 		( (Sympts \='dead'), 
				(DaysSinceExposed =:= (IncubateDays+4)), 
					retract(person(IDListHd, Age, Resistance, FamID, Sympts, DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList)), 
					assert(person(IDListHd, Age, Resistance, FamID, 'rash', DaysSinceExposed+ 1, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList)) );
	 		( (Sympts \='dead'), 
				(DaysSinceExposed =:= (IncubateDays+6)), 
				retract(person(IDListHd, Age, Resistance, FamID, Sympts, DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList)), 
				assert(person(IDListHd, Age, Resistance, FamID, 'papules', DaysSinceExposed+ 1, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList)) );
	 		( (Sympts \='dead'), 
				(DaysSinceExposed =:= (IncubateDays+7)), (7 < DiesDaysAftFever),
				retract(person(IDListHd, Age, Resistance, FamID, Sympts, DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList)), 
				assert(person(IDListHd, Age, Resistance, FamID, 'vesicles', DaysSinceExposed+ 1, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList)) );
		  	(Sympts = 'dead')
		);true
	), updateSymptoms(IDListTl).

run:-
	incrementDay,
	findall(ID, (person(ID,_, _,_, _, _, _, _, _, X, _), member(2005, X)), InitialGroupIDs),
	day(DayNum),
	NewDayNum is DayNum,
	initialInfect(InitialGroupIDs),

	aggregate_all(count, person( _, _, _, _,_, _, _, _, _, _, _), PopulationTotal),
	aggregate_all(count, person( _, _, _,_, 'exposed', _, _, _, _, _, _), ExposedTotal),
	aggregate_all(count, person( _, _, _,_, 'notex', _, _, _, _, _, _), NotExposedTotal),
	findall(ID, person(ID,_, _,_, 'exposed', _, _, _, _, _, _), ExposedIDs),
	findall(ID, person(ID,_, _,_, 'fever', _, _, _, _, _, _), FeverIDs),
	findall(ID, person(ID,_, _,_, 'rash', _, _, _, _, _, _), RashIDs),
	findall(ID, person(ID,_, _,_, 'papules', _, _, _, _, _, _), PapulesIDs),
	findall(ID, person(ID,_, _,_, 'vesicles', _, _, _, _, _, _), VesiclesIDs),
	aggregate_all(count, person( _, _, _,_,'dead', _, _, _, _, _, _), DeadTotal),

	%% TotalInfected is Exposed+Fever+Rash+Papules+Vesicles,
	TotalAlive is PopulationTotal-DeadTotal,
	TotalSympto is TotalAlive-NotExposedTotal-ExposedTotal,


	write('DAY: '), write(NewDayNum), write(' ,Not Exposed: ' ), write(NotExposedTotal), write(' ,Exposed: ' ), write(ExposedTotal), write(' ,Symptoms ' ), write(TotalSympto).


stepGroup([]) :- !.

stepGroup([[IDListHd|[]]|IDListTl]):-
	%% hd|IDListHd,
	findall(ID, (person(ID,_, _,_, _, _, _, _, _, X, _), member(IDListHd, X)), UserIDs),
	stepProgress(UserIDs, UserIDs),
	stepGroup(IDListTl).


stepProgress([]) :- !.

stepProgress([IDListHd|IDListTl], GroupList) :-
	
	person(IDListHd, Age, Resistance, FamID, Sympts, DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList),
	(
		random_between(1, 16, RandNum),
		X= RandNum * (1/16*  1/20),
		aggregate_all(count, (person( ID, _, _,_, 'exposed', _, _, _, _, _, _), member(ID, GroupList)), Size),
		findall(ID, (person(ID,_, _,_, X, _, _, _, _, _, _),not(X='notex'), member(ID, GroupList) ), InfSize),
		 Con is 1-((1-X) ^ Size),

		maybe(Con) -> (
			NewSize is Size+1,
			contaminate(IDListHd),
			Inf is (1-((1-X) ^ InfSize))^Resistance,
			maybe(Inf) -> infect(IDListHd);true
			);true

	), initialInfect(IDListTl).


dotProduct([IdHD|IdListTl], X):-
	X is X * dotProduct(IDListTl, IdHD)

step:- 
	incrementDay,
	findall(ID, (person(ID,_, _,_, X, _, _, _, _, _, _),not(X='notex')), ExposedIDs),
	updateSymptoms(ExposedIDs),
	currDayGrps(Y),
	findall(ID, (person(ID,_, _,_, X, _, _, _, _, _, _),not(X='dead')), AliveIDs),
	stepIndividual(AliveIDs, Y),
	stepGroup(Y).

assign
	person(IDListHd, Age, Resistance, FamID, Sympts, DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList),
	(
		random_between(1, 16, RandNum),
		X= RandNum * (1/16*  1/20),
		findall(Y, (member(Y, MixGroupsInList), ((maybe(X) -> true;false, (Y >= 2000));(maybe(.05) -> true;false, (Y < 2000))) ), MixGroupsOutList),
		findall(ID, aggregate_all(count, (person( _, _, _,_, _, _, _, _, _, _, _), member(ID, GroupList)), Size),
		findall(ID, (person(ID,_, _,_, X, _, _, _, _, _, _),not(X='notex'), member(ID, GroupList) ), InfSize),
		Con is 1-((1-X) ^ Size),

		maybe(Con) -> (
			NewSize is Size+1,
			contaminate(IDListHd),
			Inf is (1-((1-X) ^ InfSize))^Resistance,
			maybe(Inf) -> infect(IDListHd);true
			);true

	), initialInfect(IDListTl).

isContaminated(GroupIds):-
	X is 1 - 

stepIndividual([IdHD|IdListTl], GroupList):-
 	person(IdHD, Age, Resistance, FamID, Sympts, DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList),

 	

day:-
	aggregate_all(count, person( _, _, _, _,_, _, _, _, _, _, _), PopulationTotal),
	aggregate_all(count, person( _, _, _,_, 'exposed', _, _, _, _, _, _), ExposedTotal),
	aggregate_all(count, person( _, _, _,_, 'notex', _, _, _, _, _, _), NotExposedTotal),
	findall(ID, person(ID,_, _,_, 'exposed', _, _, _, _, _, _), ExposedIDs),
	findall(ID, person(ID,_, _,_, 'fever', _, _, _, _, _, _), FeverIDs),
	findall(ID, person(ID,_, _,_, 'rash', _, _, _, _, _, _), RashIDs),
	findall(ID, person(ID,_, _,_, 'papules', _, _, _, _, _, _), PapulesIDs),
	findall(ID, person(ID,_, _,_, 'vesicles', _, _, _, _, _, _), VesiclesIDs),
	aggregate_all(count, person( _, _, _,_,'dead', _, _, _, _, _, _), DeadTotal),

	day(DayNum),
	NewDayNum is DayNum,
	TotalAlive is PopulationTotal-DeadTotal,
	TotalSympto is TotalAlive-NotExposedTotal-ExposedTotal,


	write('DAY: '), write(NewDayNum), write(' ,Not Exposed: ' ), write(NotExposedTotal), write(' ,Exposed: ' ), write(ExposedTotal), write(' ,Symptoms ' ), write(TotalSympto).