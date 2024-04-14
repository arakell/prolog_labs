domains 
	i = integer
	list = i*
predicates
	nondeterm delete_after(list, i, list)
	nondeterm conc(list, list, list)
	%nondeterm delete_after(list, integer, list)
	%nondeterm append_head(integer, list, list)
clauses 

	delete_after([], _, []).
	
	delete_after([X], _, [X]).	
	
	delete_after([X, X | Tail], X, Result) :- 
		delete_after([X | Tail], X, Result1), 
		concat([X], Result1, Result), !.	
   	
   	delete_after([X,Y|Tail], X,  Result) :- 
    		Y <> X,  
   		delete_after(Tail, X, Result1), 
   		concat([X], Result1, Result), !.
   	
	delete_after([Head|Tail], X, Result) :- 
		Head <> X,
    		delete_after(Tail, X, Result1), 
    		concat([Head], Result1, Result), !.

    	
    	conc([], L, L).
    	conc([H|T], L, [H|T1]) :- conc(T, L, T1).
    	
    
goal 
	%delete_after([], 1, Result).
	%delete_after([1,2,3,4,2,5,2,6], 2, Result). %1 2 4 2 2
	%delete_after([1], 1, Result). %1
	
	%delete_after([1,2], 2, Result). %1 2
	
	%delete_after([1,2,2,4,2,5,2,6], 2, Result). %1 2 2 2 2
	%delete_after([2, 2, 2, 2, 2], 2, Result).
	delete_after([2, 2, 2, 2, 2, 2, 2, 2, 2], 2, Result).
	
	
	
	
	
	
	
	
	
	