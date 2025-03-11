package insurance.main.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface AdminPasswordResetTokenRepository extends JpaRepository<AdminPasswordResetToken, Long> {
	AdminPasswordResetToken findByToken(String token);
}
