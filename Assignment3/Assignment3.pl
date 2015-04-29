/*--------------------
 Course: CMPUT325
 Prof: You
 Student: Lingbo Tang
----------------------*/

/*-----------------------------------------------------------------
  Never forget to cut off it you want to get rid of the duplication
------------------------------------------------------------------*/


/*-----------------------------------------------------------------
 Question 1
 setDifference(+S1, +S2, -S3)
 Given two lists S1 and S2, setDifference returns the difference of 
 those two lists in S3.
 Test case:
	setDifference([a,b,f,c,d],[e,b,a,c],S). => S = [f,d]
------------------------------------------------------------------*/

% Base case.

setDifference([],B,[]).

% When A is in B, remove it from the first list.

% You can ignore the cut off,but it is safe

setDifference([A|R],B,C) :- check_in(A,B),!,setDifference(R,B,C).

% Then, run the recursion if A is not in B

setDifference([A|R],B,[A|C]) :- setDifference(R,B,C).

% Check if the A is in the B, actually it is a built-in function
% But I do not know if we can use it directly.

check_in(A,[A|_]).
check_in(A,[_|B]):- member(A,B).

/*----------------------------------------------------------------
 Question 2
 swap(+S1,+S2)
 Given two sets S1 and S2, swap returns the
 swapped sets of the near by two elements in the lists.
 If the size of the sets is odd, it will hold the last position.
 Test case:
	swap([a,1,b,2], W). => W = [1,a,2,b]
-----------------------------------------------------------------*/


% Initial condition is both of the
% sets have the same order of elements
% or empty

swap([],[]).
swap([X],[X]).
swap([A,B|R], M) :- M=[B,A|S],swap(R,S).


/*--------------------------------------------------------------
 Quesiton 3a
 rmDup(+L, -R)
 Given list L, rmDup returns the list which all the unnested 
 duplication are removed.
 Test case:
	rmDup([t, u, o, i, g, h, r, r, g, t, o, a], W).
      => W =  [u,i,h,r,g,t,o,a]
---------------------------------------------------------------*/

rmDup([], []).

% If first element is in the rest of the list, remove it.
rmDup([A|B],L) :- check_in(A,B),!,rmDup(B,L).

% If not, check the second element.
rmDup([A|B],[A|L]) :- rmDup(B,L).


/*--------------------------------------------------------------
 Quesiton 3b
 rmAllDup(+L, -R)
 Given list L, rmAllDup returns the list which all duplication are 
 removed.
 Test case:
	rmAllDup([a,[b,c],c,[a,d,a]], W). => W = [a,[b,c],[d]]
---------------------------------------------------------------*/

% Now let us flatten all the list pattern, and use rmAllDup to
% rm duplications for all the list, so that after recursion we 
% can still maintain the original pattern and order.

rmAllDup(L,R) :- getridDup(L,[],R).

% Actually this is the hardest question, so I would like to explain clear.
% Base case is, given any of the atom we want to rm duplicates, empty list
% will always give nothing.

getridDup([],_,[]).

% If A is not a list, great, we can check if it is inside the rest of the list.
% and replace A by the second car of the cdr list. M is the rest of the list.
% [A|M] will check all A in M recursively.

getridDup([A|L],M,[A|R]) :- \+ is_list(A), \+ check_in(A,M),!,getridDup(L,[A|M],R).

% If A is not a list, but still not inside the rest of the list, we want to find the
% next atom we want to remove the dup.

getridDup([A|L],M,R) :- \+ is_list(A), !,getridDup(L,M,R).

% If A is a list, we want to remove the "list A" at first, and then append the flattened
% result in to the original list, this can hold the initial position and intial level of nest.
% This is the most difficult part.

getridDup([A|L],M,[B|R]) :- is_list(A), getridDup(A,M,B),hold_order(A,M,G), !,getridDup(L,G,R).


hold_order([],L,[]).
hold_order(A,M,G) :- flat(A,K),append(K,M,G).



% flat (L, L1): flatten a list f atoms (atoms and numbers) L to
% a flat list L
% This is code is from class note.

flat([],[]).
flat([[]|L],L1) :- flat(L,L1).
flat([[A|L]|W],R) :- flat([A|L],U), flat(W,W1), append(U,W1,R).
flat([A|L], [A|L1]) :- flat(L,L1).

% is_list from http://www.swi-prolog.org/pldoc/man?predicate=is_list/1

is_list(X) :- var(X), !, fail.
is_list([]).
is_list([_|T]) :- is_list(T).


/*---------------------------------------------------------
 Question 4
 generate(+L,+Choice, -N)
 Given the list of L, given a choice of "smallest" or 
 "largest", generate returns the smallest or largest value
 in the list.
 If A is larger than Current, A becomes the new Currenth
 otherwise Current remains the same
 The swap is the same with the
 Test case:
	generate([3,4,[5,2],[1,7,2]],smallest,N). => N = 1
	generate([3,4,[5,2],[1,7,2]],largest,N). => N = 7
----------------------------------------------------------*/

largest([A|R], N) :- find_largest(R, N, A).
find_largest([], L, L).
find_largest([A|R], L, C) :- A > C, find_largest(R, L, A).
find_largest([A|R], L, C) :- find_largest(R, L, C).

smallest([A|R], N) :- find_smallest(R, N, A).
find_smallest([], L, L).
find_smallest([A|R], L, C) :- A < C, find_smallest(R, L, A).
find_smallest([A|R], L, C) :- find_smallest(R, L, C).

generate([A],_,B).
generate(L,Choice,N) :- Choice == smallest, flat(L,K), smallest(K,N),!.
generate(L,Choice,N) :- Choice == largest, flat(L,K), largest(K,N),!.



/*-------------------------------------------------------------
 Question 5
 countAll(+L,-N)
 Given a list L, countAll will return the number
 of occurrence of the elements in the list. This
 list will be sorted with largest ---> smallest
 order.

 Test case:
	countAll([a,b,[e,c],c,[b]],N). => 
	N = [[b,2],[c 2],[a,1],[e,1]]
-------------------------------------------------------------*/
countAll([],[]).
countAll(L,R) :- flat(L,U),rmDup(U,G),form_pair(G,U,I),insert_sort(I,Q),!,reverse_it(Q,R).

% Form the pair, with [character,number] pattern.

form_pair([],L,[]).
form_pair([A|P],L,[[A,N]|R]) :- counter(A,L,N),form_pair(P,L,R).

% Given a list and a certain atom, find the count of the atom in the list.

counter(_,[],0).
counter(A,[A|L],N):- flat(L,K),!,counter(A,K,N1),N is N1+1.
counter(A,[_|L],N):- flat(L,K),counter(A,K,N). 

% Sort the result counter, this function is to sort the result returned
% from counter.
% This predicate is from 325 TA help session.
% However, I changed it to a predicate that can deal with the [character,number]
% pair in the end, so it will be more suitable in this question.

insert_sort(List,Sorted):-i_sort(List,[],Sorted).
i_sort([],Acc,Acc).
i_sort([H|T],Acc,Sorted):-insert(H,Acc,NAcc),i_sort(T,NAcc,Sorted).
insert([O1,X],[[O2,Y]|T],[[O2,Y]|NT]):-X>Y,insert([O1,X],T,NT).
insert([O1,X],[[O2,Y]|T],[[O1,X],[O2,Y]|T]):-X=<Y.
insert([O1,X],[],[[O1,X]]).

% The sorted list is in the order of smallest ---> largest
% Therefore, we need a reverse_it function to turn the order around.

reverse_it([],[]).
reverse_it([H|T],L):- reverse_it(T,R),append(R,[H],L).

/*---------------------------------------------------------------
 Question 6
 convert(+Term,-Result)
 Given a list of Term,convert will return a list such that:
 1. if e is between two q, keep it.
 2. if e is outside q, remove it.
 3. if the atom is not e or q, then replace it by c
 4. if the atom is between two q, then keep it
 5. it will keep all q.
 Acutually, I found it's kind of hard at first, but when I
 figure out how append(L1,[q|L2],L) works, it becomes pretty
 easy.
 Test case:
	convert([a,q,e,l,q,r,e,q,b,e],R).
    => R = [c,q,e,l,q,c,q,c]
---------------------------------------------------------------*/

% convert them, but we still need to flat the list.

convert(L,R) :- convert_pre(L,n,K),flat(K,R),!.


% append(L1,[q|L2],L),will split the list L1 before the q
% and the list L2 after the q, and then append them in to L
% So, we can use this property to get rid of all e in L1, and
% do it recursively in L2. However, it's risky, so we need a lock
% when we find the odd number of q, unlock it, when we find the 
% even number of q, lock it.

convert_pre([],n,[]).
convert_pre(L,Flag,K) :- \+member(q,L),removeE(L,K).
convert_pre(L,Flag,[K,q|R]) :- append(L1,[q|L2],L), Flag == n, removeE(L1,K),convert_pre(L2,y,R).
convert_pre(L,Flag,[L1,q|R]) :- append(L1,[q|L2],L), Flag == y,convert_pre(L2,n,R).


% Remove e is easy..
removeE([],[]).
removeE([H|T],R) :- H==e,removeE(T,R).
removeE([H|T],[C|R]) :- C = c,removeE(T,R).


/**************************End of file**************************************/
