package insurance.main.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository // 標示為 Spring Repository 層，讓 Spring Boot 進行管理
public interface BeneRepository extends JpaRepository<BeneBean1, String> {

}