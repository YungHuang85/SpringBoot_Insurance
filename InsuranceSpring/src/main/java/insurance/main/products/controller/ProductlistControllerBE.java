package insurance.main.products.controller;

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

import insurance.main.products.dto.InsuranceCategoryDTO;
import insurance.main.products.dto.InsuranceProductDTO;
import insurance.main.products.model.CategoryService;
import insurance.main.products.model.InsuranceCategoryBean;
import insurance.main.products.model.InsuranceProductBean;
import insurance.main.products.model.ProductService;


//http://localhost:8080/insuranceSpring_productlist/productlistBE/GetAllProductlist
//http://localhost:8081/productlistBE/GetAllProductlist

@Controller
@RequestMapping("/productlistBE")
public class ProductlistControllerBE {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    // 共用的 ModelAttribute
    @ModelAttribute("ics")
    public List<InsuranceCategoryDTO> getAllCategory() {
        return categoryService.GetAllCategory();
    }

    @ModelAttribute("ips")
    public List<InsuranceProductDTO> getAllProduct() {
        return productService.GetAllProduct();
    }

    // 顯示所有產品列表
    @RequestMapping("/GetAllProductlist")
    public String getAll() {
        return "GetAllProductlist";
    }

    // 插入新產品
    @PostMapping("/InsertProduct")
    public String insertProduct(
    		@RequestParam String productname, 
    		@RequestParam int categoryid,
    		@RequestParam String productDescription,
    		@RequestParam MultipartFile productPicture,
    		@RequestParam boolean isFeatured, Model model) {
    	InsuranceProductBean insuranceProductBean = new InsuranceProductBean();
    	insuranceProductBean.setProductname(productname);
    	insuranceProductBean.setCategory(categoryService.GetCategoryById(categoryid));
    	insuranceProductBean.setProductDescription(productDescription);
    	insuranceProductBean.setFeatured(isFeatured);
    	if (productPicture != null && !productPicture.isEmpty()) {
			try {
				insuranceProductBean.setProductPicture(productPicture.getBytes());
			} catch (IOException e) {
				insuranceProductBean.setProductPicture(null);
				e.printStackTrace();
			}
		} else {
			insuranceProductBean.setProductPicture(null);
		}

    	InsuranceProductBean insertProduct = productService.InsertProduct(insuranceProductBean);
    	
        if (insertProduct == null) {
			model.addAttribute("messages", "資料重複");
		} else {
			model.addAttribute("messages", "新增成功");
		}

		return "forward:/productlistBE/GetAllProductlist"; 
    }

    // 插入新分類
    @PostMapping("/InsertCategory")
    public String insertCategory(@RequestParam String categoryname, Model model) {
        InsuranceCategoryBean insertCategory = categoryService.InsertCategory(categoryname);
        if (insertCategory == null) {
			model.addAttribute("messages", "資料重複");
		} else {
			model.addAttribute("messages", "新增成功");
		}

		return "forward:/productlistBE/GetAllProductlist"; 
    }

    // 刪除產品
    @GetMapping("/DeleteProductById")
    public String deleteProduct(@RequestParam int productid) {
        productService.DeleteProductByID(productid);
        return "redirect:/productlistBE/GetAllProductlist";
    }

    // 刪除分類
    @GetMapping("/DeleteCategoryById")
    public String deleteCategory(@RequestParam int categoryid) {
        categoryService.DeleteCategoryByID(categoryid);
        return "redirect:/productlistBE/GetAllProductlist";
    }

    // 更新分類
    @PostMapping("/UpdateCategoryById")
    public String updateCategory(@RequestParam int categoryid, @RequestParam String categoryname, Model model) {
        InsuranceCategoryBean updateCategoryByID = categoryService.UpdateCategoryByID(categoryid, categoryname);
        if (updateCategoryByID == null) {
			model.addAttribute("messages", "資料重複");
		} else {
			model.addAttribute("messages", "新增成功");
		}

		return "forward:/productlistBE/GetAllProductlist"; 
    }

    // 更新產品
    @PostMapping("/UpdateProductById")
    public String updateProduct(
    		@RequestParam int productid,
    		@RequestParam String productname, 
    		@RequestParam int categoryid,
    		@RequestParam String productDescription,
    		@RequestParam MultipartFile productPicture,
    		@RequestParam boolean isFeatured, Model model) {
    	InsuranceProductBean insuranceProductBean = new InsuranceProductBean();
    	insuranceProductBean.setProductid(productid);
    	insuranceProductBean.setProductname(productname);
    	insuranceProductBean.setCategory(categoryService.GetCategoryById(categoryid));
    	insuranceProductBean.setProductDescription(productDescription);
    	insuranceProductBean.setFeatured(isFeatured);
    	if (productPicture != null && !productPicture.isEmpty()) {
			try {
				insuranceProductBean.setProductPicture(productPicture.getBytes());
			} catch (IOException e) {
				insuranceProductBean.setProductPicture(null);
				e.printStackTrace();
			}
		} else {
			insuranceProductBean.setProductPicture(null);
		}
        InsuranceProductBean updateProductByID = productService.UpdateProductByID(insuranceProductBean);
        if (updateProductByID == null) {
			model.addAttribute("messages", "資料重複");
		} else {
			model.addAttribute("messages", "新增成功");
		}

		return "forward:/productlistBE/GetAllProductlist"; 
    }
}
