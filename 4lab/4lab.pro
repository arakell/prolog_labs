domains 
	list = integer*
predicates
	nondeterm delete_after(list, integer, list)
	%nondeterm delete_after(list, integer, list)
	%nondeterm append_head(integer, list, list)
clauses 
	delete_after([], _, []).
	
	delete_after([X], _, [X]).
	
	delete_after([X], X, []).
	
	delete_after([X,X|Tail], X, [X, Result]) :- delete_after(Tail, X, [X , Result]), !.	
	
	delete_after([X,Y|Tail], X, [X|Result]) :- 
    		Y <> X, 
   		delete_after(Tail, X, Result), !.
   	
	delete_after([Head|Tail], X, [Head|Result]) :- 
    		delete_after(Tail, X, Result).
    
    	
    
goal 
	delete_after([1,2,3,4,2,5,2,6], 2, Result).
	%delete_after([1,2,2,4,2,5,2,6], 2, Result).
	%delete_after([2, 2, 2, 2, 2], 2, Result).
	
	
	
	
	
	
	
	
	
	