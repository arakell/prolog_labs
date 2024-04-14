domains 
	i = integer
	list = i*
predicates
	nondeterm delete_after(list, i, list) %удаление одного символа из списка после заданного символа
	nondeterm delete_before(list, i, list) %удаление одного символа из списка перед заданным символом
	nondeterm conc(list, list, list) %объединение списков
	
clauses 

	delete_after([], _, []). %базовый случай - пустой список
	
	delete_after([X], _, [X]). %базовый случай - список из одного элемента
	
	delete_after([X, X | Tail], X, Result) :- %случай когда первые два символа списка совпадают с заданным символом
		delete_after([X | Tail], X, Result1), 
		conc([X], Result1, Result), !.	
   	
   	delete_after([X,Y|Tail], X,  Result) :- %случай когда первый символ списка совпадает с заданным, а второй нет
    		Y <> X,  
   		delete_after(Tail, X, Result1), 
   		conc([X], Result1, Result), !.
   	
	delete_after([Head|Tail], X, Result) :- %случай когда первый символ не совпадает с заданным 
		Head <> X,
    		delete_after(Tail, X, Result1), 
    		conc([Head], Result1, Result), !.

	/*---------------------------------------------------*/

    	delete_before([], _, []). %базовый случай - пустой список
	
	delete_before([X], _, [X]). %базовый случай - список из одного элемента
	
	   	
	delete_before([X|Tail], X, Result) :- %случай когда первый символ списка совпадает с заданным
    		delete_before(Tail, X, Result1), 
    		conc([X], Result1, Result), !.
	
	delete_before([Y, X|Tail], X,  Result) :- %случай когда второй символ списка совпадает с заданным, а первый нет 
    		Y <> X,  
   		delete_before(Tail, X, Result1), 
   		conc([X], Result1, Result), !.
	
	delete_before([Y, Z|Tail], X,  Result) :- %случай когда два первых символа списка не совпадают с заданным
    		Y <> X,  Z <> X,
   		delete_before([Z | Tail], X, Result1), 
   		conc([Y], Result1, Result), !.	
    	
    	/*---------------------------------------------------*/
    	
    	conc([], L, L). %базовый случай - пустой список
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
	
	
	
	
	
	