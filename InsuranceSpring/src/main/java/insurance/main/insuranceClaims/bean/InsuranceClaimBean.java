package insurance.main.insuranceClaims.bean;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "insuranceClaim")
public class InsuranceClaimBean {

	@Id
	@Column(name = "policyNumber")
	private String policyNumber;

	@Column(name = "id_number")
	private String idNumber;

	@Column(name = "policyName")
	private String policyName;

	@Column(name = "clientName")
	private String clientName;

	@Column(name = "claimStatus")
	private String claimStatus;

	@Column(name = "idCopy")
	private String idCopy;

	@Column(name = "accountCopy")
	private String accountCopy;

	@Column(name = "proveFile")
	private String proveFile;

	@Column(name = "applicationDate")
	private LocalDate applicationDate;

	@Column(name = "comment")
	private String comment;

	@Column(name = "claimAmount")
	private String claimAmount;

	

	@Column(name = "address")
	private String address;

	@Column(name = "phone")
	private String phone;

	@Column(name = "email")
	private String email;

	@Column(name = "accidentReason")
	private String accidentReason;

	
	@Column(name = "claimCategories")
	private String claimCategories;

	@Column(name = "beneficiaryName")
	private String beneficiaryName;

	@Column(name = "beneficiaryID")
	private String beneficiaryID;

	@Column(name = "bankCode")
	private String bankCode;

	@Column(name = "accountCode")
	private String accountCode;

	@Column(name = "signature")
	private String signature;

	@Column(name = "reviewer")
	private String reviewer;

	public String getIdCopy() {
		return idCopy;
	}

	public void setIdCopy(String idCopy) {
		this.idCopy = idCopy;
	}


	public String getProveFile() {
		return proveFile;
	}

	public void setProveFile(String proveFile) {
		this.proveFile = proveFile;
	}

	public String getReviewer() {
		return reviewer;
	}

	public void setReviewer(String reviewer) {
		this.reviewer = reviewer;
	}


	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
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

	public String getAccidentReason() {
		return accidentReason;
	}

	public void setAccidentReason(String accidentReason) {
		this.accidentReason = accidentReason;
	}


	public String getClaimCategories() {
		return claimCategories;
	}

	public void setClaimCategories(String claimCategories) {
		this.claimCategories = claimCategories;
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

	public String getBankCode() {
		return bankCode;
	}

	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}

	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}

	public String getAccountCode() {
		return accountCode;
	}

	public void setAccountCode(String accountCode) {
		this.accountCode = accountCode;
	}

	public String getIdNumber() {
		return idNumber;
	}

	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getClaimAmount() {
		return claimAmount;
	}

	public void setClaimAmount(String claimAmount) {
		this.claimAmount = claimAmount;
	}

	public String getPolicyNumber() {
		return policyNumber;
	}

	public void setPolicyNumber(String policyNumber) {
		this.policyNumber = policyNumber;
	}

	public String getPolicyName() {
		return policyName;
	}

	public void setPolicyName(String policyName) {
		this.policyName = policyName;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getClaimStatus() {
		return claimStatus;
	}

	public void setClaimStatus(String claimStatus) {
		this.claimStatus = claimStatus;
	}

	public String getAccountCopy() {
		return accountCopy;
	}

	public void setAccountCopy(String accountCopy) {
		this.accountCopy = accountCopy;
	}

	public LocalDate getApplicationDate() {
		return applicationDate;
	}

	public void setApplicationDate(LocalDate applicationDate) {
		this.applicationDate = applicationDate;
	}

}
