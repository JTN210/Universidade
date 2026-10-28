open util/ordering[Grade]

sig Person {
	teaches : set Course,
	enrolled : set Course,
	worksOn : set Project
}

sig Professor,Student in Person {}

sig Course {
	proposes : set Project,
	grades : Person -> Grade
}

sig Project {}

sig Grade {}
// Specify the following properties.
// You can check their correctness with the different commands and
// when specifying each property you can assume all the previous ones to be true.

pred inv1 {
	all c:  Course | some p : Person | p -> c in teaches

	// all c : Course | some p : Person | c in p.teaches
	// all c : Course | some p : Person | p in c.teaches

	// all c : Course | some teaches.c -- resposta da aula 
}


pred inv2 {
	// all p : Project | some s : Person | s -> p in worksOn
	// all p : Project | some s : Person | p in s.worksOn
	all p : Project | some worksOn.p
}


pred inv3 {
	// all p : Project | one c : Course | c-> p in proposes
	all p : Project | one proposes.p

}


pred inv4 {
	// all s : Student, c : Course | lone g : Grade | c->s->g in grades
	all s : Student, c : Course | lone s.(c.grades)

}

fact {
	inv1
	inv2
	inv3
	inv4
}


pred lume {
	// Only students can be enrolled in the course

	// all p: Person, c:Course | p->c in enrolled implies p in Student
	//all p:Person | (some c:Course | p->c in enrolled) implies p in Student
	 all p : Person | (some p.enrolled) implies p in Student

}
pred lume2 {
	// Only professors can teach courses

	// all p: Person, c:Course | p->c in teaches implies p in Professor
	// all p: Person, c:Course | p in teaches.c implies p in Professor
	// all c.Course | teaches.c in Professor
	// teaches.Course in Professor
	teacher in Professor -> Course
}

pred inv5 {
	// Only students work on projects and 
	// projects must have someone working on them

}


pred inv6 {
	// Students only work on projects of courses they are enrolled in
	all s: Student , c : Courses, p: Project | c -> p in proposes and s -> pr in worksOn implies s-> c in enrolled
	// all s :  Student, c : Course | (some  c.proposes & s.worksOn) implies s -> c in enrolled	
	//all s : Student, pr : s.worksOn | proposes.pr in s.enrolled  

	all s : Student, c:Course, pr: Project |  s in worksOn.pr implies s in enrolled.c 
}


pred inv7 {
	// Students work on at most one project per course
	//all s: Student,c: Course | lone pr : Project | c->pr in proposes and s->pr in worksOn
	//all s: Student,c: Course | lone pr : Project | pr in (c.proposes & s.worksOn)
	all s: Student,c: Course | lone (c.proposes & s.worksOn)

}


pred inv8 {
	// A professor cannot teach herself

}


pred inv9 {
	// A professor cannot teach colleagues

}


pred inv10 {
	// Only students have grades

}


pred inv11 {
	// Students only have grades in courses they are enrolled
	// all s : Student, c:Course,g:Grade | c->s->g in grades implies s->c in enrolled
	// all s:Student, c:Course, g:grades | s in c.grade.g implies s in enrolled.c
	all c : Course, g : Grade | c.grades.g in enrolled.c

}
pred studentProjects{
	// cada projeto tem pelo menos um aluno a trabalhar nele
	all p: Project | some s:Student | s->p in worksOn


}


pred inv12 {
	// Students have at most one grade per course

}


pred inv13 {
	// A student with the highest mark in a course must have worked on a project on that course

}


pred inv14 {
	// A student cannot work with the same student in different projects

}


pred inv15 {
	// Students working on the same project in a course cannot have marks differing by more than one unit

}
