domains
	exe=tree(symbol,exe,exe);nil
predicates
	nondeterm isotree(exe, exe)
clauses
	
	isotree(tree(X, Left1, Right1), tree(X, Left2, Right2)) :- 
		isotree(Left1, Left2), isotree(Right1, Right2).
	isotree(tree(X, Left1, Right1), tree(X, Left2, Right2)) :-
		isotree(Left1, Right2), isotree(Right1, Left2).
	isotree(nil, nil).
		
goal
	%isotree(tree(nil, tree("a", nil, nil), tree(nil, tree("b", nil, nil), tree("c", nil, nil))), tree(nil, tree(nil, tree("b", nil, nil), tree("c", nil, nil)), tree("a", nil, nil))).
	isotree(tree(nil, tree("a", nil, nil), tree(nil, tree("b", nil, nil), tree("c", nil, nil))), tree(nil, tree("b", nil, nil), tree(nil, tree("a", nil, nil), tree("c", nil, nil)))).
	
	%tree(nil, tree("a", nil, nil), tree(nil, tree("b", nil, nil), tree("c", nil, nil)))
	%tree(nil, tree(nil, tree("b", nil, nil), tree("c", nil, nil)), tree("a", nil, nil))
	%tree(nil, tree("b", nil, nil), tree(nil, tree("a", nil, nil), tree("c", nil, nil)))