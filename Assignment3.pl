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

swap([],[]).
swap([X],[X]).
swap([A,B|R], M) :- M=[B,A|S], swap(R,S).


/*
 Quesiton 3
 rmDup(+L, -R)
 where L is a list of atoms and R is the same as L except duplicated elements are removed.
*/

rmDup([], []).
rmDup([H|T],L):- member(H,T),!,rmDup(T,L).
rmDup([H|T],[H|L]):- rmDup(T,L).



/*
 Question 4
 if A is larger than Current, A becomes the new Currenth
 otherwise Current remains the same
 if A is smaller than Current, A becomes the new Current
 otherwise Current remains the same
*/

largest([A | Rest], N) :- largest_helper(Rest, N, A).

largest_helper([], Out, Out).
largest_helper([A | Rest], Out, Current) :- A > Current, largest_helper(Rest, Out, A).
largest_helper([A | Rest], Out, Current) :- largest_helper(Rest, Out, Current).

smallest([A | Rest], N) :- smallest_helper(Rest, N, A).

smallest_helper([], Out, Out).
smallest_helper([A | Rest], Out, Current) :- A < Current, smallest_helper(Rest, Out, A).
smallest_helper([A | Rest], Out, Current) :- smallest_helper(Rest, Out, Current).




/*
 Question 5
*/

countAll([],_,0).
countAll([E|Rest],E,N) :- countAll(Rest,E,N1), N is N1 + 1.
countAll([X|Rest],E,N) :- X \= E, is_list(X),
                          countAll(X, E, N1),
                          countAll(Rest, E, N2), N is N1+N2.
countAll([X|Rest],E,N) :- X \= E, not(is_list(X)), countAll(Rest, E, N).
