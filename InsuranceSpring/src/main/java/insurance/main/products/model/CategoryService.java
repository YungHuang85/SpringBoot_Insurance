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
public class CategoryService {
	
	@Autowired
	private InsuranceCategoryBeanRepository CategoryResp;
	
//	@Autowired
//    private ModelMapper modelMapper;
	
	
	
	public InsuranceCategoryBean GetCategoryById(Integer id) {
		Optional<InsuranceCategoryBean> optional = CategoryResp.findById(id);
		if(optional.isPresent()) {
			return optional.get();
		}
		return null;
	}
	
	public InsuranceCategoryBean GetCategoryByName(String categoryname) {
		Optional<InsuranceCategoryBean> optional = CategoryResp.findBycategoryname(categoryname);
		if(optional.isEmpty()) {
			return null;
		}
		return optional.get();
	}
	
	public List<InsuranceCategoryDTO> GetAllCategory() {
		List<InsuranceCategoryBean> Categories = CategoryResp.findAll();
		return Categories.stream()
        .map(this::convertToCategoryDTO)
        .collect(Collectors.toList());
	}
	
	public boolean DeleteCategoryByID(Integer id) {
		
		Optional<InsuranceCategoryBean> optional = CategoryResp.findById(id);
		if(optional.isPresent()) {
			CategoryResp.deleteById(id);
			return true;
		}
		return false;
	}
	
	public InsuranceCategoryBean InsertCategory(String categoryname) {
		Optional<InsuranceCategoryBean> optional = CategoryResp.findBycategoryname(categoryname);
		if(optional.isPresent()) {
			return null;
		} else {
			InsuranceCategoryBean insuranceCategoryBean = new InsuranceCategoryBean();
	        insuranceCategoryBean.setCategoryname(categoryname); 
	        return CategoryResp.save(insuranceCategoryBean);
		}
	}
	
	public InsuranceCategoryBean UpdateCategoryByID(Integer id, String newCategoryName) {
		Optional<InsuranceCategoryBean> optional = CategoryResp.findBycategoryname(newCategoryName);
		if(optional.isEmpty()) {
			InsuranceCategoryBean insuranceCategoryBean = new InsuranceCategoryBean();
			insuranceCategoryBean.setCategoryid(id);
			insuranceCategoryBean.setCategoryname(newCategoryName);
			return CategoryResp.save(insuranceCategoryBean);
		}
		return null;
	}
	
    // 將 InsuranceCategoryBean 映射為 InsuranceCategoryDTO
	private InsuranceCategoryDTO convertToCategoryDTO(InsuranceCategoryBean categoryBean) {
	    return new InsuranceCategoryDTO(
	        categoryBean.getCategoryid(),
	        categoryBean.getCategoryname(),
	        categoryBean.getProducts() // 傳遞產品集合
	    );
	}
}
