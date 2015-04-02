/********************************************************
 * CMPUT325: Assignment4
 * Prof: You
 * Student: LingboTang
 ********************************************************/

:- use_module(library(clpfd)).
:- use_module(library(list)).
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


/************************************************
 * Question 2
 ************************************************/
% all_distinct() to check the list.


% notAtSameTime(L)
% before(I,J)
% at(S,T,R)

room(r1).
room(r2).
room(r3).



schedule(TimeLst,RmLst) :- TimeLst = [A,B,C,D,E,F,G,H,I,J,K],length(TimeLst,Len),length(RmLst,Len),                     
append(TimeLst,RmLst, W),             
findall(L, notAtSameTime(L), C1),     
findall([Q1,Q2],before(Q1,Q2),C2),     
findall([Session,Time,Rm],at(Session,Time,Rm), C3), 
% Add something 
domain(TimeLst, 1,4),  
domain(RmLst, 10, 11),
% Add something
constr1(TimeLst,C1),         
constr2(TimeLst,C2),          
constr3(TimeLst,RmLst,C3),    
exclusive(TimeLst,RmLst),
% Add something   
labeling([],W),

List = [a,b,c,d,e,f,g,h,i,j,k],
myPrint(TimeLst,RmLst,List).
myPrint([],[],[]).
myPrint([T|L],[W|R],[List|Rest]):-
write('session '), write(List), write(' at time '),
write(T), write(' in room '),
write(W), write('\n'),
myPrint(L,R,Rest).




/****************************************************************************
 * Question 3
 *	Define a predicate
 *	subsetSum(+L, -Result)
 *	where L is a list of integers (which represents a multiset where an 
 *	element may repeat) and, Result should be bound to a subset of L whose 
 *	sum is zero, if such a query is answered positively. Your program should 
 *	provide all such subsets when user asks for alternative answers.
 ***************************************************************************/

