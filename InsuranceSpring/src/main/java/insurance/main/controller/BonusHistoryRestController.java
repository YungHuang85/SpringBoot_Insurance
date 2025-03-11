package insurance.main.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import insurance.main.model.BonusHistoryBean;
import insurance.main.model.BonusHistoryService;



@RestController
@RequestMapping("/api/bonushistory")
public class BonusHistoryRestController {

    @Autowired
    private BonusHistoryService bonusHistoryService;

    // 查詢用戶兌換紀錄
    // http://localhost:8081/api/bonushistory/history?email=zack149633218@gmail.com
    @GetMapping("/history")
    public List<BonusHistoryBean> getUserHistory(@RequestParam String email) {
        return bonusHistoryService.getHistoryByEmail(email);
    }
}
