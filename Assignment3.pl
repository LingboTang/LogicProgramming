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
 rmAllDup(+L,-R)
 where L is a nested list and R is the list with Duplication removed results. But this time,
 I want to maintain the pattern and order of the original list.
*/

rmDup([], []).
rmDup([H|T],L):- member(H,T),!,rmDup(T,L).
rmDup([H|T],[H|L]):- rmDup(T,L).


% flatten (L, L1): flatten a list f atoms (atoms and numbers) L to
% a flat list L
% This is code is from class note.


flat([],[]).
flat([[]|L],L1) :- flat(L,L1).
flat([[A|L]|W],R) :- flat([A|L],U), flat(W,W1), append(U,W1,R).
flat([A|L], [A|L1]) :- flat(L,L1).


% Now let us flatten all the list pattern, and use rmAllDup to
% rm duplications for all the list, so that after recursion we 
% can still maintain the original pattern and order.

rmAllDup(L,R) :- getridDup(L,[],R).

getridDup([],_,[]).
getridDup([A|L],S,[A|R]) :- atom(A), \+ member(A,S), getridDup(L,[A|S],R).
getridDup([A|L],S,R) :- atom(A),member(A,S),getridDup(L,S,R).
getridDup([A|L],S,[LA|R]) :- getridDup(A,S,LA), flat(A,FA),append(FA,S,S1), getridDup(L,S1,R). 



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

generate([A],_,B).
generate(L,Choice,N) :- Choice == smallest, flat(L,K), smallest(K,N).
generate(L,Choice,N) :- Choice == largest, flat(L,K), largest(K,N).



/*
 Question 5
*/

countt(_,[],0).
countt(A,[A|L],N):- !,countt(A,L,N1),N is N1+1.
countt(A,[B|L],N):- is_list(B),countt(A,L,N),!.
countt(A,[B|L],N):- countt(A,B,N1),countt(A,L,N2),N is N1+N2.


% is_list from http://www.swi-prolog.org/pldoc/man?predicate=is_list/1

is_list(X) :-
        var(X), !,
        fail.
is_list([]).
is_list([_|T]) :-
        is_list(T).



/*
 Question 6
*/
