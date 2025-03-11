package insurance.premiums.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import insurance.premiums.model.TravelPremiumsService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("travelpremiums") // 指定 API 的基本 URL 路徑為 "travelpremiums"
public class TravelPremiumsController {

    @Autowired
    private TravelPremiumsService exampleService;

    
    /**
     * 透過 ID 和 Key 查詢對應的保費值
     * 範例請求：http://localhost:8081/travelpremiums/22/500W
     */
    @GetMapping("/{id}/{key}")
    public ResponseEntity<?> getValueByIdAndKey(@PathVariable Integer id, @PathVariable String key) {
        try {
        	// 呼叫 Service 層的方法，根據 id 和 key 查詢保費值
            Integer value = exampleService.findValueByIdAndKey(id, key);
            // 查詢成功，回傳 200 OK 與查詢結果
            return ResponseEntity.ok(value);
        } catch (IllegalArgumentException e) {
        	// 若發生 IllegalArgumentException，回傳 400 Bad Request 並附帶錯誤訊息
            return ResponseEntity.badRequest().body(e.getMessage());
        } catch (RuntimeException e) {
        	// 若發生其他 RuntimeException，回傳 404 Not Found 並附帶錯誤訊息
            return ResponseEntity.status(404).body(e.getMessage());
        }
    }
}

