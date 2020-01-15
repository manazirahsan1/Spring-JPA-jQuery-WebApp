package edu.manazirahsan.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.manazirahsan.model.Profile;
import edu.manazirahsan.model.User;
import edu.manazirahsan.service.AppService;
import edu.manazirahsan.service.ProfileService;
import edu.manazirahsan.service.UserService;

@Controller
@RequestMapping("/profiles")
public class ProfileController {
	@Autowired
	private ProfileService profileService;
	
	@Autowired
	private AppService appService;
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="", method=RequestMethod.GET)
	public String list(Model model, HttpServletRequest request) {
		Long id = (Long) request.getSession().getAttribute("LOGGED_IN_USER_ID");
		if(id != null) {
			List<Profile> profiles = profileService.getProfilesByUserId(id);
			model.addAttribute("profiles", profiles);
		}
		return "profile/list";
	}
	
	@RequestMapping(value="/{id}", method=RequestMethod.GET)
	public String show(Model model, @PathVariable("id") Long id, HttpServletRequest request) {
		Long userId = (Long) request.getSession().getAttribute("LOGGED_IN_USER_ID");
		if(userId != null) {
			Profile profile = profileService.getProfileByIdAndUserId(id, userId);
			model.addAttribute("profile", profile);
		}
		return "profile/show";
	}
	
	@RequestMapping(value="/new", method=RequestMethod.GET)
	public String newProfile(Model model) {
		model.addAttribute("profile", new Profile());
		model.addAttribute("apps", appService.getAllApps());
		return "profile/new";
	}
	
	@RequestMapping(value="/create", method=RequestMethod.POST)
	public String createProfile(Model model, @ModelAttribute("profile") Profile profile, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		if(profile.getName().equals("") || profile.getPassword().equals("") || profile.getApps().size() == 0) {
			model.addAttribute("message", "Some fields are missing");
			model.addAttribute("css", "alert alert-danger");
			model.addAttribute("profile", profile);
			model.addAttribute("apps", appService.getAllApps());
			return "profile/new";
		} else {
			Long id = (Long) request.getSession().getAttribute("LOGGED_IN_USER_ID");
			if(id != null) {
				User user = userService.getUserById(id);
				profile.setUser(user);
				user.getProfiles().add(profile);
				profileService.createProfile(profile);
				redirectAttributes.addFlashAttribute("message", "Profile has been created successfully");
				redirectAttributes.addFlashAttribute("css", "alert alert-success");
			}
			return "redirect:/profiles";
		}
	}
	
	@RequestMapping(value="/edit/{id}", method=RequestMethod.GET)
	public String editProfile(Model model, @PathVariable("id") Long id, HttpServletRequest request) {
		Long userId = (Long) request.getSession().getAttribute("LOGGED_IN_USER_ID");
		if(userId != null) {
			Profile profile = profileService.getProfileByIdAndUserId(id, userId);
			model.addAttribute("profile", profile);
			model.addAttribute("apps", appService.getAllApps());
		}
		return "profile/edit";
	}
	
	@RequestMapping(value="/update/{id}", method=RequestMethod.POST)
	public String updateProfile(Model model, @PathVariable("id") Long id, @ModelAttribute("profile") Profile profile,
			RedirectAttributes redirectAttributes, HttpServletRequest request) {
		if(profile.getName().equals("") || profile.getPassword().equals("") || profile.getApps().size() == 0) {
			model.addAttribute("message", "Some fields are missing");
			model.addAttribute("css", "alert alert-danger");
			model.addAttribute("profile", profile);
			model.addAttribute("apps", appService.getAllApps());
			return "profile/edit";
		} else {
			Long userId = (Long) request.getSession().getAttribute("LOGGED_IN_USER_ID");
			if(userId != null) {
				User user = userService.getUserById(userId);
				profile.setUser(user);
				user.getProfiles().add(profile);
				profileService.updateProfile(id, profile);
				redirectAttributes.addFlashAttribute("message", "Profile has been updated successfully");
				redirectAttributes.addFlashAttribute("css", "alert alert-success");
			} else {
				redirectAttributes.addFlashAttribute("message", "You cannot update the profile");
				redirectAttributes.addFlashAttribute("css", "alert alert-danger");
			}
			return "redirect:/profiles";
		}
	}
	
	@RequestMapping(value="/delete/{id}", method=RequestMethod.POST)
	public String deleteProfile(Model model, @PathVariable("id") Long id,
			RedirectAttributes redirectAttributes, HttpServletRequest request) {
		Long userId = (Long) request.getSession().getAttribute("LOGGED_IN_USER_ID");
		if(userId != null) {
			profileService.deleteProfile(id, userId);
			redirectAttributes.addFlashAttribute("message", "Profile has been deleted successfully");
			redirectAttributes.addFlashAttribute("css", "alert alert-success");
		} else {
			redirectAttributes.addFlashAttribute("message", "Profile cannot be deleted since it belongs to other people");
			redirectAttributes.addFlashAttribute("css", "alert alert-danger");
		}
		return "redirect:/profiles";
	}
}
