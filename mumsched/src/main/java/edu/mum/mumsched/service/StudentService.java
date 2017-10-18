package edu.mum.mumsched.service;

import edu.mum.mumsched.domain.Course;
import edu.mum.mumsched.domain.Student;

public interface StudentService {

	public Student getStudentByName(String name);
	
	public Student getStudentById(int id);
	
	public boolean checkPrereq(Student s, Course precourse);
	
	public int saveStudent(Student student);
}
