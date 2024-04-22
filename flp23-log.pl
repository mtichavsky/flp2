:- dynamic edges/1.
:- dynamic visited/1.

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

transform([H,_,H3|_], [H_out, H3_out]) :-
	string_lower(H, H_out), string_lower(H3, H3_out). 

/** Read lines from stdout */
read_lines(Ls) :-
	read_line(L,C),
	( C == end_of_file, Ls = [] ;
	  read_lines(LLs), transform(L, TLine),  Ls = [TLine|LLs]
	).

get_start([[H1,_]| _], H1).

add_edges([]) :- !.
add_edges([H|L]) :-
	assert(edges(H)), add_edges(L).


% findall(X, edges(["a", X]), Res),
next_step(From, To) :-
	(edges([From, To]) ; edges([To, From])), not(visited(To)).

run(Lines) :-
	get_start(Lines, Start),
	next_step(Start, _).

start :-
	prompt(_, ''),
	read_lines(Lines),
	add_edges(Lines),
	run(Lines),
	write(Lines),
	halt.

