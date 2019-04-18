

front_token([F|T], F, T).
main(S):-
    parser(S), ! . 

parser(S) :-
    tokenize_atom(S, TokenList) , 
    tokenize
    assignment_stmt(TokenList).

assignment_stmt([F|T]):-
    write_ln("try check if it is assignment statmemt with exp in rhs"),
    id(F),
    front_token(T,F1,T1),
    assignment_op(F1),
    exp(T1),
    write_ln("it is assignment statmemt with exp in rhs"), 
    !;

    write_ln("it is not assignment statmemt with exp in rhs"),
    write_ln("try check if it is assignment statmemt with factor(digit/id) in rhs"),
    id(F),
    front_token(T,F1,T1),
    assignment_op(F1),
    front_token(T1,F2,T2),
    factor(F2) ,
    front_token(T2,F3,_),
    semi(F3),
    write_ln("it is assignment statmemt with factor(digit/id) in rhs"), 
    !;
    write_ln("it is not assignment statmemt with factor(digit/id) in rhs") , 5 == 0 . 


exp([F|T]):-
    factor(F) ,
    front_token(T,F1,T1) ,
    op(F1) , 
    front_token(T1,F2,T2) ,  
    factor(F2) , 
    front_token(T2,F3,_) ,
    semi(F3),
    ! .
factor([H|_]):-
    digit(H), ! ;
    id(H) , ! .

factor(Factor):-
    digit(Factor),! ;
    id(Factor),!.

% our terminals
id(ID) :-
    ID == a , write_ln("identifer : a "); ID == b , write_ln("identifer : b "); ID == c , write_ln("identifer : c "); 
    ID == d , write_ln("identifer : d "); ID == e , write_ln("identifer : e "); ID == f , write_ln("identifer : f "); 
    ID == g , write_ln("identifer : g "); ID == h , write_ln("identifer : h "); ID == i , write_ln("identifer : i "); 
    ID == j , write_ln("identifer : j "); ID == k , write_ln("identifer : k "); ID == l , write_ln("identifer : l "); 
    ID == m , write_ln("identifer : m "); ID == n , write_ln("identifer : n "); ID == o , write_ln("identifer : o "); 
    ID == p , write_ln("identifer : p "); ID == q , write_ln("identifer : q "); ID == r , write_ln("identifer : r "); 
    ID == s , write_ln("identifer : s "); ID == t , write_ln("identifer : t "); ID == u , write_ln("identifer : u "); 
    ID == v , write_ln("identifer : v "); ID == w , write_ln("identifer : w "); ID == x , write_ln("identifer : x "); 
    ID == y , write_ln("identifer : y "); ID == z , write_ln("identifer : z "), ! .

op(OP):-
    OP == + , write_ln("operator : +"); OP == - , write_ln("operator : -"); 
    OP == / , write_ln("operator : /"); OP == * , write_ln("operator : *"), ! .
assignment_op(OP):-
    OP == =  , write_ln("assignment operator : ="), ! .
digit(D):-
    D == 1 , write_ln("digit : 1"); D == 2 , write_ln("digit : 2"); D == 3 , write_ln("digit : 3"); 
    D == 4 , write_ln("digit : 4"); D == 5 , write_ln("digit : 5"); D == 6 , write_ln("digit : 6"); 
    D == 7 , write_ln("digit : 7"); D == 8 , write_ln("digit : 8"); D == 9 , write_ln("digit : 9"); 
    D == 0 , write_ln("digit : 0"), !  . 
semi(Semi):-
    Semi == ; , write_ln("end of statment : ;") , ! .
    
    