xmember(A,[A|_]) :- !.
xmember(A,[B|L]) :-xmember(A,L).

rm(_,[],[]).
rm(A,[A|L],R) :- !, rm(A,L,R).
rm(A,[B|L],[B|R]) :- rm(A,L,R).

r(W) :- rm(a,[a,b,a,d,a,l],W).

sum([],0).
sum([A|L],S) :- number(A),sum(L,S1),S.
sum([A|L],S) :- atom(A),sum(L,S),!.
sum([A|L],S) :- sum(A,S1),sum(L,S2),S.

i :- consult('Classnote.pl').

t0(I) :- sum([2,3,[5,6],7],I).
t1(I) :- sum([2,3],I).
t2(I) :- sum([2,a,3,[5,b],7,a],I).
t3(I) :- sum([2,[],a,[],3,[5,b,6],7],I).