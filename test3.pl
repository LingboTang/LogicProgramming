/* Reload the source code quickly. Type "l." to load your changes. */

l :- consult('filename.pl').

 

/*Test cases for question 1*/

 

t1(S) :- setDifference([a,b,f,c,d],[e,b,a,c],S).      % return S=[f,d]

t2(S) :- setDifference([p,u,e,r,k,l,o,a,g],[n,k,e,a,b,u,t],S).      % return S = [p,r,l,o,g]

t3(S) :- setDifference([],[e,b,a,c],S).       % return S = []

 

/*Test cases for question 2*/

 

k1(W) :- swap([a,1,b,2], W).   %return W = [1,a,2,b]

k2(W) :- swap([a,1,b],W).       %return W = [1,a,b]

k3(W) :- swap([a,1,b,2,c],W).  %return W = [1,a,2,b,c]]

k4(W) :- swap([], W).               %return W = []

 

/*Test cases for question 3*/

r1(W) :- rmDup([a,b,c,c,a,d,a], W).                          %return W = [b,c,d,a]

r2(W) :- rmDup([t, u, o, i, g, h, r, r, g, t, o, a], W).    %return W =  [u,i,h,r,g,t,o,a] 

r3(W) :- rmAllDup([a,[b,c],c,[a,d,a]], W).                  %return W = [a,[b,c],[d]]

r4(W) :- rmAllDup([a,[b,c],c,[a,c,e,[a]]], W).             %return W = [a,[b,c],[e,[]]]

r5(W) :- rmAllDup([j,[u],[a,c],c,[j,d,p,[k,u]]], W).        %return W = [j,[u],[a,c],[d,p,[k]]]

 

/*Test cases for question 4*/

g1(N) :- generate([3,4,[5,2],[1,7,2]],smallest,N).                %return N = 1

g2(N) :- generate([8,[6,11],[[5],6],[[9,7],4]],smallest,N).     %return N = 4

g3(N) :- generate([3,4,[5,2],[1,7,2]],largest,N).                   %return N = 7

g4(N) :- generate([8,[6,11],[[5],6],[[9,7],4]],largest,N).         %return N = 11

 

/*Test cases for question 5*/

c1(N) :- countAll([a,b,[e,c],c,[b]],N).                      %return N = [[b,2],[c,2],[a,1],[e,1]]

c2(N) :- countAll([a,b,e,c,c,b], N).                         %return N = [[b,2],[c,2],[a,1],[e,1]]

c3(N) :- countAll([a,b,[c,c],b],N).                           %return N = [[b,2],[c,2],[a,1]]

c4(N) :- countAll([[a],[b,c,[a,d],e,a],[g,z,c],b,a,e],N).      %return N =[[a,4],[b,2],[c,2],[e,2],[g,1],[z,1],[d,1]]

 

/*Test cases for question 6*/

p1(R) :- convert([e,e,a,e,b,e],R).                   %return R = [c,c]

p2(R) :- convert([e,q,a,b,e,e],R).                    %return R = [q,c,c]

p3(R) :- convert([e,a,e,e],R).                           %return R = [c]

p4(R) :- convert([e,q,a,e,b,q,e,a,e],R).            %return R = [q,a,e,b,q,c]

p5(R) :- convert([a,q,e,l,q,r,e,q,b,e],R).           %return R = [c,q,e,l,q,c,q,c]

p6(R) :- convert([q,e,q,b,q,e,l,q,a,e],R).          %return R = [q,e,q,c,q,e,l,q,c]

p7(R) :- convert([q,b,e,d,u,e,a,q,e,q,e],R).       %return R = [q,b,e,d,u,e,a,q,q]

p8(R) :- convert([e,q,b,d,f,a,q,e],R).                %return R = [q,b,d,f,a,q]

p9(R) :- convert([t,i,e,e,c,r,q,e,g,g,q,e,q,e],R).  %return R = [c,c,c,c,q,e,g,g,q,q]

p0(R) :- convert([],R).                                        %return R = []
