domains
	lists = integer*
	day, city = symbol
	time, price = integer
database - db
	route(lists, city, city, time, time, day, symbol, price)
predicates
	nondeterm min_route(city, city, day, lists, time)
	
	nondeterm conc(lists, lists, lists)
	
	nondeterm temp_route(city, city, day, lists, time)
	
	nondeterm min(lists, integer)
	
	nondeterm repeat
	
	nondeterm stop_menu(integer)
	
	nondeterm call(integer)
	
	nondeterm menu()
	
	nondeterm add_route(integer)
	
	nondeterm show_all()
clauses
	
	/*����������� �������*/
	conc([], L, L).
	conc([H|T], L, [H|T1]) :- conc(T, L, T1).
	
	/*������� ������� � ������*/
	min([Head|Tail], Result) :- min(Tail, Result), Result < Head, !.
	min([Head|_], Head).

	%����� ������� ������ ����������� �������
	min_route(City1, City2, Day, R, Time) :- findall(N, temp_route(City1, City2, Day, _, N), L), min(L, Time), temp_route(City1, City2, Day, R, Time).

	%����� ������� ��� ��������
	%min_route(City1, City2, Day, R, Time) :- temp_route(City1, City2, Day, R, Time).

	/*������� ��������*/
	
	%������ �������
	temp_route(Start, Dest, Day, R, Time) :- 
					route(R, Start, Dest, T2, T1,  Day, _, _),
					Time = ( T1 -  T2 ).
	
	% c 1 ����������
	temp_route(Start, Dest, Day, R, Time) :-  route(R1, Start, City3, T1, T2, Day, _, _),  
									 route(R2, City3, Dest, T3, T4, Day, _, _), 
									 conc(R1, R2, R),
									 T2 <= T3,
									 Time = T4 - T1.
									  
	% c 2 �����������
	temp_route(Start, Dest, Day, R, Time) :-  route(R1, Start, City1, T1, T2, Day, _, _), 
	 								 route(R2, City1, City2, T3, T4, Day, _, _), 
									 route(R3, City2, Dest, T5, T6, Day, _, _), 
									 conc(R1, R2, R_temp),
									 conc(R_temp, R3, R),
									 T2 <= T3, T4 <= T5,
									 Time = T6 - T1.
									 
	show_all():- route(Number, City1, City2, Time1, Time2, Day, Type, Price), 
			    write(Number, " ", City1, " ", City2, " ", Time1,  " ",Time2, " ", Day, " ", Type, " ", Price), nl, nl.
	
	add_route(Number):- retractall(route([Number], _, _, _, _, _, _, _)),
			  write("������� ����� �����������: "), readln(City1), nl,
			  write("������� ����� ��������: "), readln(City2), nl,
			  write("������� ����� �����������: "), readint(Time1), nl,
			  write("������� ����� ��������: "), readint(Time2), nl,
			  write("������� ���� ������ � ������� �� �� �� �� �� �� ��: "), readln(Day), nl,
			  write("������� ��� ������ (�������� ��� ����): "), readln(Type), nl,
			  write("������� ���������: "), readint(Price), nl,
			  assert(route([Number], City1, City2, Time1, Time2, Day, Type, Price), db), nl.
	
	call(1):- consult(".\bazaOld.dba", db), write("�� ���������"), nl, nl.
	call(2):- write("������� ����� �������� � �������: "), readint(Number), nl,
		  add_route(Number).
	call(3):- write("������� ����� �������� ���������� � ������� ������ �������: "), readint(Number),
		  retractall(route([Number], _, _, _, _, _, _, _)), nl,
		  write("������ �������"), nl, nl.	  
	call(4):- save(".\bazaOld.dba", db), write("�� ���������!"), nl, nl.
	call(5):- show_all().
	call(6) :- write("������� ����� �����������: "), readln(City1), nl,
		      write("������� ����� ��������: "), readln(City2), nl,
		      write("������� ���� ������:  "), readln(Day), nl,
		      write("����������� �������:  "), nl,
		      min_route(City1, City2, Day, R, Time), write(R), nl.
	
	repeat.
	repeat:-repeat.
	stop_menu(0).
	stop_menu(_):-fail.
									 
	menu():-repeat,
		write("�������� �����"),
		nl, write("1. ��������� ��"), 
		nl, write("2. ��������� ��"),
		nl, write("3. ������� ������ �� ��"),
		nl, write("4. ��������� ��"), 
		nl, write("5. �������� ���������� �� ��"),
		nl, write("6. ����� ���. �������"),
		nl, write("����� ����� ������� ctrl+break"),
		nl, write("��� �����: "),
		readint(X), nl,
		X<7,
		call(X),
		stop_menu(X).
	
	
goal
	menu. 
	%min_route("������", "���", "��", R, Time).
	%min_route("������", "������", "��", R, Time).
	%min_route("�����", "���", "��", R, Time).