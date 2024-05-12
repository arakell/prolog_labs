domains
	file = input ; output ; in; file2; file1
	str = string
	ch = char
	i = integer
	list = ch*
database - db
	nondeterm count(i)
predicates
	nondeterm compare_files(str, str, i, i)
	nondeterm repeat
	nondeterm compare_lists(list, list, i)
	nondeterm str_list(str, list)
	nondeterm write_and_compare_str(file, file, i, i)
	nondeterm incr(i, i)
clauses

	count(1).
  
	incr(A, B) :- B = A + 1.

	repeat.
	repeat:-repeat.

	str_list("", []). 
	str_list(S, [H|T]) :-
		frontchar(S, H, S1),
		str_list(S1, T).

	compare_lists([A|List1], [A|List2], -1).
	compare_lists([A|List1], [B|List2], -1).
	compare_lists([A], [A], -1).
  
  

	write_and_compare_str(File1, File2, NumberStr, NumberCh) :-
		%not(eof(file1)) , !,
		%not(eof(file2)) , !,
		write("NumberStr "),
		count(NumberStr),
		write(NumberStr),
		retract(count(NumberString), db),
		incr(NumberStr, B),
		assert(count(B), db),
    
		nl,
    
		readdevice(File1),
		readln(Str1),
		str_list(Str1, List1),
		write(Str1),
		nl,
    
		readdevice(File2),
		readln(Str2),
		str_list(Str2, List2),
		write(Str2),
		nl,
		write_and_compare_str(File1, File2, NumberStr, NumberCh).
		%compare_lists(List1, List2, NumberCh), 
    
		%write_and_compare_str(_, _, A, B).

	compare_files(File1, File2, NumberStr, NumberCh) :-
		openread(file1, File1), 
		openread(file2, File2), 
		%write_and_compare_str(file1, file2, NumberStr, NumberCh),
		repeat,
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
		write(Str1),
		nl,
    
		readdevice(file2),
		readln(Str2),
		str_list(Str2, List2),
		write(Str2),
		nl.
		
    		%compare_files(File1, File2, NumberStr, NumberCh).
		
		%closefile(file1),
		%closefile(file2).
    


goal
	compare_files("D:\\Study\\6sem\\II\\labs\\6lab\\file1.txt", "D:\\Study\\6sem\\II\\labs\\6lab\\file2.txt", NumberStr, NumberCh).
	
	
	
	
	
	
	
	
	