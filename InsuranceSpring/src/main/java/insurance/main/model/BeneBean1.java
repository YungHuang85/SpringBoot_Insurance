package insurance.main.model;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name="beneficiary")
@Component
public class BeneBean1 {
	@Id
	@Column(name="insuranceNumber")
	private String insuranceNumber;
	
	@Column(name="relationship")
	private String relationship;
	
	@Column(name="beneficiaryName")
	private String beneficiaryName;
	
	@Column(name="beneficiaryID")
	private String beneficiaryID;
	
	@Column(name="beneficiaryBirthday")
	private String beneficiaryBirthday;
	
	@Column(name="beneficiaryGender")
	private String beneficiaryGender;
	
	@Column(name="beneficiaryPhone")
	private String beneficiaryPhone;
	
	@Column(name="beneficiaryAddress")
	private String beneficiaryAddress;
	
	@ManyToOne
	@JoinColumn(name="insuranceNumber", insertable=false, updatable=false)
	private ClientBean client;

	public BeneBean1() {
		super();
	}
	
	public void setClient(ClientBean client) {
        this.client = client;
    }

	public String getInsuranceNumber() {
		return insuranceNumber;
	}

	public void setInsuranceNumber(String insuranceNumber) {
		this.insuranceNumber = insuranceNumber;
	}

	public String getRelationship() {
		return relationship;
	}

	public void setRelationship(String relationship) {
		this.relationship = relationship;
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

	public String getBeneficiaryBirthday() {
		return beneficiaryBirthday;
	}

	public void setBeneficiaryBirthday(String beneficiaryBirthday) {
		this.beneficiaryBirthday = beneficiaryBirthday;
	}

	public String getBeneficiaryGender() {
		return beneficiaryGender;
	}

	public void setBeneficiaryGender(String beneficiaryGender) {
		this.beneficiaryGender = beneficiaryGender;
	}

	public String getBeneficiaryPhone() {
		return beneficiaryPhone;
	}

	public void setBeneficiaryPhone(String beneficiaryPhone) {
		this.beneficiaryPhone = beneficiaryPhone;
	}

	public String getBeneficiaryAddress() {
		return beneficiaryAddress;
	}

	public void setBeneficiaryAddress(String beneficiaryAddress) {
		this.beneficiaryAddress = beneficiaryAddress;
	}
}
