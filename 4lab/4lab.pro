domains 
	i = integer
	list = i*
predicates
	nondeterm delete_after(list, i, list)
	nondeterm delete_before(list, i, list)
	nondeterm conc(list, list, list)
	
clauses 

	delete_after([], _, []).
	
	delete_after([X], _, [X]).	
	
	delete_after([X, X | Tail], X, Result) :- 
		delete_after([X | Tail], X, Result1), 
		conc([X], Result1, Result), !.	
   	
   	delete_after([X,Y|Tail], X,  Result) :- 
    		Y <> X,  
   		delete_after(Tail, X, Result1), 
   		conc([X], Result1, Result), !.
   	
	delete_after([Head|Tail], X, Result) :- 
		Head <> X,
    		delete_after(Tail, X, Result1), 
    		conc([Head], Result1, Result), !.

	/*---------------------------------------------------*/

    	delete_before([], _, []).
	
	delete_before([X], _, [X]).	
	
	   	
	delete_before([X|Tail], X, Result) :- 
    		delete_before(Tail, X, Result1), 
    		conc([X], Result1, Result), !.
	
	delete_before([Y, X|Tail], X,  Result) :- 
    		Y <> X,  
   		delete_before(Tail, X, Result1), 
   		conc([X], Result1, Result), !.
	
	delete_before([Y, Z|Tail], X,  Result) :- 
    		Y <> X,  Z <> X,
   		delete_before([Z | Tail], X, Result1), 
   		conc([Y], Result1, Result), !.	
    	
    	conc([], L, L).
    	conc([H|T], L, [H|T1]) :- conc(T, L, T1).
    	
    
goal 
	%delete_after([], 1, Result).
	%delete_after([1,2,3,4,2,5,2,6], 2, Result). %1 2 4 2 2
	%delete_after([1], 1, Result). %1
	%delete_after([1,2], 2, Result). %1 2
	%delete_after([1,2,2,4,2,5,2,6], 2, Result). %1 2 2 2 2
	%delete_after([2, 2, 2, 2, 2], 2, Result).
	%delete_after([2, 2, 2, 2, 2, 2, 2, 2, 2], 2, Result).
	
	delete_before([2, 1, 2], 2, Result).
	%delete_before([1, 2, 3, 4, 2], 2, Result).
	%delete_before([2, 2, 2, 2, 2], 2, Result).
	%delete_before([2, 2, 2, 2, 2, 2, 2, 2, 2], 2, Result).
	%delete_before([1, 1, 3, 2, 1, 2, 2, 3], 2, Result).
	
	
	
	
	
	