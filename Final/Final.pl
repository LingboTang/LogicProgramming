r(e, L).
r(c(X,L1),c(X,L2)) :- r(L1,L2).
q(L1,L2) :- r(L1,L2).
q(L1,c(Y,L2)) :- q(L1,L2).
