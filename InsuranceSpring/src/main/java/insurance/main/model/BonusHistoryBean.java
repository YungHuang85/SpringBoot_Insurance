package insurance.main.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@Entity
@Table(name = "bonushistory")
@JsonPropertyOrder({"id", "email", "username", "productname", "cost", "date"}) 
public class BonusHistoryBean {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)  // 使用自增的 ID
	@Column(name = "id")  // 表示主鍵
	@JsonProperty("id")
	private int id;        // 自增主鍵

    @Column(name = "email")
    private String email;         // 使用者電子郵件

    @Column(name = "username")
    private String username;      // 使用者姓名

    @Column(name = "productname")
    private String productname;   // 商品名稱

    @Column(name = "cost")
    private int cost;             // 需要點數

    @Column(name = "date")
    private LocalDate date;       // 兌換日期

    // Getter 和 Setter 方法
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getProductname() {
        return productname;
    }

    public void setProductname(String productname) {
        this.productname = productname;
    }

    public int getCost() {
        return cost;
    }

    public void setCost(int cost) {
        this.cost = cost;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }
}
