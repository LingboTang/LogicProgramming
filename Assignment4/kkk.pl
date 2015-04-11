/********************************************************
 * CMPUT325: Assignment4
 * Prof: You
 * Student: LingboTang
 ********************************************************/

:- use_module(library(clpfd)).
:- use_module(library(lists)).
/********************************************************
 * Question 1
 *  (a) Given data, Define a predicate:
 *	    query1(+Semester, +Name, -Total)
 *		Given a semester and a student name, 
 *		Total should be bound to the total mark, 
 *      in terms of percentage out of 100, 
 *		of the student for that semester.
 *
 *
 ********************************************************/
insert_data :-
    assert(c325(fall_2014,aperf,15,15,15,15,79,99)),
    assert(c325(fall_2014,john,14,13,15,10,76,87)),
    assert(c325(fall_2014,lily, 9,12,14,14,76,92)),
    assert(c325(fall_2014,peter,8,13,12,9,56,58)),
    assert(c325(fall_2014,ann,14,15,15,14,76,95)),
    assert(c325(fall_2014,ken,11,12,13,14,54,87)),
    assert(c325(fall_2014,kris,13,10,9,7,60,80)),
    assert(c325(fall_2014,audrey,10,13,15,11,70,80)),
    assert(c325(fall_2014,randy,14,13,11,9,67,76)),
    assert(c325(fall_2014,david,15,15,11,12,66,76)),
    assert(c325(fall_2014,sam,10,13,10,15,65,67)),
    assert(c325(fall_2014,kim,14,13,12,11,68,78)),
    assert(c325(fall_2014,perf,15,15,15,15,80,100)),
    assert(c325(winter_2014,aperf,15,15,15,15,80,99)),
    assert(setup(fall_2014,as1,15,0.1)),
    assert(setup(fall_2014,as2,15,0.1)),
    assert(setup(fall_2014,as3,15,0.1)),
    assert(setup(fall_2014,as4,15,0.1)),
    assert(setup(fall_2014,midterm,80,0.25)),
    assert(setup(fall_2014,final,100,0.35)).



query1(Semester, Name, Total):-
	c325(Semester,Name,As1,As2,As3,As4,Mid,Final),
	setup(Semester,as1,Grade1,Weight1),
	setup(Semester,as2,Grade2,Weight2),
	setup(Semester,as3,Grade3,Weight3),
	setup(Semester,as4,Grade4,Weight4),
	setup(Semester,midterm,Grade5,Weight5),
	setup(Semester,final,Grade6,Weight6), 
	Total is 100*(As1/Grade1*Weight1+As2/Grade2*Weight2+As3/Grade3*Weight3+As4/Grade4*Weight4+Mid/Grade5*Weight5+Final/Grade6*Weight6),!.

/*****************************************************************************
 * Question 1 
 *   (b)Define a predicate:
 *	query2(+Semester, -L).
 *	Given a semester, find all students whose final exam shows 
 *	an improvement over the midterm, in the sense that the percentage 
 *	obtained from the final is (strictly) better than that of the midterm.
 *****************************************************************************/
	

query2(Semester, L) :-findall(Name, (c325(Semester,Name,As1,As2,As3,As4,Mid,Final),
	setup(Semester,midterm,Grade5,Weight5),
	setup(Semester,final,Grade6,Weight6), 
	Final/Grade6>Mid/Grade5),L),!.

/*************************************************************************************
 * Question 1
 *   (c)Define a predicate:
 *	query3(+Semester,+Name,+Type,+NewMark)
 *	Updates the record of Name for Semester where Type gets NewMark. 
 *	If the record is not in the database, print the message "record not found".
 *************************************************************************************/


query3(S,N,Type,NewMark) :-
	Type==as1,retract(c325(S,N,_,As2,As3,As4,Mid,Final)),!,assert(c325(S,N,NewMark,As2,As3,As4,Mid,Final)).
query3(S,N,Type,NewMark) :-
	Type==as2,retract(c325(S,N,As1,_,As3,As4,Mid,Final)),!,assert(c325(S,N,As1,NewMark,As3,As4,Mid,Final)).
query3(S,N,Type,NewMark) :-
	Type==as3,retract(c325(S,N,As1,As2,_,As4,Mid,Final)),!,assert(c325(S,N,As1,As2,NewMark,As4,Mid,Final)).
query3(S,N,Type,NewMark) :-
	Type==as4,retract(c325(S,N,As1,As2,As3,_,Mid,Final)),!,assert(c325(S,N,As1,As2,As3,NewMark,Mid,Final)).
query3(S,N,Type,NewMark) :-
	Type==midterm,retract(c325(S,N,As1,As2,As3,As4,_,Final)),!,assert(c325(S,N,As1,As2,As3,As4,NewMark,Final)).
query3(S,N,Type,NewMark) :-
	Type==final,retract(c325(S,N,As1,As2,As3,As4,Mid,_)),!,assert(c325(S,N,As1,As2,As3,As4,Mid,NewMark)).
query3(S,N,Type,NewMark) :- 
	write('record not found'),!.


/*************************************************************************************
 * Question 2
 *	 The organizers of a workshop need to book a number of rooms, 
 *	 which can be given by facts like
 *	 room(r1).
 *	 room(r2).
 *
 *	 for a 2 days workshop, which consists of 11 half-day sessions.  
 *	 Let us name the sessions by a,b,..., k, 
 *	 and the half-days by firstDayAm, firstDayPm, secondDayAm, and secondDayPm. 
 *	 In scheduling the workshop, some constraints must be satisfied.  
 *	 Some sessions cannot be held at the same time. This is given by facts like
 *	 notAtSameTime([b,i,h,g]) .meaning that no sessions in [b,i,h,g] may be held 
 *	 at the same time. A session may need to take place before another session, 
 *	 given by facts like before(i,j).meaning that i should precede j. A session may 
 *	 need to be placed at a particular time and/or in a particular room; the 
 *	 information is given by, e.g.
 *	 at(a,firstDayPm,_).
 *
 *	 which means that the session a must take place at firstDayPm, in any room.
 *
 *	 Write a program, such that given a collection of facts like above,  
 *	 and a number of rooms as described at the beiginning, your program generates 
 *	 all solutions (one at a time), and if a solution exists, otherwise the message 
 *	 "cannot be scheduled" should be shown.We can use a list of variables [A,B,C,...]
 *	 to represent sessions, where two pieces of information are associated with each 
 *	 session, time and place. The representation of a solution is simpler if we use 
 *	 two lists of variables, one for times and the other for rooms. Then, we write 
 *	 constraints that must be satisfied, w.r.t. one of these lists, or both, depending 
 *	 on the constraint.
 ******************************************************************************************/


room(r1).
room(r2).
room(r3).
notAtSameTime([b,i,h,g]).
before(i,j).
at(a,_,r2).

getRoom(Room,RmList) :- findall(Room,(room(Room)),RmList).


findIndex(Session,[A,B,C,D,E,F,G,H,I,J,K],R) :-
	Session == a,!,R#=A.
findIndex(Session,[A,B,C,D,E,F,G,H,I,J,K],R) :-
	Session == b,!,R#=B.
findIndex(Session,[A,B,C,D,E,F,G,H,I,J,K],R) :-
	Session == c,!,R#=C.
findIndex(Session,[A,B,C,D,E,F,G,H,I,J,K],R) :-
	Session == d,!,R#=D.
findIndex(Session,[A,B,C,D,E,F,G,H,I,J,K],R) :-
	Session == e,!,R#=E.
findIndex(Session,[A,B,C,D,E,F,G,H,I,J,K],R) :-
	Session == f,!,R#=F.
findIndex(Session,[A,B,C,D,E,F,G,H,I,J,K],R) :-
	Session == g,!,R#=G.
findIndex(Session,[A,B,C,D,E,F,G,H,I,J,K],R) :-
	Session == h,!,R#=H.
findIndex(Session,[A,B,C,D,E,F,G,H,I,J,K],R) :-
	Session == i,!,R#=I.
findIndex(Session,[A,B,C,D,E,F,G,H,I,J,K],R) :-
	Session == j,!,R#=J.
findIndex(Session,[A,B,C,D,E,F,G,H,I,J,K],R) :-
	Session == k,!,R#=K.

timePartition(firstDayAm,1).
timePartition(firstDayPm,2).
timePartition(secondDayAm,3).
timePartition(secondDayPm,4).
timePartition(_,_).

maproom(r1,10).
maproom(r2,11).
maproom(r3,12).
maproom(r4,13).
maproom(r5,14).
maproom(r6,15).
maproom(r7,16).
maproom(r8,17).
maproom(r9,18).
maproom(r10,19).
maproom(r11,20).
maproom(_,_).



schedule(TimeLst,RmLst) :- TimeLst = [A,B,C,D,E,F,G,H,I,J,K],length(TimeLst,Len),length(RmLst,Len),                     
append(TimeLst,RmLst, W),             
findall(L, notAtSameTime(L), C1),     
findall([Q1,Q2],before(Q1,Q2),C2),
findall([Session,Time,Rm],at(Session,Time,Rm), C3),  
domain(TimeLst,1,4),
getRoom(Room,RmList),
length(RmList,Lenm),
Rlen is 9 + Lenm,  
domain(RmLst,10,Rlen),
constr1(TimeLst,C1),         
constr2(TimeLst,C2),          
constr3(TimeLst,RmLst,C3),    
exclusive(TimeLst,RmLst),
labeling([],W),
List = [a,b,c,d,e,f,g,h,i,j,k],
myPrint(TimeLst,RmLst,List).


myPrint([],[],[]).
myPrint([T|L],[W|R],[List|Rest]):-
write('session '), write(List), write(' at time '),
write(T), write(' in room '),
write(W), write('\n'),
myPrint(L,R,Rest).

tc1(T,R) :- T = [1,1,C,4,3,3,4,H,I,J,K], R = [A1,B1,C1,D1,E1,F1,G1,H1,I1,J1,K1], domain(T,1,4), domain(R,10,20), exclusive(T,R), labeling([],R).


cc1(TimeLst,C1) :-
	C1 = [A,B], 	
	findIndex(A,TimeLst,Tm),
	findIndex(B,TimeLst,Tm2),
	Tm #\= Tm2.
cc1(TimeLst,C1) :-
	C1 = [A,B|R],
	findIndex(A,TimeLst,Tm),
	findIndex(B,TimeLst,Tm2),
	Tm #\= Tm2,
	cc1(TimeLst,[A|R]), cc1(TimeLst,[B|R]).

constr1(TimeLst,[]).
constr1(TimeLst,C1) :-
	C1 = [A|L],
	cc1(TimeLst,A),
	constr1(TimeLst,L).


constr2(TimeLst,[]).
constr2(TimeLst,C2) :-
	C2 = [[Session,Session2]|L],
	findIndex(Session,TimeLst,I),
	findIndex(Session2,TimeLst,J),
	I #<J,constr2(TimeLst,L).

constr3(TimeLst,RmLst,[]).
constr3(TimeLst,RmLst,C3) :-
	C3 = [[Session,Period,RmN]|L],
	timePartition(Period,Time),
	findIndex(Session,TimeLst,Time),
	maproom(RmN,Rm),
	findIndex(Session,RmLst,Rm),
	constr3(TimeLst,RmLst,L).

exclusive(TimeLst,RmLst):-
	TimeLst = [T1,T2], RmLst = [R1,R2],
	(T1 #\= T2) #\/ (R1 #\= R2).
exclusive(TimeLst,RmLst):-
	TimeLst = [T1,T2|T3], RmLst = [R1,R2|R3],
	(T1 #\= T2) #\/ (R1 #\= R2),
	exclusive([T1|T3],[R1|R3]), exclusive([T2|T3],[R2|R3]).






/****************************************************************************
 * Question 3
 *	Define a predicate
 *	subsetSum(+L, -Result)
 *	where L is a list of integers (which represents a multiset where an 
 *	element may repeat) and, Result should be bound to a subset of L whose 
 *	sum is zero, if such a query is answered positively. Your program should 
 *	provide all such subsets when user asks for alternative answers.
 ***************************************************************************/


% subset(X, Y) :- Y is a subset of X
subset([], []).
subset([H|T1], [H|T2]) :- subset(T1, T2).
subset([_|T],L) :- subset(T, L).

subsetSum(L,R) :- map(L,R1,_),
	domain(R1,0,1),
	sumequal0(L,R1),
	labeling([ffc],R1),print(L,R1,R),checkempty(R).

% sum(L, N) :- sum of elements in L is equal to N
sum_list([],0).
sum_list([H|T],Sum) :-
	sum_list(T,Rest),Sum is H + Rest.

is_empty([]).
is_empty(L) :- L == [].

% Constrain is the sum of the subset is 0
sumConstr(N,L) :-
	sum_list(L,N),
	N #= 0,
	labeling([],L).

% findall
subsetSum(L,R) :-
	findall(Subl,(subset(L,Subl),sumConstr(N,Subl),\+ is_empty(Subl)),R).


map(X,Y,Map):-var(Map),!,
    map_build(X,Y,Map).
map(X,Y,Map):-
    map_get(X,Y,Map).

map_build([],[],[]).
map_build([A|As],[B|Bs],[(A,B)|Map]):-
    map_build(As,Bs,Map).

map_get([],[],_):-!.
map_get([A|As],[B|Bs],Map):-!,
    map_get(A,B,Map),
    map_get(As,Bs,Map).
map_get(A,B,Map):-
    member((A,B),Map),!.
