package insurance.main.products.dto;

import java.util.LinkedHashSet;
import java.util.Set;
import java.util.stream.Collectors;

import insurance.main.products.model.InsuranceProductBean;

public class InsuranceCategoryDTO {

	private int categoryid;
	private String categoryname;
	private Set<InsuranceProductDTO> products = new LinkedHashSet<InsuranceProductDTO>();
	
	

	public InsuranceCategoryDTO() {
	}

	public InsuranceCategoryDTO(int categoryid, String categoryname, Set<InsuranceProductBean> products) {
	    this.categoryid = categoryid;
	    this.categoryname = categoryname;
	    if (products != null) {
	        this.products = products.stream()
	                .map(product -> new InsuranceProductDTO(
	                        product.getProductid(),
	                        product.getProductname(),
	                        product.getProductDescription(),
	                        product.getProductPicture(),
	                        product.getCategory().getCategoryid(),
	                		product.isFeatured()))
	                .collect(Collectors.toSet());
	    }
	}


	public int getCategoryid() {
		return categoryid;
	}

	public void setCategoryid(int categoryid) {
		this.categoryid = categoryid;
	}

	public String getCategoryname() {
		return categoryname;
	}

	public void setCategoryname(String categoryname) {
		this.categoryname = categoryname;
	}

	public Set<InsuranceProductDTO> getProducts() {
		return products;
	}

	public void setProducts(Set<InsuranceProductDTO> products) {
		this.products = products;
	}

}
