package insurance.main.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface AdminRepository extends JpaRepository<AdminBean, Long> {

	AdminBean findByUsername(String username);

	@Modifying
	@Query("UPDATE AdminBean a SET a.loginFailCount = a.loginFailCount + 1 WHERE a.id = :id")
	void incrementLoginFailCount(@Param("id") Long id);

	@Transactional
	@Modifying
	@Query("UPDATE AdminBean a SET a.loginFailCount = 0 WHERE a.id = :id")
	void resetLoginFailCount(@Param("id") Long id);

}
