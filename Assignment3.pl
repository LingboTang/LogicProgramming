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
swap([], []).
swap([A],[A]).
swap(A, B) :-
    append([First | Mid], [Last], A),
    append([Last | Mid], [First], B).



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