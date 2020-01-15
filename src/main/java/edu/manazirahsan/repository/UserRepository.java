package edu.manazirahsan.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import edu.manazirahsan.model.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
	@Query(value = "SELECT * FROM USER_CREDENTIAL WHERE EMAIL = ?1 AND _PASSWORD = ?2 LIMIT 1", nativeQuery = true)
	public User authenticate(String email, String password);
	
	@Query(value = "SELECT * FROM USER_CREDENTIAL WHERE EMAIL = ?1 LIMIT 1", nativeQuery = true)
	public User getUserByEmail(String email);
	
	@Query(value="SELECT EMAIL FROM USER_CREDENTIAL", nativeQuery=true)
	public List<String> getAllEmails();
}
