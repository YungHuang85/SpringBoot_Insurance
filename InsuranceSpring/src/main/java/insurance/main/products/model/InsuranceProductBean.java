package insurance.main.products.model;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "InsuranceProduct")
@Component
public class InsuranceProductBean implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "productid")
	private int productid;
	
	@Column(name = "productname")
	private String productname;
	
	@Column(name = "productDescription")
	private String productDescription;
	
	@Column(name = "productPicture", columnDefinition = "VARBINARY(MAX)")
	@Lob
	private byte[] productPicture;
	
	@Column(name = "isFeatured")
	private boolean isFeatured;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "categoryid")
	private InsuranceCategoryBean category;
	
	
	public InsuranceProductBean() {
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

	public InsuranceCategoryBean getCategory() {
		return category;
	}

	public void setCategory(InsuranceCategoryBean category) {
		this.category = category;
	}

	public String getProductDescription() {
		return productDescription;
	}

	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}

	public byte[] getProductPicture() {
		return productPicture;
	}

	public void setProductPicture(byte[] productPicture) {
		this.productPicture = productPicture;
	}

	public boolean isFeatured() {
		return isFeatured;
	}

	public void setFeatured(boolean isFeatured) {
		this.isFeatured = isFeatured;
	}
	
	
	

	
	
	

}
