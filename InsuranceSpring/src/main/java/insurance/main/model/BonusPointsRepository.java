package insurance.main.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


public interface BonusPointsRepository extends JpaRepository<BonusPointsBean, String> {
	
	BonusPointsBean findByEmail(String email); // 根據 email 查詢 PointsBean

	@Query("SELECT p.points FROM BonusPointsBean p WHERE LOWER(p.email) = LOWER(:email)")
	Integer findPointsByEmail(@Param("email") String email);

}





