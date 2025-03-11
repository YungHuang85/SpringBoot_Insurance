package insurance.main.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import insurance.main.config.PasswordUtil;
import insurance.main.dto.LoginRequest;
import insurance.main.dto.MemberDto;
import insurance.main.model.BonusPointsBean;
import insurance.main.model.BonusPointsRepository;
import insurance.main.model.MemberRepository;
import insurance.main.model.MemberService;
import insurance.main.model.MembersBean;
import insurance.main.model.RecaptchaService;
import insurance.main.model.VerificationCodeBean;
import insurance.main.model.VerificationCodeRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private RecaptchaService recaptchaService;

	@Autowired
	private VerificationCodeRepository verificationCodeRepository;
	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private BonusPointsRepository bonusPointsRepository;

	@GetMapping("/CrudMembers")
	public String memberPage(HttpServletRequest request, HttpServletResponse response) {

		memberService.selectAll(request, response);

		return "MemberList";
	}

	/*
	 * @PostMapping("/selectMemberByAdmin")
	 * 
	 * @ResponseBody public ResponseEntity<MemberDto>
	 * selectMemberByAdmin(@RequestParam String id) {
	 * 
	 * MemberDto memberDto = memberService.findById(Long.parseLong(id));
	 * System.out.println(memberDto.toString());
	 * 
	 * return ResponseEntity.ok(memberDto); }
	 */

	@PostMapping("/selectMember")
	@ResponseBody
	public ResponseEntity<MemberDto> selectMember(@RequestBody String json) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			Map<String, String> request = objectMapper.readValue(json, Map.class);
			String idNumber = request.get("idNumber"); // 從 JSON 中提取 idNumber
			System.out.println("接收到的 idNumber: " + idNumber);
			MemberDto memberDto = memberService.findByIdNumber(idNumber);
			System.out.println(memberDto);
			return ResponseEntity.ok(memberDto);

		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.badRequest().build();
		}
	}

	@PostMapping("/selectMemberByAdmin")
	@ResponseBody
	public MemberDto selectMemberByAdmin(@RequestParam("id") Long id) {
		try {
			return memberService.findById(id); // 直接返回服務層的結果
		} catch (Exception e) {
			e.printStackTrace();
			MemberDto errorDto = new MemberDto();
			errorDto.setStatus("error");
			errorDto.setMessage("發生錯誤，請稍後再試");
			return errorDto;
		}
	}

	@PostMapping("/editMemberByAdmin")
	@ResponseBody
	public ResponseEntity<MemberDto> editMemberByAdmin(@ModelAttribute MembersBean membersBean) {
		System.out.println(membersBean.toString());
		MemberDto memberDto = new MemberDto();

		try {
			memberService.updateMember(membersBean);
			memberDto.setStatus("success");
		} catch (Exception e) {
			e.printStackTrace();
			memberDto.setStatus("error");
			memberDto.setMessage("修改失敗，請稍後再試！");
		}

		return ResponseEntity.ok(memberDto);
	}

	@PostMapping("/editMember")
	@ResponseBody
	public ResponseEntity<MemberDto> editMember(@RequestBody MembersBean membersBean) {

		System.out.println(membersBean.toString());
		MemberDto memberDto = new MemberDto();

		try {

			memberService.updateMember(membersBean);

			memberDto.setStatus("success");

		} catch (Exception e) {
			e.printStackTrace();
			memberDto.setStatus("error");
			memberDto.setMessage("修改失敗，請稍後再試！");
		}

		return ResponseEntity.ok(memberDto);
	}

	@PostMapping("/deleteMember")
	@ResponseBody
	public ResponseEntity<MemberDto> deleteMember(MembersBean membersBean) {
		MemberDto memberDto = new MemberDto();
		try {
			memberService.deleteMember(membersBean);
			memberDto.setStatus("success");
		} catch (Exception e) {
			e.printStackTrace();
			memberDto.setStatus("error");
			memberDto.setMessage("無法刪除!@@");
		}
		return ResponseEntity.ok(memberDto);
	}

	@PostMapping("/addMember")
	@ResponseBody
	public ResponseEntity<MemberDto> addMember(MembersBean membersBean) {
		System.out.println(membersBean);
		MemberDto memberDto = new MemberDto();
		try {
			memberService.addMember(membersBean);
			System.out.println(membersBean.getAddress());
			memberDto.setStatus("success");

		} catch (Exception e) {
			e.printStackTrace();
			memberDto.setStatus("error");
			memberDto.setMessage("無法新增!稍後再試!");
		}
		return ResponseEntity.ok(memberDto);
	}

	// 暫時修改新增會員的方法

	@PostMapping("/register")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> register(@RequestBody MembersBean membersBean) {
		System.out.println("接收到的資料: " + membersBean);
		Map<String, Object> response = new HashMap<>();
		try {

			// 驗證資料完整性
			if (membersBean.getAccount() == null || membersBean.getPassword() == null
					|| membersBean.getEmail() == null) {
				response.put("success", false);
				response.put("message", "請填寫完整資訊");
				return ResponseEntity.badRequest().body(response);
			}

			// 新增會員
			// memberService.addMember(membersBean);
			memberService.registerMember(membersBean);
			// 成功回應
			response.put("success", true);
			response.put("message", "註冊成功");
			return ResponseEntity.ok(response);
		} catch (DataIntegrityViolationException e) {
			// 資料庫約束錯誤，例如唯一性約束失敗
			response.put("success", false);
			response.put("message", "帳號或電子郵件已存在，請重新輸入");
			return ResponseEntity.badRequest().body(response);
		} catch (Exception e) {
			// 處理其他例外
			e.printStackTrace();
			response.put("success", false);
			response.put("message", "伺服器錯誤，請稍後再試");
			return ResponseEntity.status(500).body(response);
		}
	}

	public MemberController(RecaptchaService recaptchaService) {
		this.recaptchaService = recaptchaService;
	}


	@PostMapping("/membersLogin")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> login(HttpServletRequest request,
	        @RequestBody LoginRequest loginRequest) {
	    Map<String, Object> response = new HashMap<>();

	    try {
	        String idNumber = loginRequest.getIdNumber();
	        String password = loginRequest.getPassword();

	        // 驗證登入並取得會員資訊
	        MembersBean member = memberService.validateLoginAndGetMember(idNumber, password);
	        if (member != null) {
	            // 登入成功，設置 Session
	            request.getSession().setAttribute("user", idNumber);
	            request.getSession().setAttribute("userInfo",
	                    Map.of("idNumber", idNumber, "name", member.getUsername(), "email", member.getEmail()));

	            // 返回會員資訊
	            response.put("success", true);
	            response.put("message", "登入成功");
	            response.put("data",
	                    Map.of("idNumber", member.getIdNumber(), "sessionId", request.getSession().getId(), "username",
	                            member.getUsername(), "email", member.getEmail(), "account", member.getAccount(),
	                            "birthday", member.getBirthday(), "firstLogin", member.getFirstLogin() // 添加首次登入資訊

	                    ));

	            return ResponseEntity.ok(response);
	        }
	    } catch (IllegalArgumentException e) {
	    	 String errorCode = e.getMessage(); // 使用拋出的消息作為錯誤代碼
	         response.put("success", false);
	         response.put("errorCode", errorCode);
	         response.put("message", getErrorMessage(errorCode)); // 返回具體的錯誤訊息
	         return ResponseEntity.status(401).body(response);
	    } catch (Exception e) {
	    	 e.printStackTrace();
	         response.put("success", false);
	         response.put("errorCode", "SERVER_ERROR");
	         response.put("message", "伺服器發生錯誤，請稍後再試");
	         return ResponseEntity.status(500).body(response);
	    }

	    // 預防意外邏輯分支
	    response.put("success", false);
	    response.put("message", "無法登入，未知錯誤");
	    return ResponseEntity.status(500).body(response);
	}
	
	private String getErrorMessage(String errorCode) {
	    switch (errorCode) {
	        case "NOT_REGISTERED":
	            return "此帳號尚未註冊";
	        case "WRONG_PASSWORD":
	            return "密碼錯誤";
	        default:
	            return "未知錯誤";
	    }
	}


	@GetMapping("/policy")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> protectedEndpoint(HttpServletRequest request) {
		String userId = (String) request.getSession().getAttribute("user");
		if (userId != null) {
			// 驗證通過，返回成功訊息
			return ResponseEntity.ok(Map.of("success", true, "message", "驗證成功", "userId", userId));
		} else {
			// Session 不存在，返回未授權
			return ResponseEntity.status(401).body(Map.of("success", false, "message", "未授權，請先登入"));
		}
	}

	@PostMapping("/logout")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> logout(HttpServletRequest request) {
		// 清除 Session
		request.getSession().invalidate();

		return ResponseEntity.ok(Map.of("success", true, "message", "登出成功"));
	}

	// 忘記密碼
	/*
	 * @PostMapping("/memberForgotPwd")
	 * 
	 * @ResponseBody public Map<String, String> forgotPwd(@RequestParam String
	 * idNumber, @RequestParam String phone) throws MessagingException { Map<String,
	 * String> response = new HashMap<>(); MemberDto memberDto =
	 * memberService.forgotPwd(idNumber, phone);
	 * 
	 * switch (memberDto.getCode()) { case -1: response.put("errorMessage",
	 * "身份證字號有誤，請重新輸入"); break; case -2: response.put("errorMessage",
	 * "手機號碼有誤，請重新輸入"); break; case 0: String resetLink =
	 * memberService.generateResetPasswordLink(memberDto.getMember());
	 * memberService.sendResetPasswordEmail(memberDto.getMember(), resetLink);
	 * response.put("successMessage", "有效時間為10分鐘，請於有效時間內操作"); break; } return
	 * response; }
	 */

	/*
	 * @PostMapping("/memberForgotPwd")
	 * 
	 * @ResponseBody public Map<String, String> forgotPwd(@RequestParam String
	 * idNumber, @RequestParam String phone) throws MessagingException { Map<String,
	 * String> response = new HashMap<>(); MemberDto memberDto =
	 * memberService.forgotPwd(idNumber, phone);
	 * 
	 * switch (memberDto.getCode()) { case -1: response.put("errorMessage",
	 * memberDto.getMessage()); break; case -2: response.put("errorMessage",
	 * memberDto.getMessage()); break; case 0: String verificationCode =
	 * memberService.generateVerificationCode();
	 * memberService.sendVerificationCodeEmail(memberDto.getMember(),
	 * verificationCode); response.put("successMessage", "驗證碼已發送至您的信箱，請於有效時間內完成操作");
	 * break; } return response; }
	 */
	/*
	 * @PostMapping("/memberForgotPwd")
	 * 
	 * @ResponseBody public Map<String, String> forgotPwd(@RequestBody Map<String,
	 * String> payload) throws MessagingException { String idNumber =
	 * payload.get("idNumber"); String phone = payload.get("phone");
	 * 
	 * Map<String, String> response = new HashMap<>(); MemberDto memberDto =
	 * memberService.forgotPwd(idNumber, phone);
	 * 
	 * switch (memberDto.getCode()) { case -1: response.put("errorMessage",
	 * memberDto.getMessage()); break; case -2: response.put("errorMessage",
	 * memberDto.getMessage()); break; case 0: String verificationCode =
	 * memberService.generateVerificationCode();
	 * memberService.saveVerificationCode(memberDto.getMember(), verificationCode);
	 * memberService.sendVerificationCodeEmail(memberDto.getMember(),
	 * verificationCode); response.put("successMessage", "驗證碼已發送至您的信箱，請於有效時間內完成操作");
	 * break; } return response;
	 * 
	 * }
	 */
	@PostMapping("/memberForgotPwd")
	@ResponseBody
	public Map<String, String> forgotPwd(@RequestBody Map<String, String> payload) {
		String idNumber = payload.get("idNumber");
		String phone = payload.get("phone");

		// 驗證會員資料
		MemberDto memberDto = memberService.forgotPwd(idNumber, phone);

		if (memberDto.getCode() == -1) {
			return Map.of("errorMessage", "查無此會員，請確認身份證字號");
		} else if (memberDto.getCode() == -2) {
			return Map.of("errorMessage", "為註冊時填寫之號碼");
		}

		// 發送驗證碼
		String verificationCode = memberService.generateVerificationCode(); // 生成驗證碼
		try {
			memberService.sendVerificationCodeEmail(memberDto.getMember(), verificationCode); // 發送郵件
			memberService.saveVerificationCode(memberDto.getMember(), verificationCode); // 保存驗證碼到資料庫
		} catch (Exception e) {
			return Map.of("errorMessage", "系統錯誤，無法發送驗證碼");
		}

		// 隱藏 email 的部分資訊
		String maskedEmailValue = maskEmail(memberDto.getMember().getEmail());

		// 返回結果給前端，包括驗證碼前4碼和隱藏的 email
		String codePrefix = verificationCode.split("-")[0]; // 提取前4碼
		return Map.of("successMessage", "驗證碼已發送至您的信箱，請於10分鐘內完成驗證", "verificationCodePrefix", codePrefix, "maskedEmail",
				maskedEmailValue);
	}

	@GetMapping("/verificationCodePrefix")
	@ResponseBody
	public Map<String, String> getVerificationCodePrefix(@RequestParam("idNumber") String idNumber) {
		System.out.println(idNumber);
		Optional<MembersBean> memberOptional = memberRepository.findByIdNumber(idNumber);
		if (memberOptional.isEmpty()) {
			return Map.of("errorMessage", "會員不存在");
		}

		Integer memberId = memberOptional.get().getId();
		Optional<VerificationCodeBean> optionalCode = verificationCodeRepository
				.findFirstByMemberIdOrderByIdDesc(memberId);

		if (optionalCode.isPresent()) {
			VerificationCodeBean codeBean = optionalCode.get();
			String codePrefix = codeBean.getCode().split("-")[0];
			return Map.of("verificationCodePrefix", codePrefix);
		}

		return Map.of("errorMessage", "驗證碼不存在或已過期");
	}

	// email
	@GetMapping("/memberEmail")
	@ResponseBody
	public Map<String, String> getMemberEmail(@RequestParam("idNumber") String idNumber) {
		System.out.println("收到的身份證字號: " + idNumber);

		// 查詢會員
		Optional<MembersBean> memberOptional = memberRepository.findByIdNumber(idNumber);
		if (memberOptional.isEmpty()) {
			return Map.of("errorMessage", "會員不存在");
		}

		MembersBean member = memberOptional.get();

		// 隱碼處理 email
		String maskedEmail = maskEmail(member.getEmail());
		return Map.of("maskedEmail", maskedEmail);
	}

	// 方法：隱碼 email
	private String maskEmail(String email) {
		if (email == null || !email.contains("@")) {
			return email; // 如果 email 無效，返回原始值
		}

		String[] parts = email.split("@");
		String localPart = parts[0]; // @ 前的部分
		String domainPart = parts[1]; // @ 後的部分

		// 本地部分隱碼處理：保留首3碼和末3碼，中間補充與隱藏字符數相等的 '*'
		String maskedLocal = localPart.length() > 6
				? localPart.substring(0, 3) + "*".repeat(localPart.length() - 6)
						+ localPart.substring(localPart.length() - 3)
				: localPart.substring(0, 1) + "*".repeat(localPart.length() - 1);

		// 域名部分隱碼處理：保留首3碼和末3碼，中間補充與隱藏字符數相等的 '*'
		String maskedDomain = domainPart.length() > 6
				? domainPart.substring(0, 3) + "*".repeat(domainPart.length() - 6)
						+ domainPart.substring(domainPart.length() - 3)
				: domainPart.substring(0, 1) + "*".repeat(domainPart.length() - 1);

		return maskedLocal + "@" + maskedDomain;
	}

	@PostMapping("/verifyCode")
	@ResponseBody
	public Map<String, String> verifyCode(@RequestBody Map<String, String> payload) {
		String idNumber = payload.get("idNumber");
		String userInputCode = payload.get("verificationCode");

		// 根據 idNumber 查找會員
		Optional<MembersBean> memberOptional = memberRepository.findByIdNumber(idNumber);
		if (memberOptional.isEmpty()) {
			return Map.of("errorMessage", "會員不存在");
		}

		Integer memberId = memberOptional.get().getId();
		Optional<VerificationCodeBean> optionalCode = verificationCodeRepository
				.findFirstByMemberIdOrderByIdDesc(memberId);

		if (optionalCode.isPresent()) {
			VerificationCodeBean codeBean = optionalCode.get();

			// 檢查是否過期
			if (codeBean.getExpiryDate().isBefore(LocalDateTime.now())) {
				return Map.of("errorMessage", "驗證碼已過期");
			}

			// 比對後4碼
			String correctCodeSuffix = codeBean.getCode().split("-")[1];
			if (correctCodeSuffix.equals(userInputCode)) {
				return Map.of("successMessage", "驗證碼正確");
			}
		}

		return Map.of("errorMessage", "驗證碼輸入錯誤或已失效");
	}

	@PostMapping("/MemberResetPassword")
	@ResponseBody
	public ResponseEntity<Void> resetPassword(@RequestBody Map<String, String> payload) {
		String idNumber = payload.get("idNumber");
		String newPassword = payload.get("newPassword");
		String confirmPassword = payload.get("confirmNewPassword");

		// 驗證新密碼與確認密碼是否一致
		if (!newPassword.equals(confirmPassword)) {
			return ResponseEntity.badRequest().build();
		}

		// 查找會員
		Optional<MembersBean> memberOptional = memberRepository.findByIdNumber(idNumber);
		if (memberOptional.isEmpty()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
		}

		MembersBean member = memberOptional.get();

		// 加密新密碼並保存
		String hashedPassword = PasswordUtil.hashPassword(newPassword); // 加密密碼
		member.setPassword(hashedPassword);

		memberRepository.save(member);

		return ResponseEntity.ok().build();
	}

	@PostMapping("/addpoints")
	public ResponseEntity<Map<String, Object>> addPoints(@RequestBody Map<String, String> request) {
		String username = request.get("username");
		String email = request.get("email");
		Map<String, Object> response = new HashMap<>();

		// 呼叫加點數邏輯
		boolean success = memberService.addPoints(username,email, 100);

		if (success) {
			response.put("success", true);
			response.put("message", "點數增加成功");
			return ResponseEntity.ok(response);
		} else {
			response.put("success", false);
			response.put("message", "使用者不存在，無法增加點數");
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
		}
	}
	
	public boolean addPoints(String username,String email, int pointsToAdd) {
		// 建立新的 PointsBean 實體並直接新增
		BonusPointsBean pointsBean = new BonusPointsBean();
	    pointsBean.setUsername(username);
	    pointsBean.setEmail(email);
	    pointsBean.setPoints(pointsToAdd);

	    // 將數據保存到資料庫
	    bonusPointsRepository.save(pointsBean);
	    System.out.println("點數新增成功，Email: " + email + " 新點數: " + pointsToAdd);
	    return true;
	}
	
	@GetMapping("/getpoints")
	public ResponseEntity<Map<String, Object>> getPoints(@RequestParam String email) {
        Map<String, Object> response = new HashMap<>();

        // 查詢點數（避免 findByEmail 可能回傳 null）
        BonusPointsBean pointsBean = bonusPointsRepository.findByEmail(email);

        if (pointsBean != null) {
            response.put("success", true);
            response.put("points", pointsBean.getPoints());
        } else {
            response.put("success", false);
            response.put("message", "未找到該用戶的點數記錄");
        }

        return ResponseEntity.ok(response);
    }
	//以下是會員分析
	@GetMapping("/api/stats/summary")
	public ResponseEntity<Map<String, Long>> getSummary() {
	    Map<String, Long> result = new HashMap<>();
	    result.put("monthlyRegistrations", memberService.getMonthlyRegistrations());
	    result.put("totalMembers", memberService.getTotalMembers());
	    return ResponseEntity.ok(result);
	}

	@GetMapping("/api/stats/trend")
	public ResponseEntity<List<Map<String, Object>>> getRegistrationTrend() {
	    List<Map<String, Object>> trend = memberService.getRegistrationTrend();
	    return ResponseEntity.ok(trend);
	}
	
	@GetMapping("/api/stats/age-distribution")
	public ResponseEntity<List<Map<String, Object>>> getAgeDistribution() {
	    List<Map<String, Object>> distribution = memberService.getAgeDistribution();
	    return ResponseEntity.ok(distribution);
	}
	
	@GetMapping("/api/stats/download")
	public void downloadStats(HttpServletResponse response) throws IOException {
	    response.setContentType("text/csv");
	    response.setCharacterEncoding("UTF-8"); // 避免亂碼
	    response.setHeader("Content-Disposition", "attachment; filename=member_stats.csv");

	    PrintWriter writer = response.getWriter();

	    // 1. 總覽數據
	    writer.println("類別,數值");
	    writer.println("monthlyRegistrations," + memberService.getMonthlyRegistrations());
	    writer.println("totalMembers," + memberService.getTotalMembers());

	    // 2. 每月註冊趨勢
	    writer.println();
	    writer.println("月份,註冊人數");

	    List<Map<String, Object>> monthlyTrend = memberService.getRegistrationTrend();
	    for (Map<String, Object> record : monthlyTrend) {
	        String month = record.get("month") != null ? record.get("month").toString() : "未知";
	        String count = record.get("registrations") != null ? record.get("registrations").toString() : "0"; // ✅ 避免 null
	        writer.println(month + "," + count);
	    }

	    // 3. 年齡分布
	    writer.println();
	    writer.println("年齡區間,人數");

	    List<Map<String, Object>> ageDistribution = memberService.getAgeDistribution();
	    for (Map<String, Object> record : ageDistribution) {
	        String ageRange = record.get("ageRange") != null ? record.get("ageRange").toString() : "未知";
	        String count = record.get("count") != null ? record.get("count").toString() : "0"; // ✅ 避免 null
	        writer.println(ageRange + "," + count);
	    }

	    writer.flush();
	    writer.close();
	}

}

