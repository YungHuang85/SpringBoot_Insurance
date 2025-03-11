package insurance.main.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import insurance.main.model.BonusProductBean;
import insurance.main.model.BonusProductService;



@Controller
@RequestMapping("/bonusproduct")
public class BonusProductController {

    @Autowired
    private BonusProductService bonusProductService;
    
    // 顯示所有產品 http://localhost:8081/bonusproduct/BonusMall
    @GetMapping("/BonusMall")
    public String findAllProducts(Model model) {
        List<BonusProductBean> products = bonusProductService.findAllBonusProduct();
        model.addAttribute("products", products);
        return "/BonusMall";
    }

    // 新增產品頁面
    @GetMapping("/add")
    public String showAddProductForm(Model model) {
        model.addAttribute("bonusProduct", new BonusProductBean());
        return "InsertBonusProduct";
    }

    // 處理新增產品
    @PostMapping("/insert")
    public String insertProduct(@ModelAttribute BonusProductBean bonusProduct,
                                @RequestParam("bonusproductimage") MultipartFile bonusproductimage,
                                Model model) {
        try {
            bonusProductService.insertBonusProduct(bonusProduct, bonusproductimage);
            
            return "redirect:/bonusproduct/BonusMall";
        } catch (IOException e) {
            e.printStackTrace();
            model.addAttribute("error", "新增失敗：" + e.getMessage());
            return "error";
        }
    }

    // 顯示更新產品
    @GetMapping("/update")
    public String showUpdateProductForm(@RequestParam("productno") Integer productno, Model model) {
        BonusProductBean product = bonusProductService.getUpdateBonusProduct(productno);
        model.addAttribute("bonusProduct", product);
        return "UpdateBonusProduct";
    }

    // 處理更新產品
    @PostMapping("/update")
    public String updateProduct(@ModelAttribute BonusProductBean bonusProduct,
                                @RequestParam(value = "bonusproductimage", required = false) MultipartFile bonusproductimage,
                                Model model) {
        try {
            bonusProductService.updateBonusProduct(bonusProduct, bonusproductimage);
            
            return "redirect:/bonusproduct/BonusMall";
        } catch (IOException e) {
            e.printStackTrace();
            model.addAttribute("error", "更新失敗：" + e.getMessage());
            return "error";
        }
    }

    // 處理刪除產品請求
    @PostMapping("/delete")
    public String deleteProduct(@RequestParam("productno") Integer productno) {
        bonusProductService.deleteBonusProduct(productno);
        return "redirect:/bonusproduct/BonusMall"; 
    }
    
    
    //分類
    @GetMapping("/filter")
    public String filterProducts(@RequestParam("category") String category, Model model) {
        List<BonusProductBean> products;
        if (category.equals("全部")) {
            products = bonusProductService.findAllBonusProduct(); // 獲取所有產品
        } else {
            products = bonusProductService.findBonusProductsByCategory(category); // 根據分類獲取產品
        }
        model.addAttribute("products", products);
        return "BonusMall"; 
    }
    
    
    //模糊查詢
    @GetMapping("/search")
    public String searchProducts(@RequestParam("keyword") String keyword, Model model) {
        List<BonusProductBean> products = bonusProductService.searchBonusProducts(keyword);
        model.addAttribute("products", products);
        return "BonusMall";
    }

    /*
    @GetMapping("/querybypage/{pageNo}")
    @ResponseBody
    public HashMap<String, Object> processQueryAllByPageAction(@PathVariable Integer pageNo) {
        int pageSize = 12; // 每頁顯示的商品數量
        Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
        Page<BonusProductBean> page = bonusProductService.findAllBonusProductsByPage(pageable);

        HashMap<String, Object> maps = new HashMap<>();
        maps.put("totalPages", page.getTotalPages());
        maps.put("totalElements", page.getTotalElements());
        maps.put("content", page.getContent());

        return maps;
    }
	*/
    
}
