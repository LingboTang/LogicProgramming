/*
 Course: CMPUT325
 Prof: You
 Student: Lingbo Tang
*/


/*
 Question 1
 setDifference(+S1, +S2, -S3)
 Given two lists S1 and S2, setUnion returns the union of 
 those two lists in S3
*/
setDifference([],Y,[]).
   setDifference([X|R],Y,Z) :- member(X,Y),!,setDifference(R,Y,Z).
   setDifference([X|R],Y,[X|Z]) :- setDifference(R,Y,Z).


/*
 Question 2
 swap(+S1,+S2)
 Given two sets S1 and S2, swap returns the
 swapped sets at certain points in the lists
*/


% Initial condition is both of the
% sets have the same order of elements
% or empty
swap([X],[X]).
swap([],[]).
swap([A,B|R], M) :- M=[B,A|S], swap(R,S).


/*
 Quesiton 3
 rmDup(+L, -R)
 where L is a list of atoms and R is the same as L except duplicated elements are removed.
*/

rmDup([],[]).
rmDup([X],[X]).
rmDup([X,X|Rest],Rest2) :- 
    rmDup([X|Rest],Rest2).
    rmDup([X,Y|Rest],[X|Rest2]) :- X \= Y, rmDup([Y|Rest],Rest2).


/*
 Question 4
*/

largest([A | Rest], N) :- largest_helper(Rest, N, A).

largest_helper([], Out, Out).
% if A is larger than Current, A becomes the new Current
largest_helper([A | Rest], Out, Current) :- 
	A > Current, largest_helper(Rest, Out, A).
% otherwise Current remains the same
largest_helper([A | Rest], Out, Current) :- 
	largest_helper(Rest, Out, Current).

smallest([A | Rest], N) :-smallest_helper(Rest,N,A).

smallest_helper([],out,out).
% if A is smaller than Current, A becomes the new Current
smallest_helper([A | Rest],out,current) :-
	A < Current, smallest_helper(Rest,out,A).
% otherwise Current remains the same
smallest_helper([A | Rest], out, current) :-
	smallest_helper(Rest,out,current).




/*
 Question 5
*/

countAll([],_,0).
countAll([E|Rest],E,N) :- countAll(Rest,E,N1), N is N1 + 1.
countAll([X|Rest],E,N) :- X \= E, is_list(X),
                          countAll(X, E, N1),
                          countAll(Rest, E, N2), N is N1+N2.
countAll([X|Rest],E,N) :- X \= E, not(is_list(X)), countAll(Rest, E, N).
