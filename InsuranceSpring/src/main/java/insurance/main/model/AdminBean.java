package insurance.main.model;

import java.sql.Date;
import java.util.Arrays;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "admin")
public class AdminBean {

	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name = "name")
	private String name;

	@Column(name = "username")
	private String username;

	@Column(name = "password")
	private String password;

	@Column(name = "createDate")
	private Date date;

	@Column(name = "admin_email")
	private String adminEmail;

	@Column(name = "password_last_updated")
	private String passwordUpdateTime;

	@Column(name = "login_fail_count", nullable = false)
	private int loginFailCount = 0; // 預設為0

	@Column(name = "profile_picture", columnDefinition = "VARBINARY(MAX)")
	private byte[] profilePicture; // 新增屬性

	@Column(name = "profile_picture_image_type")
	private String profilePictureImageType; // 新增屬性

	@Column(name = "modules")
	private String modules;

	public AdminBean(Integer id, String name, String username, String password, Date date, String adminEmail,
			String passwordUpdateTime, byte[] profilePicture, String modules) {
		this.id = id;
		this.name = name;
		this.username = username;
		this.password = password;
		this.date = date;
		this.adminEmail = adminEmail;
		this.passwordUpdateTime = passwordUpdateTime;
		this.profilePicture = profilePicture; // 初始化屬性
		this.modules = modules;
	}

	public AdminBean() {
	}

	// Getter 和 Setter 方法
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getAdminEmail() {
		return adminEmail;
	}

	public void setAdminEmail(String adminEmail) {
		this.adminEmail = adminEmail;
	}

	public String getPasswordUpdateTime() {
		return passwordUpdateTime;
	}

	public void setPasswordUpdateTime(String passwordUpdateTime) {
		this.passwordUpdateTime = passwordUpdateTime;
	}

	public int getLoginFailCount() {
		return loginFailCount;
	}

	public void setLoginFailCount(int loginFailCount) {
		this.loginFailCount = loginFailCount;
	}

	public byte[] getProfilePicture() {
		return profilePicture;
	}

	public void setProfilePicture(byte[] profilePicture) {
		this.profilePicture = profilePicture;
	}

	public String getProfilePictureImageType() {
		return profilePictureImageType;
	}

	public void setProfilePictureImageType(String profilePictureImageType) {
		this.profilePictureImageType = profilePictureImageType;
	}

	@Override
	public String toString() {
		return "AdminBean [id=" + id + ", name=" + name + ", username=" + username + ", password=" + password
				+ ", date=" + date + ", adminEmail=" + adminEmail + ", passwordUpdateTime=" + passwordUpdateTime
				+ ", loginFailCount=" + loginFailCount + ", profilePicture=" + Arrays.toString(profilePicture)
				+ ", profilePictureImageType=" + profilePictureImageType + ", modules=" + modules + "]";
	}

	public String getModules() {
		return modules;
	}

	public void setModules(String modules) {
		this.modules = modules;
	}

}
