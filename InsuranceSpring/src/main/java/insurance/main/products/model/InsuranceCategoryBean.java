package insurance.main.products.model;

import java.util.LinkedHashSet;
import java.util.Set;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "InsuranceCategory")
@Component
public class InsuranceCategoryBean implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "categoryid")
	private int categoryid;
	
	@Column(name = "categoryname")
	private String categoryname;
	
	@OneToMany(fetch = FetchType.LAZY,mappedBy = "category",cascade = CascadeType.ALL)
	@JsonIgnore
	private Set<InsuranceProductBean> products = new LinkedHashSet<InsuranceProductBean>();
	
	
	
	public InsuranceCategoryBean() {
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
	

	public Set<InsuranceProductBean> getProducts() {
		return products;
	}

	public void setProducts(Set<InsuranceProductBean> products) {
		this.products = products;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("InsuranceCategoryBean [categoryid=");
		builder.append(categoryid);
		builder.append(", categoryname=");
		builder.append(categoryname);
		builder.append("]");
		return builder.toString();
	}
	
	
}
