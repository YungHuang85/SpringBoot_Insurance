package insurance.main.model;

import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Component;

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
@Component
public class ClientBean {
	
	@Id
	@Column(name="insuranceNumber")
	private String insuranceNumber;
	
	@Column(name="bonusPoints")
	private String bonusPoints;
	
	@Column(name="account")
	private String account;
	
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
	private String product;
	
	@Column(name="location")
	private String location;
	
	@Column(name="startTime")
	private String startTime;
	
	@Column(name="endTime")
	private String endTime;
	
	@Column(name="sumAssured")
	private String sumAssured;
	
	@Column(name="premiums")
	private String premiums;
	
	@Column(name="medicalTreatment")
	private String medicalTreatment;
	
	@Column(name="overseasIllness")
	private String overseasIllness;
	
	@Column(name="overseasFlights")
	private String overseasFlights;
	
	@Column(name="totalCost")
	private String totalCost;
	
	@Column(name="profilePicture")
	private byte[] profilePicture;
	
	public String getProfilePictureBase64() {
	    if (this.profilePicture != null) {
	        return Base64.getEncoder().encodeToString(this.profilePicture);
	    }
	    return null; // 若無圖片，返回空值
	}
	
	
	public byte[] getProfilePicture() {
		return profilePicture;
	}


	public void setProfilePicture(byte[] profilePicture) {
		this.profilePicture = profilePicture;
	}


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
    private List<BeneBean1> beneficiaries;

	public ClientBean() {
		super();
	}
	
		
	public List<BeneBean1> getBeneficiaries() {
	    return beneficiaries;
	}
	public String getInsuranceNumber() {
		return insuranceNumber;
	}

	public void setInsuranceNumber(String insuranceNumber) {
		this.insuranceNumber = insuranceNumber;
	}
	
	public String getBonusPoints() {
		return bonusPoints;
	}

	public void setBonusPoints(String bonusPoints) {
		this.bonusPoints = bonusPoints;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
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


	public String getProduct() {
		return product;
	}


	public void setProduct(String product) {
		this.product = product;
	}

	
	public String getLocation() {
		return location;
	}


	public void setLocation(String location) {
		this.location = location;
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
	
	public String getMedicalTreatment() {
		return medicalTreatment;
	}

	public void setMedicalTreatment(String medicalTreatment) {
		this.medicalTreatment = medicalTreatment;
	}

	public String getOverseasIllness() {
		return overseasIllness;
	}

	public void setOverseasIllness(String overseasIllness) {
		this.overseasIllness = overseasIllness;
	}

	public String getOverseasFlights() {
		return overseasFlights;
	}


	public void setOverseasFlights(String overseasFlights) {
		this.overseasFlights = overseasFlights;
	}

	public String getTotalCost() {
		return totalCost;
	}

	public void setTotalCost(String totalCost) {
		this.totalCost = totalCost;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
}
