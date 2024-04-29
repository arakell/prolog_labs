domains
	exe=tree(symbol,exe,exe);nil
	i = integer
predicates
	nondeterm tree(symbol, exe, exe)
	nondeterm isotree(exe, exe)
	nondeterm depth(exe, i)
	nondeterm max(i, i, i)
clauses
	
	isotree(nil, nil).
	isotree(tree(X, Left1, Right1), tree(X, Left2, Right2)) :-
		isotree(Left1, Right2), isotree(Right1, Left2), !.
	isotree(tree(X, Left1, Right1), tree(X, Left2, Right2)) :- 
		isotree(Left1, Left2), isotree(Right1, Right2), !.

	max(X, Y, X) :- X >= Y.
	max(X, Y, Y) :- X < Y.
		
	depth(nil, 0).
	depth(tree(_, nil, nil), 1).
	depth(tree(_, Left, Right), Depth) :-
   		depth(Left, LeftDepth),        
    		depth(Right, RightDepth),
    		max(LeftDepth, RightDepth, Res), 
   		Depth =  Res + 1.  
		
goal
	%isotree(tree(nil, tree("a", nil, nil), tree(nil, tree("b", nil, nil), tree("c", nil, nil))), tree(nil, tree(nil, tree("b", nil, nil), tree("c", nil, nil)), tree("a", nil, nil))).
	%isotree(tree(nil, tree("a", nil, nil), tree(nil, tree("b", nil, nil), tree("c", nil, nil))), tree(nil, tree("b", nil, nil), tree(nil, tree("a", nil, nil), tree("c", nil, nil)))).
	isotree(tree("a", tree("b", nil, nil), tree("c", nil, nil)), tree("a", tree("c", nil, nil), tree("b", nil, nil))).
	%depth(tree(nil, tree("a", nil, nil), tree(nil, tree("b", nil, nil), tree("c", nil, nil))), X).

	
	
	
	%tree(nil, tree("a", nil, nil), tree(nil, tree("b", nil, nil), tree("c", nil, nil)))
	%tree(nil, tree(nil, tree("b", nil, nil), tree("c", nil, nil)), tree("a", nil, nil))
	%tree(nil, tree("b", nil, nil), tree(nil, tree("a", nil, nil), tree("c", nil, nil)))