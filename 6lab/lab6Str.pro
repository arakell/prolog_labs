domains
	file = input ; output ; in; file2; file1
	str = string
	i = integer
	list = str*
database - db
	nondeterm count(i)
predicates
	nondeterm compare_files(str, str, i, i)
	nondeterm repeat
	nondeterm compare_lists(list, list, i, str)
	nondeterm str_list(str, list)
	nondeterm incr(i, i)
	nondeterm conc(str, str, str)
	nondeterm chk(file, file, i)
	nondeterm results(i, i)
clauses

	count(0).
  
	incr(A, B) :- B = A + 1.

	conc("",S,S).
	conc(Q,S,Z) :- fronttoken(Q,Q1,RQ), conc(RQ,S,Z1), fronttoken(Z,Q1,Z1).

	repeat.
	repeat:-repeat.

	str_list("", []). 
	str_list(S, [H|T]) :-
		frontstr(1, S, H, S1),
		str_list(S1, T).

	compare_lists([A|List1], [A|List2], NumberCh, Str) :- 
			write(A),
			nl,
			conc(Str, A, StrNew),
			write(StrNew),
			compare_lists(List1, List2, NumberCh, StrNew).
			
	compare_lists([A], [A], -1, Str) :- !.
	
	compare_lists([A|List1], [B|List2], NumberCh, Str) :- 
			A<>B, 
			conc(A, Str, StrNew),
			write(StrNew),
			str_len(Str, NumberCh),
			write(Str), 
			!.
  
  	chk(File1, File2, NumberCh) :- eof(File2); readdevice(File1), eof(File1) ; NumberCh <> -1.
  
	compare_files(File1, File2, NumberStr, NumberCh) :-
		openread(file1, File1), 
		openread(file2, File2), 
		%NumberCh = -1,
		repeat,
			%nl,
			write("NumberStr "),
			count(NumberStr),
			write(NumberStr),
			retract(count(NumberStr), db),
			incr(NumberStr, B),
			assert(count(B), db),
    
			nl,
    
			readdevice(file1),
			readln(Str1),
			str_list(Str1, List1),
			%write(Str1),
			%nl,
    
			readdevice(file2),
			readln(Str2),
			str_list(Str2, List2),
			%write(Str2),
			%nl,
			
			compare_lists(List1, List2, NumberCh, ""),
			
		
		chk(file1, file2, NumberCh), !,
		
		closefile(file1),
		closefile(file2).
    
	results(NumberStr, -1) :- write("Файлы совпадают"), nl, !.
	results(NumberStr, NumberCh) :- write("Файлы отличаются, первое отличие в строке "), write(NumberStr), write(" символ "), write(NumberCh), nl, !.

goal
	compare_files("D:\\Study\\6sem\\II\\labs\\6lab\\file1.txt", "D:\\Study\\6sem\\II\\labs\\6lab\\file2.txt", NumberStr, NumberCh), !, results(NumberStr, NumberCh).
	
	
	
	
	
	
	
	
	