package insurance.main.products.dto;

import java.util.Base64;


public class InsuranceProductDTO {

	private int productid;
	private String productname;
	private String productDescription;
	private String productPicture;
	private int categoryid;
	private boolean isFeatured;
	
	public InsuranceProductDTO(int productid, String productname, String productDescription, byte[] productPicture, int categoryid, boolean isFeatured) {
		this.productid = productid;
		this.productname = productname;
		this.productDescription = productDescription;
		if (productPicture != null) {
			this.productPicture = "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(productPicture);
		} else {
			this.productPicture = null;
		}
		this.categoryid = categoryid;
		this.isFeatured = isFeatured;
	}

	public InsuranceProductDTO() {
	}

	public int getProductid() {
		return productid;
	}

	public void setProductid(int productid) {
		this.productid = productid;
	}

	public String getProductname() {
		return productname;
	}

	public void setProductname(String productname) {
		this.productname = productname;
	}

	public String getProductDescription() {
		return productDescription;
	}

	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}

	public String getProductPicture() {
		return productPicture;
	}

	public void setProductPicture(String productPicture) {
		this.productPicture = productPicture;
	}

	public int getCategoryid() {
		return categoryid;
	}

	public void setCategoryid(int categoryid) {
		this.categoryid = categoryid;
	}

	public boolean isFeatured() {
		return isFeatured;
	}

	public void setFeatured(boolean isFeatured) {
		this.isFeatured = isFeatured;
	}
	
	
	
	

	

}
