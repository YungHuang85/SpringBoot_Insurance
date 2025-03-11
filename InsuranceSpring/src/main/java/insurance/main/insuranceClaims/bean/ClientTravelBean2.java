package insurance.main.insuranceClaims.bean;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;

@Entity
@Table(name="travelClient2")
public class ClientTravelBean2 {
	
	@Id
	@Column(name="insuranceNumber")
	private String insuranceNumber;
	
	@Column(name="username")
	private String username;
	
	@Column(name="id_number")
	private String id_number;
	
	@Column(name="birthday")
	private String birthday;
	
	@Column(name="gender")
	private String gender;
	
	@Column(name="phone")
	private String phone;
	
	@Column(name="email")
	private String email;
	
	@Column(name="address")
	private String address;
	
	@Column(name="product")
	private String insuranceProduct;
	
	@Column(name="location")
	private String country;
	
	@Column(name="startTime")
	private String startTime;
	
	@Column(name="endTime")
	private String endTime;
	
	@Column(name="sumAssured")
	private String sumAssured;
	
	@Column(name="premiums")
	private String premiums;
	
	@Column(name="updateTime")
	private String updateTime;
	
	@PrePersist //hibernatet不會處理default getdate(), 要自己設定預設儲存時間
    public void prePersist() {
        if (this.updateTime == null) {
            // 如果 updateTime 為 null，則手動設置為當前時間
            this.updateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        }
    }
	
	@OneToMany(mappedBy="client", cascade=CascadeType.ALL, fetch=FetchType.LAZY)
    private List<BeneBean2> beneficiaries;

	public ClientTravelBean2() {
		super();
	}
	
		
	public List<BeneBean2> getBeneficiaries() {
	    return beneficiaries;
	}
	public String getInsuranceNumber() {
		return insuranceNumber;
	}

	public void setInsuranceNumber(String insuranceNumber) {
		this.insuranceNumber = insuranceNumber;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getId_number() {
		return id_number;
	}

	public void setId_number(String id_number) {
		this.id_number = id_number;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getInsuranceProduct() {
		return insuranceProduct;
	}

	public void setInsuranceProduct(String insuranceProduct) {
		this.insuranceProduct = insuranceProduct;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getSumAssured() {
		return sumAssured;
	}

	public void setSumAssured(String sumAssured) {
		this.sumAssured = sumAssured;
	}

	public String getPremiums() {
		return premiums;
	}

	public void setPremiums(String premiums) {
		this.premiums = premiums;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
}
