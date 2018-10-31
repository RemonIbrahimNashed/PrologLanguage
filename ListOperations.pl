

mymember(X,[X|_]).
mymember(X,[_|T]) :- 
    mymember(X,T) .


list_len([],0) .
list_len([_|T],N) :-    
    list_len(T,M) ,
    N is M+1 .


list_sum([],0) .  
list_sum([H|T] , S ) :-
    list_sum(T,S1),
    S is S1 + H .


list_avg([H|T],V) :-
    list_len([H|T],N),
    list_sum([H|T],S),
    V is S / N .


is_even(L) :-
    list_len(L,X1),
    0 =:= mod(X1,2).


is_odd(L) :-
    list_len(L,X1),
    1 =:= mod(X1,2).


even([]).
even([_,_|T]):- 
    even(T).


odd([_]).
odd([_,_|T]):- 
    odd(T).


check_list(L) :-
    even(L),write("even");
    odd(L) , write("odd").


list_con([],L,L) .
list_con( [H|T] ,L,[H|T1] ) :-  
    list_con(T,L,T1) .



max(N1,N2,N1) :- N1 >= N2 .
max(N1,N2,N2) :- N2 > N1 .

list_max([M],M) .
list_max([H|T],M):-
    list_max(T,M1),
    max(H,M1,M).

min(N1,N2,N1) :- N1 =< N2 .
min(N1,N2,N2) :- N2 < N1 . 

list_min([M],M).
list_min([H|T],M) :-
    list_min(T,M1),
    min(H,M1,M).

list_list_divide([],[],[]).
list_list_divide([N],[N],[]).
list_list_divide([N1,N2|T],[N1|T1],[N2|T2]):-
    list_list_divide(T,T1,T2).


list_list_divide([],[],[]).
list_list_divide([M],[M],[]).
list_list_divide([N1,N2|T],[N1|T1],[N2|T2]):-
	list_list_divide(T,T1,T2).



list_con([],L1,L2,T) :- 
	list_con(L1,L2,T) .

list_con([H|T],L1,L2,[H|T1]):-
	list_con(T,L1,L2,T1).





list_divide(L,X,Y):-

	even(L),
		list_con(X,Y,L),
		list_len(X,N1),
		list_len(Y,N2),
		N1 = N2 ;
	odd(L),
		
		list_con(X,Y,L),
		list_len(X,N1),
		list_len(Y,N2),
		N1 =:= N2+1 .

list_divide(L,X,Y,Z):-
	list_con(X,Y,Z,L),
	list_len(X,N1),
	list_len(Y,N2),
	list_len(Z,N3),
	N1 = N2 ,
	N2 = N3 .