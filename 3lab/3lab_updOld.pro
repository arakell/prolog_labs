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
	
	/*Объединение списков*/
	conc([], L, L).
	conc([H|T], L, [H|T1]) :- conc(T, L, T1).
	
	/*Находит минимум в списке*/
	min([Head|Tail], Result) :- min(Tail, Result), Result < Head, !.
	min([Head|_], Head).

	%Чтобы вывести только минимальный маршрут
	min_route(City1, City2, Day, R, Time) :- findall(N, temp_route(City1, City2, Day, _, N), L), min(L, Time), temp_route(City1, City2, Day, R, Time).

	%Чтобы вывести все маршруты
	%min_route(City1, City2, Day, R, Time) :- temp_route(City1, City2, Day, R, Time).

	/*Находит маршруты*/
	
	%прямой маршрут
	temp_route(Start, Dest, Day, R, Time) :- 
					route(R, Start, Dest, T2, T1,  Day, _, _),
					Time = ( T1 -  T2 ).
	
	% c 1 пересадкой
	temp_route(Start, Dest, Day, R, Time) :-  route(R1, Start, City3, T1, T2, Day, _, _),  
									 route(R2, City3, Dest, T3, T4, Day, _, _), 
									 conc(R1, R2, R),
									 T2 <= T3,
									 Time = T4 - T1.
									  
	% c 2 пересадками
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
			  write("Введите город отправления: "), readln(City1), nl,
			  write("Введите город прибытия: "), readln(City2), nl,
			  write("Введите время отправления: "), readint(Time1), nl,
			  write("Введите время прибытия: "), readint(Time2), nl,
			  write("Введите день недели в формате ПН ВТ СР ЧТ ПТ СБ ВС: "), readln(Day), nl,
			  write("Введите тип вагона (Плацкарт или Купе): "), readln(Type), nl,
			  write("Введите стоимость: "), readint(Price), nl,
			  assert(route([Number], City1, City2, Time1, Time2, Day, Type, Price), db), nl.
	
	call(1):- consult(".\bazaOld.dba", db), write("БД загружена"), nl, nl.
	call(2):- write("Введите номер маршрута в формате: "), readint(Number), nl,
		  add_route(Number).
	call(3):- write("Введите номер маршрута информацию о котором хотите удалить: "), readint(Number),
		  retractall(route([Number], _, _, _, _, _, _, _)), nl,
		  write("Записи удалены"), nl, nl.	  
	call(4):- save(".\bazaOld.dba", db), write("БД сохранена!"), nl, nl.
	call(5):- show_all().
	call(6) :- write("Введите город отправления: "), readln(City1), nl,
		      write("Введите город прибытия: "), readln(City2), nl,
		      write("Введите день недели:  "), readln(Day), nl,
		      write("Минимальный маршрут:  "), nl,
		      min_route(City1, City2, Day, R, Time), write(R), nl.
	
	repeat.
	repeat:-repeat.
	stop_menu(0).
	stop_menu(_):-fail.
									 
	menu():-repeat,
		write("Сделайте выбор"),
		nl, write("1. Загрузить БД"), 
		nl, write("2. Заполнить БД"),
		nl, write("3. Удалить строку из БД"),
		nl, write("4. Сохранить БД"), 
		nl, write("5. Показать информацию из БД"),
		nl, write("6. Найти мин. маршрут"),
		nl, write("Чтобы выйти нажмите ctrl+break"),
		nl, write("Ваш выбор: "),
		readint(X), nl,
		X<7,
		call(X),
		stop_menu(X).
	
	
goal
	menu. 
	%min_route("Москва", "СПБ", "ПТ", R, Time).
	%min_route("Москва", "Казань", "ПТ", R, Time).
	%min_route("Курск", "СПБ", "ПТ", R, Time).