package edu.manazirahsan.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import edu.manazirahsan.model.App;

@Repository
public interface AppRepository extends JpaRepository<App, Long>{
	
}
