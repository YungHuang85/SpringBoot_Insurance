package insurance.main.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import insurance.main.model.BonusProductBean;
import insurance.main.model.BonusProductService;
import insurance.main.model.BonusPointsBean;
import insurance.main.model.BonusPointsService;
import insurance.main.model.BonusPointsService.ExchangeResult;

@RestController
@RequestMapping("/api/points")
public class BonusPointsRestController {

    @Autowired
    private BonusPointsService pointsService;

    @Autowired
    private BonusProductService bonusProductService;
    
    // 查詢用戶剩餘點數的 API
    // http://localhost:8081/api/points/check?email=zack149633218@gmail.com
    @GetMapping("/check")
    public ResponseEntity<Object> checkPoints(@RequestParam String email) {
        BonusPointsBean pointsBean = pointsService.getPointsByEmail(email);
        
        if (pointsBean == null) {
            return ResponseEntity.status(404).body("用戶不存在");
        }

        return ResponseEntity.ok(new Object() {
        	public final String user = pointsBean.getUsername();
            public final String email = pointsBean.getEmail();
            public final int points = pointsBean.getPoints();
        });
    }

    // 處理點數兌換的 API 請求
    // http://localhost:8081/api/points/exchange?email=zack149633218@gmail.com&productno=1001
    @PostMapping("/exchange")
    public ResponseEntity<Object> exchangePoints(@RequestParam String email, @RequestParam int productno) {
        // 根據 email 查找用戶點數資料
        BonusPointsBean pointsBean = pointsService.getPointsByEmail(email);

        if (pointsBean == null) {
            return ResponseEntity.status(404).body(new Response("false", "用戶不存在"));
        }

        // 根據商品編號查找商品資料
        BonusProductBean product = bonusProductService.getProductByNo(productno);

        if (product == null) {
            return ResponseEntity.status(404).body(new Response("false", "商品不存在"));
        }

        // 使用 PointsService 來處理點數更新和商品兌換
        ExchangeResult result = pointsService.exchangeProduct(email, productno);

        if (result.isSuccess()) {
            return ResponseEntity.ok(new Response("true", result.getMessage()));
        } else {
            return ResponseEntity.status(400).body(new Response("false", result.getMessage()));
        }
    }

    // 返回的 JSON 格式
    private static class Response {
        private String success;
        private String message;

        public Response(String success, String message) {
            this.success = success;
            this.message = message;
        }

        public String getSuccess() {
            return success;
        }

        public String getMessage() {
            return message;
        }
    }
}
