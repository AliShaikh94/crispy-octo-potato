
updateSymptoms([]) :- !.

updateSymptoms([IDListHd|IDListTl]) :-
	person(IDListHd, Age, FamID, Sympts, DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList),
	(
		(

	 		( (Sympts \='dead'), 
				(DaysSinceExposed =:= IncubateDays), 
					retract(person(IDListHd, Age, FamID, Sympts, DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList)), 
					assert(person(IDListHd, Age, FamID, 'fever', DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList)) );
	 		( (Sympts \='dead'), 
				(DaysSinceExposed =:= (IncubateDays+4)), 
					retract(person(IDListHd, Age, FamID, Sympts, DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList)), 
					assert(person(IDListHd, Age, FamID, 'rash', DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList)) );
	 		( (Sympts \='dead'), 
				(DaysSinceExposed =:= (IncubateDays+6)), 
				retract(person(IDListHd, Age, FamID, Sympts, DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList)), 
				assert(person(IDListHd, Age, FamID, 'papules', DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList)) );
	 		( (Sympts \='dead'), 
				(DaysSinceExposed =:= (IncubateDays+7)), (7 < DiesDaysAftFever),
				retract(person(IDListHd, Age, FamID, Sympts, DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList)), 
				assert(person(IDListHd, Age, FamID, 'vesicles', DaysSinceExposed, IncubateDays, IsDiag, DiesDaysAftFever, MixGroupsInList, MixGroupsOutList)) );
	 		( (Sympts \='dead'), 
				(DaysSinceExposed >= (IncubateDays+DiesDaysAftFever)), personIsDead(IDListHd) );
		  	(Sympts = 'dead')
		);true
	), updateSymptoms(IDListTl).