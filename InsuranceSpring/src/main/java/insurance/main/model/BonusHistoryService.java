package insurance.main.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BonusHistoryService {

    @Autowired
    private BonusHistoryRepository bonusHistoryRepository;

    // 根據 email 查詢兌換紀錄
    public List<BonusHistoryBean> getHistoryByEmail(String email) {
        return bonusHistoryRepository.findByEmail(email);
    }
}
