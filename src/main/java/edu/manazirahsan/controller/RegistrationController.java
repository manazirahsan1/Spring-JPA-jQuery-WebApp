package edu.manazirahsan.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.manazirahsan.model.User;
import edu.manazirahsan.service.UserService;
import edu.manazirahsan.utility.Emailer;
import edu.manazirahsan.utility.HashFunction;
import edu.manazirahsan.utility.RandomString;

@Controller
@RequestMapping("/registration")
public class RegistrationController {
	@Autowired
	private UserService userService;
	
	@Autowired
	private Emailer emailer;
	
	@Autowired
	private RandomString randomString;
	
	@Autowired
	private HashFunction hashFunction;
	
	@RequestMapping(value="/new", method=RequestMethod.GET)
	public String newUser(Model model) {
		model.addAttribute("user", new User());
		return "registration/signup";
	}
	
	@RequestMapping(value="/create", method=RequestMethod.POST)
	public String createUser(@ModelAttribute("user") User user, Model model) {
		user.setPassword(hashFunction.getHashDigest(user.getPassword()));
		String message = userService.createUser(user);
		if(message.contains("ConstraintViolationException")) {
			model.addAttribute("message", "This email address already exists. Please <a href=\"\\signin\">sign in</a>. If you forget your password, you can reset it.");
			model.addAttribute("css", "alert alert-warning");
		} else {
			user = userService.getUserByEmail(user.getEmail());
			String subject = "Confirm email for Mult-level Authentication";
			String body = "Please the link: http://localhost:8080/registration/" + user.getId() + "/confirm/?otp=" + user.getOtp() + " to confirm your email.";
			emailer.sendEmail(user.getEmail(), subject, body);
			model.addAttribute("message", "An email has been sent to you. Please check you inbox to confirm it.");
			model.addAttribute("css", "alert alert-success");
		}
		return "signInOut/signin";
	}
	
	@RequestMapping(value="/{id}/confirm", method=RequestMethod.GET)
	public String confirmEmail(@PathVariable("id") Long id, @RequestParam(name="otp") String otp,
			RedirectAttributes redirectAttributes) {
		User user = userService.getUserById(id);
		if(user.getOtp().equals(otp)) {
			user.setVerified(true);
			userService.saveUser(user);
			redirectAttributes.addFlashAttribute("message", "Thank you for confirming your email.");
			redirectAttributes.addFlashAttribute("css", "alert alert-success");
			return "redirect:/signin";
		} else {
			redirectAttributes.addFlashAttribute("message", "Wrong confirmation.");
			redirectAttributes.addFlashAttribute("css", "alert alert-danger");
			return "redirect:/";
		}
	}
	
	@RequestMapping(value="/resetpassword", method=RequestMethod.GET)
	public String requestPasswordReset() {
		return "registration/EmailForPasswordReset";
	}
	
	@RequestMapping(value="/resetpassword", method=RequestMethod.POST)
	public String sendLink(Model model, @RequestParam("email") String email) {
		ArrayList<String> emails = (ArrayList<String>) userService.getAllEmails();
		if(emails.stream().anyMatch(email::contains)) {
			String otp = randomString.generate(10);
			User user = userService.getUserByEmail(email);
			user.setOtp(otp);
			userService.saveUser(user);
			StringBuilder body = new StringBuilder();
			body.append("Hi,");
			body.append(System.getProperty("line.separator"));
			body.append("Please click the following link to reset your password:");
			body.append(System.getProperty("line.separator"));
			body.append("http://localhost:8080/registration/resetPassword/" + email);
			body.append("?otp=" + otp);
			body.append(System.getProperty("line.separator"));
			body.append("Thank you,");
			body.append(System.getProperty("line.separator"));
			body.append("Developer team.");
			emailer.sendEmail(email, "Multi Level Authentication | Reset Password", body.toString());
			
			model.addAttribute("message", "An email has been sent to your account, please follow it to reset password.");
			model.addAttribute("css", "alert alert-success");
			return "signInOut/signin";
		} else {
			model.addAttribute("message", email + ": this email address does not exist in our records. Please enter a registered email.");
			model.addAttribute("css", "alert alert-danger");
			return "registration/EmailForPasswordReset";
		}
	}
	
	@RequestMapping(value="/resetPassword/{email}", method=RequestMethod.GET)
	public String resetPassword(Model model, @PathVariable("email") String email,
			@RequestParam("otp") String otp) {
		User user = userService.getUserByEmail(email);
		if(user == null) {
			model.addAttribute("message", "Trouble in resetting password. Please try again.");
			model.addAttribute("css", "alert alert-danger");
			return "signInOut/signin";
		} else {
			if(user.getOtp().equals(otp)) {
				model.addAttribute("message", "Please reset your password");
				model.addAttribute("css", "alert alert-success");
				model.addAttribute("email", email);
				return "registration/newPasswordForm";
			} else {
				model.addAttribute("message", "Secret code did not match. Please try resetting password again.");
				model.addAttribute("css", "alert alert-danger");
				return "signInOut/signin";
			}
		}
	}
	
	@RequestMapping(value="/doResetPassword", method=RequestMethod.POST)
	public String doResetPassword(Model model, @RequestParam("email") String email,
			@RequestParam("password") String password, @RequestParam("confirmPassword") String confirmPassword) {
		User user = userService.getUserByEmail(email);
		if(user == null) {
			model.addAttribute("message", "Trouble resetting password. Please try again.");
			model.addAttribute("css", "alert alert-danger");
		} else if(!password.equals(confirmPassword)) {
			model.addAttribute("message", "Password did not match. Please try again.");
			model.addAttribute("css", "alert alert-danger");
		} else {
			user.setPassword(hashFunction.getHashDigest(password));
			userService.saveUser(user);
			model.addAttribute("message", "Your password has been reset. You can login now!!");
			model.addAttribute("css", "alert alert-success");
		}
		return "signInOut/signin";
	}
	
}
