database
	language(string)
database - mydatabase
	knows(string,string)
predicates
	nondeterm menu()
	nondeterm add_lang(integer,string)
	nondeterm repeat
	nondeterm stop_menu(integer)
	nondeterm call(integer)	
	nondeterm show_all()
clauses
	language("Klingon").
	language("Russian").
	language("C/C++").
	language("Assembler").
	language("Prolog").
	
	add_lang(I,Name):-language(X), write("Do you know ",X," language?"),
			  nl, write("(yes or no): "),readln(Answer), Answer="yes",
			  retractall(knows(Name,X)),
			  assert(knows(Name,X),mydatabase),
			  I=I-1, I<>0, fail.
	
	repeat.
	repeat:-repeat.
	stop_menu(0).
	stop_menu(_):-fail.

	show_all():- knows(Name, Language), write(Name," ",Language).

	
	call(1):- consult(".\baza.dba", mydatabase), write("Database was loaded!").
	call(2):- nl, nl, write("Enter your name: "), readln(Name),
		  nl, add_lang(5,Name).
	call(3):- nl, nl, write("Please, enter name you want to delete: "), readln(Name),
		  retractall(knows(Name,_)), nl,
		  write("All information about ",Name," was deleted!").
	call(4):- save(".\baza.dba", mydatabase), write("Database saved!").
	call(5):- show_all().
	call(0):- stop_menu(_).

	menu():-repeat,
		write("Choose action:"),
		nl, write("1. Load database"),
		nl, write("2. Ask user"),
		nl, write("3. Delete string"),
		nl, write("4. Save database"),
		nl, write("5. Show database"),
		nl, write("0. Exit"),
		nl, write("Your choice -> "),
		readint(X),
		X<6,
		call(X),
		readln(_),
		stop_menu(X).
goal
	menu. 
