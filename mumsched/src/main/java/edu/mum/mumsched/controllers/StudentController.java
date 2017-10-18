package edu.mum.mumsched.controllers;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import edu.mum.mumsched.domain.Student;
import edu.mum.mumsched.service.StudentService;

@Controller
public class StudentController {

	@Autowired
	private StudentService studentService;
	
	@InitBinder
	public void initBinder(WebDataBinder webDataBinder) {
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    dateFormat.setLenient(false);
	    webDataBinder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
	
	@RequestMapping(value = "/viewstudentprofile/{id}", method = RequestMethod.GET)
	public String viewStudentProfile(@PathVariable int id, Model model) {
		Student student = studentService.getStudentById(id);
		model.addAttribute("student",student);		
		if (student.getStudentSections() != null)
			model.addAttribute("studentsections",student.getStudentSections());
		return "student/viewProfile";
	}
	
	@RequestMapping(value = "/editstudentprofile/{id}", method = RequestMethod.GET)
	public String editStudentProfile(@PathVariable int id, Model model) {
		Student student = studentService.getStudentById(id);
		model.addAttribute("student",student);			
		model.addAttribute("studentsections",student.getStudentSections());
		return "student/editProfile";
	}
	
	@RequestMapping(value = "/updatestudentprofile", method = RequestMethod.POST)
	public String registerUser(@Valid Student student,  BindingResult result, ModelMap model) {
		if (result.hasErrors()) {
			model.addAttribute("student",student);			
			model.addAttribute("studentsections",student.getStudentSections());
			return "student/editProfile";
		}
		studentService.saveStudent(student);
		Student thisStudent = studentService.getStudentById(student.getId());
		model.addAttribute("student",thisStudent);		
		if (thisStudent.getStudentSections() != null)
			model.addAttribute("studentsections",thisStudent.getStudentSections());
		model.addAttribute("success", "Student " + student.getFirstName() + " "+ student.getLastName() + " updated successfully");
		return "redirect:/";
	}	
}
