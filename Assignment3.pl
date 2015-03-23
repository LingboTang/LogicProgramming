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
getridDup([A|L],M,[A|R]) :- \+ is_list(A), \+ member(A,M), getridDup(L,[A|M],R).
getridDup([A|L],M,R) :- \+ is_list(A),member(A,M),getridDup(L,M,R).
getridDup([A|L],M,[B|R]) :- is_list(A), getridDup(A,M,B), flat(A,FA),append(FA,M,S1), getridDup(L,S1,R). 

% is_list from http://www.swi-prolog.org/pldoc/man?predicate=is_list/1

is_list(X) :- var(X), !, fail.
is_list([]).
is_list([_|T]) :- is_list(T).


/*
 Question 4
 if A is larger than Current, A becomes the new Currenth
 otherwise Current remains the same
 if A is smaller than Current, A becomes the new Current
 otherwise Current remains the same
*/

largest([A|R], N) :- find_largest(R, N, A).

find_largest([], Out, Out).
find_largest([A|R], Out, Current) :- A > Current, find_largest(R, Out, A).
find_largest([A|R], Out, Current) :- find_largest(R, Out, Current).

smallest([A|R], N) :- find_smallest(R, N, A).

find_smallest([], Out, Out).
find_smallest([A|R], Out, Current) :- A < Current, find_smallest(R, Out, A).
find_smallest([A|R], Out, Current) :- find_smallest(R, Out, Current).

generate([A],_,B).
generate(L,Choice,N) :- Choice == smallest, flat(L,K), smallest(K,N).
generate(L,Choice,N) :- Choice == largest, flat(L,K), largest(K,N).



/*
 Question 5
*/
countAll([],[]).
countAll(L,R) :- flat(L,FL),rmDup(FL,G),form_pair(G,FL,I),insert_sort(I,Q),my_reverse(Q,R).

form_pair([],L,[]).
form_pair([A|P],L,[[A,N]|R]) :- counter(A,L,N),form_pair(P,L,R).


% This function does the work:
% Given a list and a certain atom, find the count of the atom in the list.

counter(_,[],0).
counter(A,[A|L],N):- flat(L,K),!,counter(A,K,N1),N is N1+1.
counter(A,[_|L],N):- flat(L,K),counter(A,K,N). 

% Sort the result counter, this function is to sort the result returned
% from countt.
% This predicate is from 325 TA help session.

insert_sort(List,Sorted):-i_sort(List,[],Sorted).
i_sort([],Acc,Acc).
i_sort([H|T],Acc,Sorted):-insert(H,Acc,NAcc),i_sort(T,NAcc,Sorted).
insert([O1,X],[[O2,Y]|T],[[O2,Y]|NT]):-X>Y,insert([O1,X],T,NT).
insert([O1,X],[[O2,Y]|T],[[O1,X],[O2,Y]|T]):-X=<Y.
insert([O1,X],[],[[O1,X]]).

my_reverse([],[]).
my_reverse([H|T],L):- my_reverse(T,R),append(R,[H],L).

/*
 Question 6
*/

