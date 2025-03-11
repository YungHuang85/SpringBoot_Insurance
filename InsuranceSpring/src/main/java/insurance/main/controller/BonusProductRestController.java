package insurance.main.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import insurance.main.model.BonusProductBean;
import insurance.main.model.BonusProductService;



@RestController // 使用 @RestController，這個類專門處理 API 請求，並且自動將返回結果轉換成 JSON 格式
@RequestMapping("/api/bonusproduct") // 可以根據需要調整路徑
public class BonusProductRestController {

    @Autowired
    private BonusProductService bonusProductService;

    // 返回所有商品的 API 路徑（JSON）
    //http://localhost:8081/api/bonusproduct/products
    @CrossOrigin(origins = "http://localhost:5173")
    @GetMapping("/products")
    public List<BonusProductBean> getAllProducts() {
        return bonusProductService.findAllBonusProduct(); // 返回所有產品資料
    }

    // 根據分類過濾商品的 API 路徑（JSON）
    //http://localhost:8081/api/bonusproduct/filter?category=全部
    @CrossOrigin(origins = "http://localhost:5173")
    @GetMapping("/filter")
    public List<BonusProductBean> filterProductsByCategory(@RequestParam("category") String category) {
        if ("全部".equals(category)) {
            return bonusProductService.findAllBonusProduct(); // 獲取所有產品
        } else {
            return bonusProductService.findBonusProductsByCategory(category); // 根據分類過濾產品
        }
    }

    // 根據關鍵字搜尋商品的 API 路徑（JSON）
    //http://localhost:8081/api/bonusproduct/search?keyword=咖啡
    @CrossOrigin(origins = "http://localhost:5173")
    @GetMapping("/search")
    public List<BonusProductBean> searchProducts(@RequestParam("keyword") String keyword) {
        return bonusProductService.searchBonusProducts(keyword); // 根據關鍵字查找產品
    }
}
