package insurance.main.controller;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import insurance.main.dto.AdminDto;
import insurance.main.model.AdminBean;
import insurance.main.model.AdminPasswordResetToken;
import insurance.main.model.AdminPasswordResetTokenRepository;
import insurance.main.model.AdminRepository;
import insurance.main.model.AdminService;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
// http://localhost:8081/adminLogin

@Controller
public class AdminController {

	@Autowired
	private AdminService adminService;

	@Autowired
	private AdminRepository adminRepository;
	@Autowired
	private AdminPasswordResetTokenRepository adminPasswordResetTokenRepository;

	private static final String LOG_DIRECTORY = "C:/log/";

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@GetMapping("/adminLogin")
	public String loginPage() {
		return "AdminLogin";
	}

	@PostMapping("/Login")
	public String login(HttpServletRequest request, HttpServletResponse response) {

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		AdminDto adminDto = adminService.login(username, password);
		System.out.println(adminDto.toString());
		switch (adminDto.getCode()) {
		case -1:
			request.setAttribute("usernameError", "帳號有誤，請重新輸入");
			break;
		case -2:
			request.setAttribute("passwordError", "密碼有誤，請重新輸入");
			break;
		case -3:
			request.setAttribute("accountLocked", "密碼輸入錯誤已達3次，請聯繫管理員或重設密碼");
			break;
		case 0:
			HttpSession session = request.getSession();
			session.setAttribute("AdminBean", adminDto.getAdmin());
			request.setAttribute("AdminBean", adminDto.getAdmin());
			return "redirect:/list";
		}
		return "AdminLogin";
	}

	@GetMapping("/Logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession(false);
		if (session != null) {

//			session.invalidate(); // 使 session 無效
			// 因為記住我改寫request.getSession()
			request.getSession().invalidate();

		}

		return "AdminLogin";
	}

	@GetMapping("/AdminList")
	public String Admin() {
		return "AdminList";
	}
	/*
	 * @PostMapping("/selectAdmin")
	 * 
	 * @ResponseBody public void selectMember(@RequestParam String name) {
	 * 
	 * adminService.findById(Long.parseLong(id));
	 * 
	 * }
	 */

	// 重設密碼
	@PostMapping("/forgotPwd")
	@ResponseBody
	public Map<String, String> forgotPwd(@RequestParam String username, @RequestParam String adminEmail)
			throws MessagingException {
		Map<String, String> response = new HashMap<>();
		AdminDto adminDto = adminService.forgotPwd(username, adminEmail);

		switch (adminDto.getCode()) {
		case -1:
			response.put("errorMessage", "帳號有誤，請重新輸入");
			break;
		case -2:
			response.put("errorMessage", "email有誤，請重新輸入");
			break;
		case 0:
			String resetLink = adminService.generateResetPasswordLink(adminDto.getAdmin());
			adminService.sendResetPasswordEmail(adminDto.getAdmin(), resetLink);
			response.put("successMessage", "有效時間為1小時，請於有效時間內操作");
			break;
		}
		return response;
	}

	@GetMapping("/resetPassword")
	public String resetPasswordPage(@RequestParam("token") String token, Model model) {
		AdminPasswordResetToken resetToken = adminPasswordResetTokenRepository.findByToken(token);

		if (resetToken == null || resetToken.getExpiryDate().isBefore(LocalDateTime.now())) {
			model.addAttribute("errorMessage", "無效或過期的重設密碼連結。");
			return "errorPage"; // 顯示錯誤頁面
		}

		model.addAttribute("token", token);
		return "memberJSP/resetPassword"; // 顯示修改密碼頁面
	}

	@PostMapping("/resetPassword")
	public String resetPassword(@RequestParam("token") String token, @RequestParam("newPassword") String newPassword,
			@RequestParam("confirmPassword") String confirmPassword, Model model) {
		if (!newPassword.equals(confirmPassword)) {
			model.addAttribute("errorMessage", "兩次密碼輸入不一致。");
			model.addAttribute("token", token);
			return "resetPassword";
		}

		AdminPasswordResetToken resetToken = adminPasswordResetTokenRepository.findByToken(token);
		System.out.println(resetToken.toString());

		if (resetToken == null || resetToken.getExpiryDate().isBefore(LocalDateTime.now())) {
			model.addAttribute("errorMessage", "無效或過期的重設密碼連結。");
			return "errorPage"; // 顯示錯誤頁面s
		}

		AdminBean admin = resetToken.getAdmin();
		System.out.println(admin.toString());
		admin.setPassword(newPassword);
		adminRepository.save(admin);

		// 刪除 Token
		adminPasswordResetTokenRepository.delete(resetToken);
		adminRepository.resetLoginFailCount(admin.getId().longValue());

		model.addAttribute("successMessage", "密碼修改成功，請使用新密碼登入");
		return "AdminLogin"; // 返回登入頁面
	}

	@GetMapping("/download")
	public ResponseEntity<Resource> downloadLog(@RequestParam(required = false) String date) {
	    String fileName;
	    if (date != null && date.matches("\\d{4}-\\d{2}-\\d{2}")) {
	        fileName = "info-" + date + ".log";
	    } else {
	        fileName = "info.log"; // 預設下載當前的 log
	    }

	    Path filePath = Paths.get("C:\\log", fileName);

	    File logFile = filePath.toFile();
	    if (!logFile.exists() || !logFile.isFile()) {
	        // **如果找不到指定日期的 Log，改為提供 info.log**
	        filePath = Paths.get("C:\\log", "info.log");
	        logFile = filePath.toFile();
	        
	        if (!logFile.exists() || !logFile.isFile()) {
	            System.out.println("Log file not found: " + filePath.toAbsolutePath());
	            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
	        }
	    }

	    Resource fileResource = new FileSystemResource(logFile);
	    return ResponseEntity.ok()
	            .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + logFile.getName())
	            .body(fileResource);
	}



}
