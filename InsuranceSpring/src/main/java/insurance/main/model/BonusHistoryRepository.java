package insurance.main.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface BonusHistoryRepository extends JpaRepository<BonusHistoryBean, Integer> {
    
    // 根據 email 查詢該用戶的兌換紀錄
    List<BonusHistoryBean> findByEmail(String email);
}
