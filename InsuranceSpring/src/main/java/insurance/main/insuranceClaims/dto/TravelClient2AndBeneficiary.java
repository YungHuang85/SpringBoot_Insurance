package insurance.main.insuranceClaims.dto;

public class TravelClient2AndBeneficiary {
	
	

	public TravelClient2AndBeneficiary(String beneficiaryName, String beneficiaryID, String insuranceNumber, String username,
			String id_number, String birthday, String phone, String email, String address,
			String insuranceProduct) {
		super();
		this.insuranceNumber = insuranceNumber;
		this.username = username;
		this.id_number = id_number;
		this.birthday = birthday;
		this.phone = phone;
		this.email = email;
		this.address = address;
		this.insuranceProduct = insuranceProduct;
		this.beneficiaryName = beneficiaryName;
		this.beneficiaryID = beneficiaryID;
	}

	private String insuranceNumber;

	private String username;


	private String id_number;

	private String birthday;

	private String phone;

	private String email;

	private String address;

	private String insuranceProduct;

	private String beneficiaryName;
	
	private String beneficiaryID;
	

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

	public String getBeneficiaryName() {
		return beneficiaryName;
	}

	public void setBeneficiaryName(String beneficiaryName) {
		this.beneficiaryName = beneficiaryName;
	}

	public String getBeneficiaryID() {
		return beneficiaryID;
	}

	public void setBeneficiaryID(String beneficiaryID) {
		this.beneficiaryID = beneficiaryID;
	}

}
