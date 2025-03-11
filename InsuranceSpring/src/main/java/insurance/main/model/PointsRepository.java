package insurance.main.model;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


public interface PointsRepository extends JpaRepository<BonusPointsBean, String> {
	
	   Optional<BonusPointsBean> findByEmail(String email);// 根據 email 查詢 PointsBean
	
	   

}





