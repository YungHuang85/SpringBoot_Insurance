package insurance.main.products.model;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import insurance.main.products.dto.*;


@Service
@Transactional
public class ProductService {

	@Autowired
	private InsuranceProductBeanRepository ProductResp;
	
	@Autowired
	private InsuranceCategoryBeanRepository CategoryResp;
	
	// 沒用到
	@Transactional
	public InsuranceProductBean GetProductByID(Integer id) {
		Optional<InsuranceProductBean> optional = ProductResp.findById(id);
		if(optional.isPresent()) {
			return optional.get();
		}
		return null;
	}
	
	// 沒用到
	@Transactional
	public List<InsuranceProductBean> GetProductByName(String productname) {
		
		return ProductResp.findByProductname(productname);
	}
	
	// 沒用到
	@Transactional
	public List<InsuranceProductBean> GetLikeProduct(String productname) {
		
		return ProductResp.findByProductnameLike("%" + productname + "%");
	}

	// 沒用到
	@Transactional
	public List<InsuranceProductDTO> GetProductByCategoryid(Integer categoryid) {
		Optional<InsuranceCategoryBean> category = CategoryResp.findById(categoryid);
		return ProductResp.findByCategory(category.get()).stream()
	            .map(this::convertToProductDTO) // 使用簡化的映射方法
	            .collect(Collectors.toList());
	}
	
	@Transactional
	public List<InsuranceProductDTO> GetFeaturedProduct(){
		
		return ProductResp.findByIsFeaturedTrue().stream()
        .map(this::convertToProductDTO) // 使用簡化的映射方法
        .collect(Collectors.toList());
	}

	@Transactional
	public List<InsuranceProductDTO> GetAllProduct() {
		return ProductResp.findAll().stream()
	            .map(this::convertToProductDTO) // 使用簡化的映射方法
	            .collect(Collectors.toList());
	}
	
	@Transactional
	public boolean DeleteProductByID(Integer id) {
		int id1 = id;
		System.out.println(1);
		Optional<InsuranceProductBean> optional = ProductResp.findById(id1);
		System.out.println(2);
		if(optional.isPresent()) {
			System.out.println(id);
			ProductResp.deleteById(id);
			ProductResp.flush();
			 System.out.println("Product deleted");
			return true;
		}

		return false;
	}
	
	

	//如果沒有值就新增插入 有值就回傳空值
	@Transactional
	public InsuranceProductBean InsertProduct(InsuranceProductBean insuranceProductBean) {
		
		Optional<InsuranceProductBean> optional = ProductResp.findByProductnameAndCategory(insuranceProductBean.getProductname(), insuranceProductBean.getCategory());
		if (optional.isEmpty()) {
//			System.out.println("Product Name: " + insuranceProductBean.getProductname());
//			System.out.println("Category ID: " + insuranceProductBean.getCategory().getCategoryid());
//			System.out.println("Description: " + insuranceProductBean.getProductDescription());
//			System.out.println("Is Featured: " + insuranceProductBean.isFeatured());
//			System.out.println("圖片大小: " + (insuranceProductBean.getProductPicture() != null ? insuranceProductBean.getProductPicture().length : "null"));
			return ProductResp.save(insuranceProductBean);
		}
		return null;
	}
	
	//先尋找產品名稱及類編號是否已經有重複ID
	//沒有重複直接保存
	//有重複檢查是不是自己本身 是的話保存修改 不是的話回傳null
	@Transactional
	public InsuranceProductBean UpdateProductByID(InsuranceProductBean insuranceProductBean) {
		Optional<Integer> optional = ProductResp.findByProductnameAndCategory(insuranceProductBean.getProductname(), insuranceProductBean.getCategory())
				.map(InsuranceProductBean::getProductid);
		if (optional.isEmpty()) {
			return ProductResp.save(insuranceProductBean);
		} else if (optional.get().equals(insuranceProductBean.getProductid())) {
			return ProductResp.save(insuranceProductBean);
		}
		return null;
	}
	
	@Transactional
	private InsuranceProductDTO convertToProductDTO(InsuranceProductBean productBean) {
	    return new InsuranceProductDTO(
	        productBean.getProductid(),
	        productBean.getProductname(),
	        productBean.getProductDescription(),
	        productBean.getProductPicture(),
	        productBean.getCategory().getCategoryid(),
	        productBean.isFeatured()
	    );
	}
}
