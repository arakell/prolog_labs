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
	/* �������� */
	route([1], "������", "���", 12, 16, "��", "����", 1300).
	route([2], "������", "���", 10, 16, "��", "����", 1500).
	
	route([3], "������", "�����", 12, 13, "��", "��������", 800).
	route([4], "�����"    , "���" , 13, 14, "��", "����", 600).
	route([5], "�����"    , "������" , 13, 14, "��", "����", 1100).
	route([6], "������"    , "���" , 14, 15, "��", "��������", 1500).
	
	route([7], "������"    , "������" , 9, 15, "��", "����", 2500).
	route([8], "������"    , "���" , 15, 18, "��", "����", 2700).
	route([9], "������"    , "���" , 15, 18, "��", "����", 1000).
	route([10], "���"    , "���������" , 19, 20, "��", "��������", 1200).
	route([11], "������������"    , "�����" , 3, 7, "��", "����", 1300).
	route([12], "�����"    , "�����������" , 7, 23, "��", "����", 1300).
	
	route([13], "������", "���", 12, 16, "��", "����", 1300).
	route([14], "������"    , "���" , 15, 18, "��", "����", 2700).
	route([15], "���"    , "���������" , 19, 20, "��", "��������", 1200).
	
	route([16], "������"    , "���" , 14, 15, "��", "��������", 1500).
	route([17], "������", "�����", 12, 13, "��", "��������", 800).
	route([18], "���"    , "���������" , 19, 20, "��", "��������", 1200).
	
	
	
	/*����������� �������*/
	conc([], L, L).
	conc([H|T], L, [H|T1]) :- conc(T, L, T1).
	
	/*������� ������� � ������*/
	min([Head|Tail], Result) :- min(Tail, Result), Result < Head, !.
	min([Head|_], Head).

	
	min_route(City1, City2, Day, R, Time) :- findall(N, temp_route(City1, City2, Day, _, N), L), min(L, Time), temp_route(City1, City2, Day, R, Time).

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
									 
	
	
	
goal
	min_route("������", "���", "��", R, Time).
	%min_route("������", "������", "��", R, Time).
	%min_route("�����", "���", "��", R, Time).
