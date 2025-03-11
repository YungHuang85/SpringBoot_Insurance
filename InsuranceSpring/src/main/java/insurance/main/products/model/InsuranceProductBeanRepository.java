package insurance.main.products.model;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface InsuranceProductBeanRepository extends JpaRepository<InsuranceProductBean, Integer> {

	//自定義查詢
	Optional<InsuranceProductBean> findByProductnameAndCategory(String productname, InsuranceCategoryBean category);
	List<InsuranceProductBean> findByProductname(String productname);
	List<InsuranceProductBean> findByProductnameLike(String productname);
	List<InsuranceProductBean> findByCategory(InsuranceCategoryBean category);
	List<InsuranceProductBean> findByIsFeaturedTrue();
}
