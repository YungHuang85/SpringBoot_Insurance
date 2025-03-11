package insurance.main.model;

import org.springframework.stereotype.Component;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "bonusproduct")
@Component
public class BonusProductBean {
	
	@Id
	private int productno;
	
	@Column(name = "productname")
	private String productname;
	
	@Column(name = "category")
	private String category;
	
	@Column(name = "cost")
	private int cost;
	
	// 使用 String 來儲存圖片存放路徑
    @Column(name = "productimage") 
    private String productimage;

    @Column(name = "count")  
    private int count;

	public BonusProductBean() {
	}

	// Getter 和 Setter 方法

	public int getProductno() {
		return productno;
	}

	public void setProductno(int productno) {
		this.productno = productno;
	}

	public String getProductname() {
		return productname;
	}

	public void setProductname(String productname) {
		this.productname = productname;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public Integer getCost() {
		return cost;
	}

	public void setCost(Integer cost) {
		this.cost = cost;
	}

	public String getProductimage() {
		return productimage;
	}

	public void setProductimage(String productimage) {
		this.productimage = productimage;
	}

	// Getter 和 Setter for count

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
}
