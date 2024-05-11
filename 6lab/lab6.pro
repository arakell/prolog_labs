domains
	file = input ; output ; in
	str = string
	i = integer
	list = str*
predicates
	nondeterm compare_files(str, str, i, i)
	nondeterm read_list(file, list)
	nondeterm str_to_list(str,list)
	nondeterm compare_lists(list, list, i, str)
	nondeterm conc(str, str, str)
	
clauses

	conc("",S,S).
	conc(Q,S,Z) :- frontchar(Q,Q1,RQ), conc(RQ,S,Z1), frontchar(Z,Q1,Z1).

	str_to_list("",[]):-!.
	str_to_list(S,[H|T]) :- fronttoken(S,H,S1), ! , str_to_list(S1,T).

	read_list(F,List) :- not(eof(F)),!,readln(Str),
			str_to_list(Str,List),
			read_list(F,List).
	read_list(_,_).
	

	compare_lists([A|List1], [A|List2], NumberCh, Str) :- 
			write(A),
			conc(Str, A, StrNew),
			compare_lists(List1, List2, NumberCh, StrNew).
			
	compare_lists([A], [A], -1, Str).
	
	compare_lists([A|List1], [B|List2], NumberCh, Str) :- 
			A<>B, 
			str_len(Str, NumberCh),
			write(Str).

	compare_files(File1, File2, NumberStr, NumberCh) :-
		NumberStr = 0,
		openread(in, File1), 
		readdevice(in),
		read_list(in, List1),
		closefile(in),
		openread(in, File2), 
		readdevice(in),
		read_list(in, List2),
		closefile(in),
		compare_lists(List1, List2, NumberCh, ""), !.
		
		%read_file_lines(File1, Lines1),
		%read_file_lines(File2, Lines2),
		%compare_lines(Lines1, Lines2, 1).


goal
	compare_files("D:\\Study\\6 sem\\II\\labs\\6lab\\file1.txt", "D:\\Study\\6 sem\\II\\labs\\6lab\\file2.txt", NumberStr, NumberCh).
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	