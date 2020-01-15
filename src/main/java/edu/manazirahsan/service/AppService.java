package edu.manazirahsan.service;

import java.util.List;

import javax.persistence.EntityNotFoundException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.manazirahsan.model.App;
import edu.manazirahsan.repository.AppRepository;

@Service
public class AppService {
	@Autowired
	private AppRepository appRepository;
	
	public App getAppById(Long id) {
		try {
			appRepository.getOne(id).getName();
			return appRepository.getOne(id);
		} catch(EntityNotFoundException ex) {
			return null;
		}
	}
	
	public List<App> getAllApps(){
		if(appRepository.findAll().size() > 0) {
			return appRepository.findAll();
		} else {
			return null;
		}
	}
	
	public App createApp(App app) {
		return appRepository.save(app);
	}
	
	public App updateApp(Long id, App app) {
		App app2 = appRepository.getOne(id);
		app2.setName(app.getName());
		app2.setDescription(app.getDescription());
		app2.setImage(app.getImage());
		return appRepository.save(app2);
	}
	
	public void deleteApp(Long id) {
		try {
			appRepository.deleteById(id);
		} catch(Exception ex) {
			
		}
	}
}
