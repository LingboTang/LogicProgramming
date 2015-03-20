sum([],0).
sum([A|L],S) :- number(A),sum(L,S1), S is A+S1.
sum([A|L],S) :- sum(A,S1), sum(L,S2).
