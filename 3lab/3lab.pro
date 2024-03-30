database
	language(string)
database - db
	knows(string,string)
predicates
	nondeterm menu()
	nondeterm add_lang(string)
	nondeterm repeat
	nondeterm stop_menu(integer)
	nondeterm call(integer)	
	nondeterm show_all()
clauses
	language("�������").
	language("����������").
	language("���������").
	language("�����������").
	
	add_lang(Name):-language(X), write("���� ������� ����� ", X, " ����? "),
			  readln(Answer), Answer="��",
			  retractall(knows(Name,X)),
			  assert(knows(Name,X), db), nl.
	
	repeat.
	repeat:-repeat.
	stop_menu(0).
	stop_menu(_):-fail.

	show_all():- knows(Name, Language), write(Name," ",Language), nl, nl.

	call(1):- consult(".\baza.dba", db), write("�� ���������"), nl, nl.
	call(2):- write("������� ���: "), readln(Name), nl,
		  add_lang(Name).
	call(3):- write("������� ��� �������� ���������� � ������� ������ �������: "), readln(Name),
		  retractall(knows(Name,_)), nl,
		  write("������ �������"), nl, nl.
	call(4):- save(".\baza.dba", db), write("�� ���������!"), nl, nl.
	call(5):- show_all().

	menu():-repeat,
		write("�������� �����"),
		nl, write("1. ��������� ��"), % �������� �� ���� �������� ��������� �����
		nl, write("2. ��������� ��"),
		nl, write("3. ������� ������ �� ��"),
		nl, write("4. ��������� ��"), 
		nl, write("5. �������� ���������� �� ��"),
		nl, write("����� ����� ������� ctrl+break"),
		nl, write("��� �����: "),
		readint(X), nl,
		X<6,
		call(X), 
		%nl,
		stop_menu(X).
goal
	menu. 

