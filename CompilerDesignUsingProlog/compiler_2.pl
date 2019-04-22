%read the source code file as one string
read(File,End,String):-
    open(File,read,In),
    read_string(In, "", "", End, String).

parse_from_file(SourceFile):-
    read(SourceFile,_,CodeAsOneBigString),
    write(CodeAsOneBigString),nl,
    parse_from_string(CodeAsOneBigString).


parse_from_string(SourceCode):-
    atom_chars(SourceCode, TokenList) ,
    % while_stmt(TokenList,[]),
    stmts(TokenList,[]) ,
    write("syntax free"), 
    ! ;
    write("syntax error"),!.


stmt --> skip , assignment_stmt ,skip,!|skip,define_stmt,skip, !|skip,break_stmt,skip, !|skip,switch_case_stmt,skip,!| skip,if_stmt,skip,!|skip, while_stmt ,skip,!| skip,for_stmt, skip,!|skip , do_while_stmt ,skip,!|skip , open_curlybracket ,skip, stmts ,skip,  close_curlybracket,skip , !.
stmts --> skip ,stmt , skip ,stmts,skip | [] ,!.

assignment_stmt --> assignment_exp, skip , semicolon_op , skip ,!|skip ,  postfix_exp , skip , semicolon_op , skip,! |skip ,  prefix_exp , skip , semicolon_op , skip ,!.

assignment_exp --> id ,skip, assignment_op ,skip, (exp|postfix_exp|prefix_exp|string) ,skip,!.
postfix_exp --> id ,increment_decrease_op , skip ,!.
prefix_exp --> increment_decrease_op , id , skip,!.








define_stmt --> skip,data_type ,skip_space, id ,skip,semicolon_op,skip ,!.
%to define var with value e.g string x = "agmay";
define_stmt --> skip,(int_keyword|long_keyword|short_keyword) ,skip_space, id ,skip,assignment_op,skip,digits,skip,semicolon_op,skip ,!.
define_stmt --> skip,(double_keyword|float_keyword) ,skip_space, id ,skip,assignment_op,skip,digits,.,digits,skip,semicolon_op,skip ,!.
define_stmt --> skip,string_keyword ,skip_space, id ,skip,assignment_op,skip,string,skip,semicolon_op,skip ,!.
define_stmt --> skip,char_keyword ,skip_space, id ,skip,assignment_op,skip,quote,letter,quote,skip,semicolon_op,skip ,!.




%to define more than var with same datatype e.g int x,y,a;
define_stmt --> skip,data_type ,skip_space, id, followed_ids,skip,semicolon_op,skip ,!.
followed_id-->skip,comma,skip,id,skip.
followed_ids-->skip ,followed_id , skip ,followed_ids,skip | [] ,!.

data_type --> int_keyword | double_keyword | float_keyword | string_keyword |char_keyword |long_keyword |short_keyword.


if_stmt --> skip , if_keyword  , skip ,stmt_condition, skip , stmt, skip  , opt_stmts,!.
else_stmt-->skip, else_keyword , required_space , skip ,stmt , skip ,!.
else_stmt-->skip, else_keyword ,skip,open_curlybracket,skip,stmt,skip,close_curlybracket, skip , !.
else_if_stmt --> skip , else_keyword ,required_space, skip , if_stmt ,skip,! .
opt_stmts --> skip , (else_stmt|else_if_stmt), skip , opt_stmts ,!| [] ,!.

while_stmt --> skip , while_keyword ,skip , stmt_condition ,skip , stmt, skip , !.
for_stmt --> skip , for_keyword , skip,for_condition ,skip, stmt,skip ,!.
do_while_stmt --> skip,do_keyword , skip,stmt ,skip, while_keyword , skip,stmt_condition ,skip, semicolon_op,skip ,!.

switch_case_stmt --> skip , switch_keyword , switch_case_condition , skip , switch_body , skip,!.
switch_body --> skip,open_curlybracket,skip,case_stmts ,skip,(default_stmt|[]), skip,close_curlybracket , !.
case_stmt --> skip , case_keyword ,required_space, skip, (string|digits) , skip, double_douts ,skip , stmts , skip , (break_stmt|[]), skip ,!.
break_stmt -->skip,break_keyword,skip,semicolon_op ,!.
default_stmt--> skip , default_keyword , skip , double_douts , skip , stmts , skip , (break_stmt|[]), skip ,!.
case_stmts --> skip,case_stmt , skip , case_stmts , skip , ! | [] , !.

condition --> skip,factor,skip,relational_op,skip,factor,skip|skip,open_parenthesis,condition,close_parenthesis,skip,logical_op,skip,open_parenthesis,condition,close_parenthesis,skip.
stmt_condition --> skip,open_parenthesis ,skip,condition ,skip, close_parenthesis,skip .
for_condition --> skip,open_parenthesis,skip,(assignment_exp | [] ),skip,semicolon_op,skip,condition,skip,semicolon_op,skip,( postfix_exp | prefix_exp|[]),skip,close_parenthesis,skip.
switch_case_condition --> skip,open_parenthesis,skip,id,skip,close_parenthesis.

exp --> term , skip, rest .
rest --> skip , plus_minus_op , skip , term ,skip, rest ; [] . 
 
term --> factor ,skip , rest1 , skip .
rest1 --> skip , multiplication_division_op ,skip, term ,skip, rest1 ,skip ; [] .

factor --> skip,digits,skip | skip,id,skip | skip,open_parenthesis,skip,exp,skip,close_parenthesis,skip .

% means there are zero or more spaces
skip -->  ([' '];['\t'];['\n'];['\r']), skip ; [] .
% required space between parts of the language
required_space --> [' '].

%  means there are atleast one or more spaces
skip_space -->([' '];['\t'];['\n'];['\r']), skip ; [' '] .


% terminals 

digit --> ['0'];['1'];['2'];['3'];['4'];['5'];['6'];['7'];['8'];['9'].
digits --> digit, digits ; digit .

letter --> ['a'];['b'];['c'];['d'];['e'];['f'];['g'];['h'];['i'];['j'];['k'];['l'];['m'];['n'];['o'];['p'];['q'];['r'];['s'];['t'];['u'];['v'];['w'];['x'];['y'];['z'].
letter --> ['A'];['B'];['C'];['D'];['E'];['F'];['G'];['H'];['I'];['J'];['K'];['L'];['M'];['N'];['O'];['P'];['Q'];['R'];['S'];['T'];['U'];['V'];['W'];['X'];['Y'];['Z'].
letter_or_digit --> letter ; digit .
zero_or_more_letter_or_digit --> letter_or_digit , zero_or_more_letter_or_digit ; [] . 
id --> letter , zero_or_more_letter_or_digit .
id -->letter , zero_or_more_letter_or_digit ,open_squarebracket,digits,close_squarebracket.
string --> quote,(id|digits) , quote .    

% operators
plus_minus_op --> [+];[-].
multiplication_division_op --> [*] | [/] | ['%'].  

relational_op --> [>,=] ; [<,=] ; [<] ; [>] ; [=,=] ; [!,=].
logical_op --> ['&','&'] | ['|','|'] . 

assignment_op --> [=] .
increment_decrease_op --> ['+','+'] | ['-','-']. 

semicolon_op --> [;] .

% used symbols
open_parenthesis --> ['('].
close_parenthesis --> [')'] .
open_curlybracket -->['{'].
close_curlybracket --> ['}'].
open_squarebracket -->['['].
close_squarebracket --> [']'].
double_douts --> [':'].
dot --> ['.'].
comma --> [','].
cout_op -->['<','<'].
quote -->['"']|['\''].

% key words 
if_keyword --> ['i','f'].
else_keyword --> ['e','l','s','e'].
while_keyword --> ['w','h','i','l','e'] .
for_keyword --> ['f','o','r'].
do_keyword --> ['d','o'].
switch_keyword -->['s','w','i','t','c','h'].
case_keyword -->['c','a','s','e'].
print_keyword --> ['c','o','u','t'].
break_keyword --> ['b','r','e','a','k'].
default_keyword -->['d','e','f','a','u','l','t'].
int_keyword --> ['i','n','t'].
double_keyword --> ['d','o','u','b','l','e'].
float_keyword --> ['f','l','o','a','t'].
string_keyword --> ['s','t','r','i','n','g'].
char_keyword --> ['c','h','a','r'].
long_keyword -->['l','o','n','g'].
short_keyword-->['s','h','o','r','t'].
