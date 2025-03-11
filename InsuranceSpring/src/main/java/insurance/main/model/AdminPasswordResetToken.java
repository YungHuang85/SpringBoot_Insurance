package insurance.main.model;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class AdminPasswordResetToken {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(nullable = false, unique = true)
	private String token;

	@ManyToOne(fetch = FetchType.LAZY) // 建立多對一關聯
	@JoinColumn(name = "admin_id", nullable = false) // 指定外鍵名稱對應到 AdminBean 的主鍵
	private AdminBean admin; // 使用 AdminBean 來表示對應的管理員

	@Column(nullable = false)
	private LocalDateTime expiryDate;

	// Getters and Setters
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public AdminBean getAdmin() {
		return admin;
	}

	public void setAdmin(AdminBean admin) {
		this.admin = admin;
	}

	public LocalDateTime getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(LocalDateTime expiryDate) {
		this.expiryDate = expiryDate;
	}

	@Override
	public String toString() {
		return "PasswordResetToken [id=" + id + ", token=" + token + ", admin=" + admin.toString() + ", expiryDate="
				+ expiryDate + "]";
	}

}
