package edu.mum.mumsched.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.mum.mumsched.dao.StudentDao;
import edu.mum.mumsched.domain.Course;
import edu.mum.mumsched.domain.Student;
import edu.mum.mumsched.domain.StudentSection;
import edu.mum.mumsched.service.StudentService;

@Service
public class StudentServiceImp implements StudentService{

	@Autowired
	StudentDao studentDAO;

	@Override
	public Student getStudentByName(String name) {
		// TODO Auto-generated method stub
		return studentDAO.findByUserName(name);
	}

	@Override
	public boolean checkPrereq(Student s, Course precourse) {
		// TODO Auto-generated method stub		
		for(StudentSection ss:s.getStudentSections()){
			if (ss.getSection().getCourse().getId() == precourse.getId())
			{
				return true;
			}	
		}
		return false;
	}

	@Override
	public Student getStudentById(int id) {
		// TODO Auto-generated method stub
		return studentDAO.findById(id);
	}

	@Override
	public int saveStudent(Student student) {
		// TODO Auto-generated method stub
		studentDAO.save(student);
		return 0;
	}
	


}
