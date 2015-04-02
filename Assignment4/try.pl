:- use_module(library(clpfd)). 

solve(N,S) :-
    S = [C0,C1,C2,N1,N2],       % Let S be bound to a list of five variables
    domain(S,0,N),
    N #= C0 + C1*N1 + C2*N2*N2.
    % labeling([],S).

room(r1).
room(r2).

findall(Room,(room(Room)),L).
length([r1,r2],Len).
