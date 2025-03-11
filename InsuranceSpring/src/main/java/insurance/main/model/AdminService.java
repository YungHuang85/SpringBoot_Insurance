package insurance.main.model;

import java.time.LocalDateTime;
import java.util.Objects;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import insurance.main.dto.AdminDto;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

//業務邏輯
@Service
public class AdminService {

	@Autowired
	private AdminRepository adminRepository;

	@Autowired
	private AdminPasswordResetTokenRepository passwordResetTokenRepository;

	@Autowired
	private JavaMailSender mailSender;

	@Transactional
	public AdminDto login(String username, String password) {

		// 1.利用username查詢DB
		// 若1為空則username錯誤
		// 若1不為空則再利用密碼查詢DB
		AdminBean adminBean = adminRepository.findByUsername(username);// 取得物件
		// 結果要放到dto裡，new一個dto
		AdminDto adminDto = new AdminDto();

		if (adminBean == null) {
			adminDto.setCode(-1); // 表示使用者名稱不存在
		} else if (adminBean.getLoginFailCount() >= 3) {
			adminDto.setCode(-3); // 帳號鎖定
			return adminDto;
		} else if (!Objects.equals(adminBean.getPassword(), password)) {
			adminRepository.incrementLoginFailCount(adminBean.getId().longValue()); // 增加錯誤次數
			adminDto.setCode(-2); // 表示密碼錯誤

		}

		else {
			adminDto.setCode(0); // 登入成功
			adminDto.setAdmin(adminBean);
			adminRepository.resetLoginFailCount(adminBean.getId().longValue());
		}

		return adminDto;
	}

	@Transactional
	public AdminDto forgotPwd(String username, String adminEmail) {

		// 1.利用username查詢DB
		// 若1為空則username錯誤
		// 若1不為空則再利用密碼查詢DB
		AdminBean adminBean = adminRepository.findByUsername(username);// 取得物件
		// 結果要放到dto裡，new一個dto
		AdminDto adminDto = new AdminDto();

		if (adminBean == null) {
			adminDto.setCode(-1); // 表示使用者名稱不存在
		} else if (!Objects.equals(adminBean.getAdminEmail(), adminEmail)) {
			adminDto.setCode(-2); // 表示信箱與密碼不符
		} else {
			adminDto.setCode(0); // 驗證成功
			adminDto.setAdmin(adminBean);
		}

		return adminDto;
	}

	public String generateResetPasswordLink(AdminBean adminBean) {
		// 產生唯一 Token，例如 UUID
		String token = UUID.randomUUID().toString();

		// 保存到資料庫中
		AdminPasswordResetToken resetToken = new AdminPasswordResetToken();
		resetToken.setToken(token);
		resetToken.setAdmin(adminBean);
		resetToken.setExpiryDate(LocalDateTime.now().plusHours(1)); // 有效 1 小時
		System.out.println(resetToken.toString());
		passwordResetTokenRepository.save(resetToken);

		// 密碼重設連結
		String baseUrl = "http://127.0.0.1:8081/resetPassword";
		return baseUrl + "?token=" + token;
	}

	public void sendResetPasswordEmail(AdminBean adminBean, String resetLink) throws MessagingException {
		MimeMessage mimeMessage = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
		helper.setTo(adminBean.getAdminEmail());
		helper.setSubject("重設密碼通知");
		helper.setText("<p>親愛的使用者 <strong>" + adminBean.getUsername() + "</strong>：</p>"
				+ "<p>我們收到了您的密碼重設請求。請點擊以下連結進行重設：</p>" + "<a href=\"" + resetLink + "\">重設密碼</a>"
				+ "<p>若您未提出此請求，請忽略此信件。</p>" + "<p>此信件由系統自動發送，請勿回覆。</p>", true);
		mailSender.send(mimeMessage);
	}

}
