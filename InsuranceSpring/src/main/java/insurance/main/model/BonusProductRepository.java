package insurance.main.model;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface BonusProductRepository extends JpaRepository<BonusProductBean, Integer> {
	
	 List<BonusProductBean> findByCategory(String category); // 根據分類查詢產品
	 
	 List<BonusProductBean> findByProductnameContaining(String keyword); // 根據產品名稱模糊查詢
	 
	 BonusProductBean findById(int productno);

}
