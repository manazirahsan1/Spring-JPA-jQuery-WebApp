package edu.manazirahsan.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import edu.manazirahsan.model.Profile;

@Repository
public interface ProfileRepository extends JpaRepository<Profile, Long>{
	@Query(value = "SELECT * FROM PHONE_PROFILE WHERE USER_ID = ?1", nativeQuery = true)
	public List<Profile> getProfilesByUserId(Long id);
	
	@Query(value = "SELECT * FROM PHONE_PROFILE WHERE ID = ?1 AND USER_ID = ?2 LIMIT 1", nativeQuery = true)
	public Profile getProfileByIdAndUserId(Long id, Long userId);
}
