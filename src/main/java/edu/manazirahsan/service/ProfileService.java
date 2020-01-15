package edu.manazirahsan.service;

import java.util.List;

import javax.persistence.EntityNotFoundException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.manazirahsan.model.Profile;
import edu.manazirahsan.repository.ProfileRepository;

@Service
public class ProfileService {
	@Autowired
	private ProfileRepository profileRepository;
	
//	public Profile getProfileById(Long id) {
//		Profile profile = null;
//		try {
//			profileRepository.getOne(id).getName();
//			profile = profileRepository.getOne(id);
//			return profile;
//		} catch(EntityNotFoundException ex) {
//			return null;
//		}
//	}
	
	public Profile getProfileByIdAndUserId(Long id, Long userId) {
		Profile profile = null;
		try {
			profile = profileRepository.getProfileByIdAndUserId(id, userId);
			return profile;
		} catch(EntityNotFoundException ex) {
			return null;
		}
	}
	
//	public List<Profile> getAllProfiles() {
//		if(profileRepository.findAll().size() > 0) {
//			return profileRepository.findAll();
//		} else {
//			return null;
//		}
//	}
	
	public List<Profile> getProfilesByUserId(Long id) {
		if(profileRepository.getProfilesByUserId(id).size() > 0) {
			return profileRepository.getProfilesByUserId(id);
		} else {
			return null;
		}
	}
	
	public void createProfile(Profile profile) {
		profileRepository.save(profile);
	}
	
	public void updateProfile(Long id, Profile profile) {
		Profile profile2 = profileRepository.getOne(id);
		profile2.setName(profile.getName());
		profile2.setPassword(profile.getPassword());
		profile2.setUser(profile.getUser());
		profile2.getApps().clear();
		profile2.getApps().addAll(profile.getApps());
		profileRepository.save(profile2);
	}
	
	public void deleteProfile(Long id, Long userId) {
		Profile profile = profileRepository.getProfileByIdAndUserId(id, userId);
		profileRepository.delete(profile);
	}
}
