package edu.manazirahsan.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.manazirahsan.model.App;
import edu.manazirahsan.service.AppService;

@Controller
@RequestMapping(value="/apps")
public class AppController {
	private final String UPLOADED_FOLDER = "E:\\technology\\projects\\PseudoMLA\\src\\main\\resources\\static\\img\\";
	
	@Autowired
	private AppService appService;

	@RequestMapping(value="", method=RequestMethod.GET)
	public String list(Model model) {
		List<App> apps = appService.getAllApps();
		if(apps == null) {
			model.addAttribute("message", "So far there is no app in the database.");
			model.addAttribute("css", "alert alert-warning");
		} else {
			model.addAttribute("apps", apps);
		}
		return "app/list";
	}
	
	@RequestMapping(value="/{id}", method=RequestMethod.GET)
	public String show(Model model, @PathVariable("id") Long id) {
		App app = appService.getAppById(id);
		if(app == null) {
			model.addAttribute("message", "No such app found with ID: " + id);
			model.addAttribute("css", "alert alert-danger");
		} else {
			model.addAttribute("app", app);
		}
		return "app/show";
	}
	
	@RequestMapping(value="/new", method=RequestMethod.GET)
	public String newApp(Model model) {
		App app = new App();
		model.addAttribute("app", app);
		return "app/new";
	}
	
	@RequestMapping(value="/create", method=RequestMethod.POST)
	public String createApp(Model model, @ModelAttribute("name") String name, @ModelAttribute("description") String description,
			@RequestParam("file") MultipartFile file, RedirectAttributes redirectAttributes) {
		App app = new App();
		try {
			app.setName(name);
			app.setDescription(description);
			String fileName = UUID.randomUUID() + "."
					+ file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf('.')+1);
			byte[] bytes = file.getBytes();
            Path path = Paths.get(UPLOADED_FOLDER + fileName);
            Files.write(path, bytes);
            app.setImage(fileName);
			app = appService.createApp(app);
        } catch (IOException e) {
            e.printStackTrace();
        }	
		if(app.getId() == null) {
			model.addAttribute("message", "App cannot be saved");
			model.addAttribute("css", "alert alert-danger");
			return "app/new";
		} else {
			model.addAttribute("message", "App has been saved successfully");
			model.addAttribute("css", "alert alert-success");
			model.addAttribute("app", app);
			return "app/show";
		}
	}
	
	@RequestMapping(value="/edit/{id}", method=RequestMethod.GET)
	public String editApp(Model model, @PathVariable("id") Long id,
			RedirectAttributes redirectAttributes) {
		App app = appService.getAppById(id);
		if(app == null) {
			redirectAttributes.addFlashAttribute("message", "No such app found with ID " + id);
			redirectAttributes.addFlashAttribute("css", "alert alert-danger");
			return "redirect:/apps";
		} else {
			model.addAttribute("app", app);
			return "app/edit";
		}
	}
	
	@RequestMapping(value="/update/{id}", method=RequestMethod.POST)
	public String updateApp(Model model, @PathVariable("id") Long id, @RequestParam("file") MultipartFile file, 
			@ModelAttribute("name") String name, @ModelAttribute("description") String description, @RequestParam(value="check", required=false) String checkbox, 
				RedirectAttributes redirectAttributes) {
		App app = appService.getAppById(id);
		if(app == null) {
			redirectAttributes.addFlashAttribute("message", "No such app found with ID " + id);
			redirectAttributes.addFlashAttribute("css", "alert alert-danger");
			return "redirect:/apps";
		} else {
			app.setName(name);
			app.setDescription(description);
			if(checkbox == null) {
				String fileName = UUID.randomUUID() + "."
						+ file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf('.')+1);
				try {
					byte[] bytes = file.getBytes();
		            Path path = Paths.get(UPLOADED_FOLDER + fileName);
		            Files.write(path, bytes);
					app.setImage(fileName);
		        } catch (IOException e) {
		            e.printStackTrace();
		        }
			}
			appService.updateApp(id, app);
			model.addAttribute("message", "The app has been saved successfully");
			model.addAttribute("css", "alert alert-success");
			model.addAttribute("app", app);
			return "app/show";
		}
	}
	
	@RequestMapping(value="/delete/{id}", method=RequestMethod.POST)
	public String deleteApp(Model model, @PathVariable("id") Long id, 
			RedirectAttributes redirectAttributes) {
		App app = appService.getAppById(id);
		if(app == null) {
			model.addAttribute("message", "No such app found with ID " + id);
			model.addAttribute("css", "alert alert-danger");
		} else {
			appService.deleteApp(id);
			model.addAttribute("message", "App has been deleted successfully");
			model.addAttribute("css", "alert alert-success");
		}
		redirectAttributes.addFlashAttribute("message", "The app has been deleted successfully");
		redirectAttributes.addFlashAttribute("css", "alert alert-success");
		return "redirect:/apps";
	}

}
