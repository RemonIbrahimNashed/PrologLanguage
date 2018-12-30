

swap([N1,N2|T],[N2,N1|T]) :- N1 > N2 .
swap([H|T],[H|T1]) :- swap(T,T1) .

bubble_sort(L,SL) :-
    swap(L,TL), 
    print_list(TL),
    ! , 
    bubble_sort(TL,SL).

bubble_sort(Sl,Sl).

print_list([]) :- nl .
print_list([H|T]) :-
    write(H) ,
    write(" "),
    print_list(T).



