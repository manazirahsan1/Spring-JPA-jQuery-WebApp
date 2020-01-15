package edu.manazirahsan.controller;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.manazirahsan.model.User;
import edu.manazirahsan.service.UserService;
import edu.manazirahsan.utility.HashFunction;

@Controller
public class SignInController {
	@Autowired
	private UserService userService;
	
	@Autowired
	private HashFunction hashFunction;
	
	@RequestMapping(value="/signin", method=RequestMethod.GET)
	public String signInForm() {
		return "signInOut/signin";
	}
	
	@RequestMapping(value="/signin", method=RequestMethod.POST)
	public String doSignIn(Model model, @ModelAttribute("email") String email, @ModelAttribute("password") String password,
			RedirectAttributes redirectAttributes, HttpServletRequest request) {
		User user = userService.authenticate(email, hashFunction.getHashDigest(password));
		if(user == null) {
			model.addAttribute("message", "Incorrect email/password pair. <br/>Please try again.");
			model.addAttribute("css", "alert alert-danger");
			return "signInOut/signin";
		} else {
			request.getSession().setAttribute("LOGGED_IN_USER_ID", user.getId());
			request.getSession().setAttribute("LOGGED_IN_USER_NAME", user.getName());
			request.getSession().setAttribute("LOGGED_IN_USER_EMAIL", user.getEmail());
			redirectAttributes.addFlashAttribute("message", "You have successfully signed in. You must be, " + user.getName());
			redirectAttributes.addFlashAttribute("css", "alert alert-success");
			return "redirect:/profiles"; // Instead of home page, return to profile page here.
		}
	}
	
	@RequestMapping(value="/signout", method=RequestMethod.POST)
	public String signOut(Model model, RedirectAttributes redirectAttributes, 
			HttpServletRequest request) {
		request.getSession().removeAttribute("LOGGED_IN_USER_ID");
		request.getSession().removeAttribute("LOGGED_IN_USER_NAME");
		request.getSession().removeAttribute("LOGGED_IN_USER_EMAIL");
		request.getSession().invalidate();
		redirectAttributes.addFlashAttribute("message", "You have successfully signed out. Hope to see you soon.");
		redirectAttributes.addFlashAttribute("css", "alert alert-success");
		return "redirect:/";
	}
}
