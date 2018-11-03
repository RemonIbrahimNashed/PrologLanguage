


write_on_file(File ,Text):-
    open(File, append, Stream) ,
    write(Stream,Text),
    nl(Stream),
    close(Stream).

read_from_file(File):-
    open(File,read,Stream),
    get_char(Stream, Char1),
    process_the_stream(Char1,Stream),
    close(Stream).
process_the_stream(end_of_file , _ ) :- ! .
process_the_stream(Char,Stream):-
    write(Char),
    get_char(Stream,Char2),
    process_the_stream(Char2,Stream).

    


