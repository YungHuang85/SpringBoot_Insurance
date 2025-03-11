package insurance.main.model;

import java.util.Optional;

import org.springframework.boot.autoconfigure.kafka.KafkaProperties.Admin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AdminListRepository extends JpaRepository<AdminBean, Long> {

	Optional<Admin> findByUsername(String username);

	// 根據 email 查詢（如果需要）
	Optional<Admin> findByAdminEmail(String adminEmail);

}
