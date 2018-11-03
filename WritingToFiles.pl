


write_file():-
    open('TestFile', append, Stream) ,
    write(Stream,'Welcom to Prolog'),
    nl(Stream),
    close(Stream).


