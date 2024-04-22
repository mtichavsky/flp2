/** Read line from stdout */
read_line(L,C) :-
	get_char(C),
	(isEOFEOL(C), L = [], !;
		read_line(LL,_), % atom_codes(C,[Cd]),
		[C|LL] = L).


/** Test for EOF or LF */
isEOFEOL(C) :-
	C == end_of_file;
	(char_code(C,Code), Code==10).


/** Read lines from stdout */
read_lines(Ls) :-
	read_line(L,C),
	( C == end_of_file, Ls = [] ;
	  read_lines(LLs), Ls = [L|LLs]
	).


start :-
		prompt(_, ''),
		read_lines(LL),
		write(LL),
		halt.

