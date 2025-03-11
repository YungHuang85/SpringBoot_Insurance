package insurance.main.products.controller;

import java.io.IOException;
import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.view.RedirectView;
import org.springframework.core.io.ByteArrayResource;
import insurance.main.products.dto.*;
import insurance.main.products.model.CategoryService;
import insurance.main.products.model.InsuranceCategoryBean;
import insurance.main.products.model.InsuranceProductBean;
import insurance.main.products.model.ProductService;
import jakarta.mail.internet.MimeMessage;


// http://localhost:8081/productlist/GetAllProductlist

@RestController
@RequestMapping("/productlist")
public class ProductlistController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;
    
    @Autowired
    private JavaMailSender mailSender;

    // 共用的 ModelAttribute
//    @ModelAttribute("ics")
    @GetMapping("/GetAllCategory") 
    public List<InsuranceCategoryDTO> getAllCategory() {
        return categoryService.GetAllCategory();
    }
//    @ModelAttribute("ips")
    @GetMapping("/GetAllProduct")
    public List<InsuranceProductDTO> getAllProduct() {
        return productService.GetAllProduct();
    }
    
    @GetMapping("/GetAllProduct/{categoryid}")
    public List<InsuranceProductDTO> getAllProductByCategoryId(@PathVariable(name = "categoryid") Integer categoryid) {
    	return productService.GetProductByCategoryid(categoryid);
    }
    
    @GetMapping("/GetFeaturedProduct")
    public List<InsuranceProductDTO> GetFeaturedProduct(){
    	return productService.GetFeaturedProduct();
    }

    // 顯示所有產品列表
    @RequestMapping("/GetAllProductlist")
    public String getAll() {
        return "GetAllProductlist";
    }
    
    @PostMapping("/SendPDF")
    public ResponseEntity<String> sendPdfEmail(@RequestBody PdfEmailRequestDTO request) {
        try {
            byte[] pdfBytes = Base64.getDecoder().decode(request.getPdf());

            // 設定郵件屬性
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            helper.setTo(request.getEmail());
            helper.setSubject("您的 PDF 文件");
            helper.setText("請查收您的 PDF 文件", true);

            // 附件
            helper.addAttachment("試算方案比較.pdf", new ByteArrayResource(pdfBytes));

            // 發送郵件
            mailSender.send(message);

            return ResponseEntity.ok("PDF 發送成功！");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("發送失敗：" + e.getMessage());
        }
    }


    // 插入新產品
    @PostMapping("/InsertProduct")
    public String insertProduct(
    		@RequestParam String productname, 
    		@RequestParam int categoryid,
    		@RequestParam String productDescription,
    		@RequestParam MultipartFile productPicture,
    		@RequestParam boolean isFeatured, Model model) {
    	InsuranceProductBean insuranceProductBean =new InsuranceProductBean();
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

		return "forward:/productlist/GetAllProductlist"; 
    }

    // 插入新分類
    @PostMapping("/InsertCategory")
    public String insertCategory(
    		@RequestParam String categoryname,
    		Model model) {
        InsuranceCategoryBean insertCategory = categoryService.InsertCategory(categoryname);
        if (insertCategory == null) {
			model.addAttribute("messages", "資料重複");
		} else {
			model.addAttribute("messages", "新增成功");
		}

		return "forward:/productlist/GetAllProductlist"; 
    }

    // 刪除產品
    @GetMapping("/DeleteProductById")
    public RedirectView deleteProduct(@RequestParam int productid) {
        productService.DeleteProductByID(productid);
        return new RedirectView("/productlistBE/GetAllProductlist");
    }

    // 刪除分類
    @GetMapping("/DeleteCategoryById")
    public String deleteCategory(@RequestParam int categoryid) {
        categoryService.DeleteCategoryByID(categoryid);
        return "redirect:/productlist/GetAllProductlist";
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

		return "forward:/productlist/GetAllProductlist"; 
    }

    // 更新產品
//    @PostMapping("/UpdateProductById")
//    public String updateProduct(@RequestParam int productid, @RequestParam String productname, @RequestParam int categoryid, Model model) {
//        InsuranceProductBean updateProductByID = productService.UpdateProductByID(productid, productname, categoryid);
//        if (updateProductByID == null) {
//			model.addAttribute("messages", "資料重複");
//		} else {
//			model.addAttribute("messages", "新增成功");
//		}
//
//		return "forward:/productlist/GetAllProductlist"; 
//    }
}
