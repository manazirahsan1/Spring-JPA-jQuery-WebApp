package edu.manazirahsan.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.manazirahsan.model.User;
import edu.manazirahsan.repository.UserRepository;
import edu.manazirahsan.utility.RandomString;

@Service
public class UserService {
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private RandomString randomString;
	
	public User getUserById(Long id) {
		return userRepository.getOne(id);
	}
	
	public User getUserByEmail(String email) {
		return userRepository.getUserByEmail(email);
	}
	
	public User authenticate(String email, String password) {
		return userRepository.authenticate(email, password);
	}
	
	public String createUser(User user) {
		String message = "Please check you email for confirming it.";
		user.setOtp(randomString.generate(7));
		user.setVerified(false);
		try {
			userRepository.save(user);
		} catch(Exception ex) {
			message = ex.getLocalizedMessage();
		}
		return message;
	}
	
	public void saveUser(User user) {
		userRepository.save(user);
	}
	
	public List<String> getAllEmails() {
		return userRepository.getAllEmails();
	}
}
