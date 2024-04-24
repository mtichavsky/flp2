/** FLP: 2nd project
 *  Author: Milan Tichavský <xticha09>
 */

:- dynamic edges/1.
:- dynamic visited/1.
:- dynamic start/1.
:- dynamic points/1.
:- dynamic paths/1.

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

/** Ignoring starting point in here */
visited_all([_|Points]) :-
	findall(X, visited(X), Visited),
	sort(Visited, VisitedSorted),
	%write(VisitedSorted == Points + "\n"),
	VisitedSorted == Points.

add_edges([]) :- !.
add_edges([H|L]) :-
	assert(edges(H)), add_edges(L).

get_points(Sorted) :-
	findall(X, edges([X, _]), Res),
	findall(Z, edges([_, Z]), Res2),
	append(Res, Res2, New),
	sort(New, Sorted).


%findall(X, visited(X), Res),
%findall(X, edges(["a", X]), Res),
next_step(From, To) :-
	(edges([From, To]) ; edges([To, From])), not(visited(To)).


% TODO From variable could be omitted
perform_step(From, To, Points, Path) :-
	start(To),
	visited_all(Points),
	sort([From, To], Edge),
	sort([Edge|Path], SortedPath),
	not(paths(SortedPath)),
	assert(paths(SortedPath)).
perform_step(From, To, Points, Path) :-
	assert(visited(To)),
	sort([From, To], Edge),
	run(To, Points, [Edge|Path]).
perform_step(_, To, _, _) :-
	retract(visited(To)), !, fail.


run(From, Points, Path) :-
	next_step(From, To),
	perform_step(From, To, Points, Path).
run(_, _, _). % nowhere to go

print_results2([[L, R]]) :-
	string_upper(L, L_out), string_upper(R, R_out),
	write(L_out), write("-"), write(R_out).
print_results2([[L, R]|T]) :-
	string_upper(L, L_out), string_upper(R, R_out),
	write(L_out), write("-"), write(R_out), write(" "),
	print_results2(T).


print_results([]).
print_results([H|T]) :-
	print_results2(H),
	write("\n"),
	print_results(T).

main :-
	prompt(_, ''),
	read_lines(Lines),
	add_edges(Lines),
	get_points(Points),
	get_start(Lines, Start),
	assert(start(Start)),
	findall(X, run(Start, Points, []), _),
	findall(X, paths(X), Paths),
	print_results(Paths),
	halt.
