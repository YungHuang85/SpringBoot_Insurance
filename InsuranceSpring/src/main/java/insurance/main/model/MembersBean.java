
package insurance.main.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "members")
public class MembersBean implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "account")
    private String account;

    @Column(name = "password")
    private String password;

    @Column(name = "username")
    private String username;

    @Column(name = "gender")
    private String gender;

    @Column(name = "birthday")
    private LocalDate birthday;

    @Column(name = "IdNumber", unique = true)
    private String idNumber;

    @Column(name = "phone")
    private String phone;

    @Column(name = "address")
    private String address;

    @Column(name = "email")
    private String email;

    @Column(name = "CreatedAt", updatable = false)
    @CreationTimestamp
    private LocalDateTime createdAt;
    
    @Column(name = "membership", updatable = false)
    private Integer membership;
    
    @Column(name = "firstLogin")
    private Integer firstLogin;

//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "membership", referencedColumnName = "level", nullable = false)
//    private MembershipLevelBean membershipLevel;



	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public LocalDate getBirthday() {
		return birthday;
	}

	public void setBirthday(LocalDate birthday) {
		this.birthday = birthday;
	}


	public String getIdNumber() {
		return idNumber;
	}

	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

//	public MembershipLevelBean getMembershipLevel() {
//		return membershipLevel;
//	}
//
//	public void setMembershipLevel(MembershipLevelBean membershipLevel) {
//		this.membershipLevel = membershipLevel;
//	}
	

	public Integer getMembership() {
		return membership;
	}

	public void setMembership(Integer membership) {
		this.membership = membership;
	}
	


	public String getFormattedCreatedAt() {
		
		if (createdAt != null) {
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			String formattedCreatedAt = createdAt.format(formatter);
			return formattedCreatedAt;
		}

		return null;
	}
	



	public Integer getFirstLogin() {
		return firstLogin;
	}

	public void setFirstLogin(Integer firstLogin) {
		this.firstLogin = firstLogin;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "MembersBean [id=" + id + ", account=" + account + ", password=" + password + ", username=" + username
				+ ", gender=" + gender + ", birthday=" + birthday + ", idNumber=" + idNumber + ", phone=" + phone
				+ ", address=" + address + ", email=" + email + ", createdAt=" + createdAt + ", membership="
				+ membership + "]";
	}
	
	
	
	
}