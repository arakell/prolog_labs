domains
	lists = integer*
	day, city = symbol
	time, price = integer
predicates
	nondeterm route(lists, city, city, time, time, day, symbol, price)
	
	nondeterm min_route(city, city, day, lists, time)
	
	nondeterm conc(lists, lists, lists)
	
	nondeterm temp_route(city, city, day, lists, time)
	
	nondeterm min(lists, integer)
clauses
	/* Маршруты */
	route([1], "Москва", "СПБ", 12, 16, "ПТ", "Купе", 1300).
	route([2], "Москва", "СПБ", 10, 16, "ПТ", "Купе", 1500).
	
	route([3], "Москва", "Курск", 12, 13, "ПТ", "Плацкарт", 800).
	route([4], "Курск"    , "СПБ" , 13, 14, "ПТ", "Купе", 600).
	route([5], "Курск"    , "Рязань" , 13, 14, "ПТ", "Купе", 1100).
	route([6], "Рязань"    , "СПБ" , 14, 15, "ПТ", "Плацкарт", 1500).
	
	route([7], "Москва"    , "Казань" , 9, 15, "ПТ", "Купе", 2500).
	route([8], "Москва"    , "Уфа" , 15, 18, "ПТ", "Купе", 2700).
	route([9], "Казань"    , "Уфа" , 15, 18, "ПТ", "Купе", 1000).
	route([10], "Уфа"    , "Челябинск" , 19, 20, "ПТ", "Плацкарт", 1200).
	route([11], "Екатеринбург"    , "Пермь" , 3, 7, "ПТ", "Купе", 1300).
	route([12], "Пермь"    , "Архангельск" , 7, 23, "ПТ", "Купе", 1300).
	
	route([13], "Москва", "СПБ", 12, 16, "ПН", "Купе", 1300).
	route([14], "Москва"    , "Уфа" , 15, 18, "ПН", "Купе", 2700).
	route([15], "Уфа"    , "Челябинск" , 19, 20, "ПН", "Плацкарт", 1200).
	
	route([16], "Рязань"    , "СПБ" , 14, 15, "СР", "Плацкарт", 1500).
	route([17], "Москва", "Курск", 12, 13, "СР", "Плацкарт", 800).
	route([18], "Уфа"    , "Челябинск" , 19, 20, "СР", "Плацкарт", 1200).
	
	
	
	/*Объединение списков*/
	conc([], L, L).
	conc([H|T], L, [H|T1]) :- conc(T, L, T1).
	
	/*Находит минимум в списке*/
	min([Head|Tail], Result) :- min(Tail, Result), Result < Head, !.
	min([Head|_], Head).

	
	min_route(City1, City2, Day, R, Time) :- findall(N, temp_route(City1, City2, Day, _, N), L), min(L, Time), temp_route(City1, City2, Day, R, Time).

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
									 
	
	
	
goal
	min_route("Москва", "СПБ", "ПТ", R, Time).
	%min_route("Москва", "Казань", "ПТ", R, Time).
	%min_route("Курск", "СПБ", "ПТ", R, Time).
