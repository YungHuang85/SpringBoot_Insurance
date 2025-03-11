package insurance.main.products.model;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface InsuranceCategoryBeanRepository extends JpaRepository<InsuranceCategoryBean, Integer> {
	//自定義查詢
	 Optional<InsuranceCategoryBean> findBycategoryname(String name);

}