/*
 Course: CMPUT325
 Prof: You
 Student: Lingbo Tang
*/


/*
 Question 1
 setUnion(+S1, +S2, -S3)
 Given two lists S1 and S2, setUnion returns the union of 
 those two lists in S3
*/
setUnion([], S3, S3).
% if A is a member of S2, ignore it
setUnion([A | Rest], S2, S3) :- member(A, S2), setUnion(Rest, S2, S3).
% otherwise append it to the result
setUnion([A | Rest], S2, [A | S3]) :- setUnion(Rest, S2, S3).



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