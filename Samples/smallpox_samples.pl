
/**************************************************************************
the most important rule in this simulation is the person, the person fields should
be evident by their variable names, however options for Sympts include: 
notex, exposed, fever, rash,  vesicles and papules . Mixing groups are stored in the CurrMixGrp list
where the person has visited on one any particular day is stored the MixGrpsVisitedList.
**************************************************************************/

person(PID, Age, FamID, Sympts, DaysAftExpose, IncubateDays, IsDiagnosed, DaysDiesAfter, [CurrMixGrp|_], MixGrpsVisitedList)

/*************************************************************************
incrementDay is a sample of how to use retract and assert, the rule 
day(DayNum) is removed from the rules and the NewDayNum is asserted
*************************************************************************/

incrementDay :-
	retract(day(DayNum)),
	NewDayNum is DayNum+1,
	assert(day(NewDayNum)).	
	
/************************************************************************
in order to retrieve totals we can do things like the following:
to just find the total number (count) of people , regardless of their condition it would be
stored as variable PopulationTotal:
************************************************************************/
	
aggregate_all(count, person( _, _, _, _, _, _, _, _, _, _), PopulationTotal)

/***********************************************************************
BUT..HOWEVER.. to find a LIST of those IDs of those wh are exposed but not symptomatic
************************************************************************/

	findall(ID, person(ID,_, _, 'exposed', _, _, _, _, _, _), ExposedIDs),
	
/*******************************************************************************
	other findall options are listed int the Total infected computation below
	(papules are small, hard elevation lesion <1cm in diameter, where
	Vesicles are the fluid filled, > 1/2 cm, tender or painful to the touch, classic circular
	"smallpox", pustules are those that are pus filled and in large numbers may indicated systemic that will usually rupture
********************************************************************************/

	TotalInfected is Exposed+Fever+Rash+Papules+Vesicles,
	TotalAlive is PopulationTotal-DeadTotal,
	
/**************************************************************
	currDayLocs(X) returns a list of all unique mixing groups being 
	visited by persons for the current day; no mixing groups
	returned in the list are repeated.
	currDayUniqueLocs(L) is called only by currDayGroups(X) ***************/

currDayGrps(X) :- setof(Loc, currDayUniqueLocs(Loc), X). 

currDayUniqueLocs(L) :- bagof( C, person(_,_,_,_,_,_,_,_,_,[C|_],_), L).

/************************************************************************
SetIncubationPeriod is an example of how to use the Random number generator
in Prolog, the between predicate is mapped to a normal distribution
*************************************************************************/


setIncubationPeriod(NewIncubationPeriod) :-
	random_between(0, 99, RandNum),
	(
		(between(0, 0, RandNum), (NewIncubationPeriod = 7));
		(between(1, 2, RandNum), (NewIncubationPeriod = 8));
		(between(3, 6, RandNum), (NewIncubationPeriod = 9));
		(between(7, 15, RandNum), (NewIncubationPeriod = 10));
		(between(16, 29, RandNum), (NewIncubationPeriod = 11));
		(between(30, 69, RandNum), (NewIncubationPeriod = 12));
		(between(70, 83, RandNum), (NewIncubationPeriod = 13));
		(between(84, 92, RandNum), (NewIncubationPeriod = 14));
		(between(93, 96, RandNum), (NewIncubationPeriod = 15));
		(between(97, 98, RandNum), (NewIncubationPeriod = 16));
		(between(99, 99, RandNum), (NewIncubationPeriod = 17))
	).