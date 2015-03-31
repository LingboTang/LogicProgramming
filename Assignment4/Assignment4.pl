/********************************************************
 * CMPUT325: Assignment4
 * Prof: You
 * Student: LingboTang
 ********************************************************/

:- use_module(library(clpfd)).
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



findStudent(S,N,T) :- findall([Semester,Name,As1,As2,As3,As4,Midterm,Final],(c325(Semester,Name,As1,As2,As3,As4,Midterm,Final),Semester == S, Name == N),T).
% findGrade(S,L) :- findall([Semester,Work,Grade,Weight],setup(Semester,Work,Grade,Weight),L).
% getAverage(S,N,G) :- findall(Average,(Average is As1*0.1+As2*0.1+As3*0.1+As4*0.1+Midterm*0.25+Final*0.35),G).
% query1(S,N,T) :- findSemester(S),findStudent(N),getAverage(S,N,T).

/*****************************************************************************
 * Question 1 
 *   (b)Define a predicate:
 *	query2(+Semester, -L).
 *	Given a semester, find all students whose final exam shows 
 *	an improvement over the midterm, in the sense that the percentage 
 *	obtained from the final is (strictly) better than that of the midterm.
 *****************************************************************************/
 

