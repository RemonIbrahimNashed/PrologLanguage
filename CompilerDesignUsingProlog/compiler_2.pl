
parse_from_file(SourceFile):-
    read(SourceFile,_,CodeAsOneBigString),
    % write(CodeAsOneBigString),nl,
    parse_from_string(CodeAsOneBigString).

%read the source code file as one string
read(File,End,String):-
    open(File,read,In),
    read_string(In, "", "", End, String).

parse_from_string(SourceCode):-
    atom_chars(SourceCode, TokenList) ,
    sourcefile_content(TokenList,[]) ,
    write("syntax free"), 
    ! ;
    write("syntax error"),!.




sourcefile_content --> (global_stmts|[]),functions , !| [] .


global_stmts --> skip,global_stmt,skip,global_stmts,skip,! | [] .
global_stmt --> include_stmt,!|hash_define_stmt,!|function_header,!|define_stmt,!.

% include_stmts --> skip,include_stmt , skip , include_stmts ,skip| [].
include_stmt --> skip,hash,include_keyword,required_space,skip,((open_anglebracket,header_file,close_anglebracket)|header_file_string),skip,!.
header_file --> id,dot,['h'],!.
header_file_string --> quote,header_file,quote.

hash_define_stmt --> skip,hash,define_keyword,required_space,skip,id,required_space,skip, (string|decimal), skip ,!. 

% functions_header --> function_header,functions_header ,skip ,!| [] .
function_header -->  skip,((data_type|void_keyword),required_space,skip |[]),id, skip,open_parenthesis,skip,(argument_list|argument),close_parenthesis,skip,semicolon_op,skip,!.

functions --> skip,function,skip,functions,skip,!| [] .
function --> return_type ,function_name,parameters,body,!.
return_type -->skip,((data_type|void_keyword),required_space,skip |[]),!. 
function_name --> id,skip,!.
parameters --> open_parenthesis,skip,(argument_list|argument),close_parenthesis,skip,!.
body --> open_curlybracket,skip,stmts,skip,close_curlybracket,skip,!.


argument--> skip,data_type,required_space,skip,id,skip .
argument_list--> skip ,argument ,skip, comma ,argument_list ,skip; [] .   

data_type --> int_keyword | double_keyword | float_keyword | string_keyword | char_keyword |long_keyword |short_keyword.

stmts --> skip ,stmt , skip ,stmts,skip | [] ,!.
stmt -->skip,(assignment_stmt|define_stmt|if_stmt|switch_case_stmt|while_stmt|for_stmt|do_while_stmt|break_stmt|continue_stmt|return_stmt|pointer_stmt|body),skip,!.

%to define var with datatype e.g float x;
define_stmt --> skip,data_type ,required_space,skip,((id ,skip,semicolon_op)|assignment_stmt) ,skip ,! .
%to define more than var with same datatype e.g int x,y,a;
define_stmt --> skip,data_type ,required_space,skip, id, (followed_ids|[]),skip,semicolon_op,skip ,!.
followed_ids-->skip ,followed_id , skip ,followed_ids,skip | [] ,!.
followed_id-->skip,comma,skip,id,skip.

assignment_stmt --> skip,(assignment_exp|postfix_exp|prefix_exp),skip,semicolon_op,skip,!.

assignment_exp --> id ,skip, assignment_op ,skip, (exp|postfix_exp|prefix_exp|string) ,skip,!.
postfix_exp --> id ,increment_decrease_op , skip ,!.
prefix_exp --> increment_decrease_op , id , skip,!.

%int *x ; 
pointer_stmt --> skip ,(data_type|void_keyword),skip,astrik,id,skip,semicolon_op,!.
% int*  x;
pointer_stmt --> skip ,(data_type|void_keyword),astrik,skip,id,skip,semicolon_op,!.



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
case_stmt --> skip,case_keyword,required_space,skip,(string|decimal),skip,double_douts,skip,stmts,skip,(break_stmt|[]),skip,!.
break_stmt -->skip,break_keyword,skip,semicolon_op ,!.
default_stmt--> skip,default_keyword,skip,double_douts,skip,stmts,skip,(break_stmt|[]),skip,!.
case_stmts --> skip,case_stmt,skip,case_stmts,skip,!|[],!.

return_stmt --> skip,return_keyword,skip,semicolon_op ,!.
continue_stmt --> skip,continue_keyword,skip,semicolon_op ,!.

condition1 --> skip,factor,skip,relational_op,skip,factor,skip,!.
inner_condition --> skip,open_parenthesis,(condition1|condition2),close_parenthesis,skip,!.
condition2 -->  inner_condition , logical_op , inner_condition ,! .
condition --> (condition1|condition2),!.

stmt_condition --> skip,open_parenthesis ,skip,condition ,skip, close_parenthesis,skip .
for_condition --> skip,open_parenthesis,skip,(assignment_exp | [] ),skip,semicolon_op,skip,(condition|[]),skip,semicolon_op,skip,( assignment_exp|postfix_exp | prefix_exp|[]),skip,close_parenthesis,skip.
switch_case_condition --> skip,open_parenthesis,skip,id,skip,close_parenthesis.

% comment_stmt --> skip,forward_slash,astrik,skip,stmts,skip,astrik,forward_slash,skip,!.

exp --> term , skip, rest .
rest --> skip , plus_minus_op , skip , term ,skip, rest ; [] . 
 
term --> factor ,skip , rest1 , skip .
rest1 --> skip , multiplication_division_op ,skip, term ,skip, rest1 ,skip ; [] .

factor --> skip,decimal,skip | skip,id,skip | skip,open_parenthesis,skip,exp,skip,close_parenthesis,skip .

% means there are zero or more spaces
skip -->  ([' '];['\t'];['\n'];['\r']), skip ; [] .
% required space between parts of the language
required_space --> [' '].

% terminals 

digit --> ['0'];['1'];['2'];['3'];['4'];['5'];['6'];['7'];['8'];['9'].
digits -->  digit, digits; digit.
decimal --> (digit , (digits|[]) ,dot , digits) | digits.


letter --> ['a'];['b'];['c'];['d'];['e'];['f'];['g'];['h'];['i'];['j'];['k'];['l'];['m'];['n'];['o'];['p'];['q'];['r'];['s'];['t'];['u'];['v'];['w'];['x'];['y'];['z'].
letter --> ['A'];['B'];['C'];['D'];['E'];['F'];['G'];['H'];['I'];['J'];['K'];['L'];['M'];['N'];['O'];['P'];['Q'];['R'];['S'];['T'];['U'];['V'];['W'];['X'];['Y'];['Z'].
letter_or_digit --> letter ; digit .
zero_or_more_letter_or_digit --> letter_or_digit , zero_or_more_letter_or_digit ; [] . 

id2 --> letter , zero_or_more_letter_or_digit .
id --> id2 ; id2, open_squarebracket,digits,close_squarebracket.

string --> quote,(id|decimal) , quote .    

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
cout_op -->['<','<'].
quote -->['"']|['\''].
dot -->['.'].
comma --> [','].
open_anglebracket -->['<'].
close_anglebracket --> ['>'].
hash -->['#'].
astrik -->['*'].
forward_slash -->['/'].
backward_slash -->['\\'].
double_forward_slash -->['/','/'].


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
main_keyword -->['m','a','i','n'].
include_keyword --> ['i','n','c','l','u','d','e'].
define_keyword --> ['d','e','f','i','n','e'].
return_keyword --> ['r','e','t','u','r','n'].
continue_keyword --> ['c','o','n','t','i','n','u','e'].
% data types
int_keyword --> ['i','n','t'].
double_keyword --> ['d','o','u','b','l','e'].
float_keyword --> ['f','l','o','a','t'].
string_keyword --> ['s','t','r','i','n','g'].
char_keyword --> ['c','h','a','r'].
long_keyword -->['l','o','n','g'].
short_keyword-->['s','h','o','r','t'].
void_keyword -->['v','o','i','d'].

start:-
    parse_from_file('source_file.txt').