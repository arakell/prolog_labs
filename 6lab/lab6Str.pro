
domains
	file = input ; output ; in; file2; file1
	str = string
	ch = char
	i = integer
	list = ch*
predicates
	nondeterm compare_files(str, str, i, i)
	nondeterm repeat
	nondeterm compare_lists(list, list, i)
	nondeterm str_list(str, list)
	nondeterm incr(i, i)
clauses

	repeat.
	repeat:-repeat.

	str_list("", []). 
	str_list(S, [H|T]) :-
		frontchar(S, H, S1),
		str_list(S1, T).

	compare_lists([A|List1], [A|List2], NumberCh) :- compare_lists(List1, List2, NumberCh).
	compare_lists([A|List1], [B|List2], NumberCh).
	compare_lists([A], [A], -1).
	
	incr(0, 1).
	incr(X, Y) :- Z = X + 1, incr(X, Z).
	incr(X, Y) :- Y > X, !.
	
	%try_eof(File1, File2, Result) :- eof(File1), eof(File2), Result =  

	compare_files(File1, File2, NumberStr, NumberCh) :-
		OldNumberStr = 0,
		NumberStr = 1,
		openread(file1, File1), 
		openread(file2, File2),
		 
		repeat,
		%incr(OldNumberStr, NumberStr),
		write("NumberStr "),
		write(NumberStr),
		nl,
		readdevice(file1),
		readln(Str1),
		str_list(Str1, List1),
		write(Str1),
		nl,
		readdevice(file2),
		readln(Str2),
		str_list(Str2, List2),
		write(Str2),
		nl,
		
		compare_lists(List1, List2, NumberCh),
		eof(file1),
		eof(file2), NumberStr <>1, !,
		NumberCh <> -1, !,
		
		closefile(file1),
		closefile(file2), !.
		


goal
	compare_files("D:\\Study\\6 sem\\II\\labs\\6lab\\file1.txt", "D:\\Study\\6 sem\\II\\labs\\6lab\\file2.txt", NumberStr, NumberCh).
	
	
	
	
	
	
	
	
	