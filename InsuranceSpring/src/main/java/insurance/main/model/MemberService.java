package insurance.main.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import insurance.main.config.PasswordUtil;
import insurance.main.dto.MemberDto;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//業務邏輯
@Service
public class MemberService {

	@Autowired
	private MemberRepository memberRepository;
	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private VerificationCodeRepository verificationCodeRepository;

	@Autowired
	private BonusPointsRepository bonusPointsRepository;

	@Transactional
	public void selectAll(HttpServletRequest request, HttpServletResponse response) {
		try {

			List<MembersBean> memberList = memberRepository.findAll();

			// 檢查是否查詢到會員
			if (memberList == null || memberList.isEmpty()) {
				System.out.println("未找到任資料！");

				request.setAttribute("message", "未找到任何會員資料！");
				memberList = new ArrayList<>(); // 確保 memberList 不為 null，這樣 JSP 不會拋出空指針異常
			} else {
				System.out.println("查詢到會員數量：" + memberList.size());
			}

			// 設置查詢結果到請求中，並轉發到 JSP 顯示
			request.setAttribute("memberList", memberList);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "查詢所有會員時發生錯誤：" + e.getMessage());
		}

	}

	public MemberDto findById(Long id) {

		MemberDto memberDto = new MemberDto();
		Optional<MembersBean> bean = memberRepository.findById(id);

		if (bean.isPresent()) {
			memberDto.setStatus("success");
			memberDto.setData(bean.get());
		} else {
			memberDto.setStatus("error");
			memberDto.setMessage("找不到該會員！");
		}
		return memberDto;
	}

	@Transactional
	public void updateMember(MembersBean membersBean) throws Exception {

		memberRepository.save(membersBean);

	}

	@Transactional
	public void deleteMember(MembersBean membersBean) throws Exception {

		memberRepository.delete(membersBean);

	}

	/*
	 * @Transactional public void addMember(MembersBean membersBean) throws
	 * Exception {
	 * 
	 * // MembershipLevelBean memberShipLevelBean = new MembershipLevelBean(); //
	 * memberShipLevelBean.setLevel(4); //
	 * membersBean.setMembershipLevel(memberShipLevelBean);
	 * membersBean.setMembership(4); memberRepository.save(membersBean);
	 * 
	 * }
	 */
	/*
	 * @Transactional(readOnly = true) public boolean validateLogin(String idNumber,
	 * String rawPassword) { Optional<MembersBean> optionalMember =
	 * memberRepository.findByIdNumber(idNumber);
	 * 
	 * if (optionalMember.isPresent()) { MembersBean member = optionalMember.get();
	 * // 驗證密碼是否匹配 return PasswordUtil.verifyPassword(rawPassword,
	 * member.getPassword()); } return false; }
	 */
	@Transactional(readOnly = true)
	public Optional<MembersBean> validateLogin(String idNumber, String rawPassword) {
		Optional<MembersBean> optionalMember = memberRepository.findByIdNumber(idNumber);

		if (optionalMember.isPresent()) {
			MembersBean member = optionalMember.get();
			// 驗證密碼是否匹配
			if (PasswordUtil.verifyPassword(rawPassword, member.getPassword())) {
				return Optional.of(member); // 驗證成功返回會員物件
			}
		}
		return Optional.empty(); // 驗證失敗
	}

	@Transactional
	public MembersBean loginAndUpdateFirstLoginStatus(String idNumber, String rawPassword) {
		Optional<MembersBean> optionalMember = memberRepository.findByIdNumber(idNumber);

		if (optionalMember.isPresent()) {
			MembersBean member = optionalMember.get();
			if (PasswordUtil.verifyPassword(rawPassword, member.getPassword())) {
				// 更新首次登入狀態
				if (member.getFirstLogin() == 0) {
					member.setFirstLogin(1);
					memberRepository.save(member);
					System.out.println("FirstLogin 已更新為 1");

				}
				return member; // 驗證成功，返回會員物件
			}
		}
		throw new IllegalArgumentException("帳號或密碼錯誤");
	}

	@Transactional
	public void registerMember(MembersBean membersBean) {
		// 加密密碼
		String rawPassword = membersBean.getPassword();
		String hashedPassword = PasswordUtil.hashPassword(rawPassword);
		membersBean.setPassword(hashedPassword);

		// 儲存會員資料
		membersBean.setMembership(4);
		membersBean.setFirstLogin(0);

		memberRepository.save(membersBean);
		System.out.println("收到的會員資料: " + membersBean);
	}

	@Transactional
	public void addMember(MembersBean membersBean) throws Exception {

//		MembershipLevelBean memberShipLevelBean = new MembershipLevelBean();
//		memberShipLevelBean.setLevel(4);
//		membersBean.setMembershipLevel(memberShipLevelBean);
		// 加密密碼
		String rawPassword = membersBean.getPassword();
		String hashedPassword = PasswordUtil.hashPassword(rawPassword);
		membersBean.setPassword(hashedPassword);

		membersBean.setMembership(4);
		memberRepository.save(membersBean);

	}

	@Transactional(readOnly = true)
	public MembersBean validateLoginAndGetMember(String idNumber, String rawPassword) {
		Optional<MembersBean> optionalMember = memberRepository.findByIdNumber(idNumber);

		if (optionalMember.isPresent()) {
			MembersBean member = optionalMember.get();
			// 驗證密碼是否匹配
			if (PasswordUtil.verifyPassword(rawPassword, member.getPassword())) {
				loginAndUpdateFirstLoginStatus(idNumber, rawPassword);
				return member;
			}
		}
		return null; // 返回 null 表示驗證失敗
	}

	public MemberDto findByIdNumber(String idNumber) {
		Optional<MembersBean> optionalMember = memberRepository.findByIdNumber(idNumber);

		if (optionalMember.isPresent()) {
			MembersBean member = optionalMember.get();

			// 將資料轉換為 DTO
			MemberDto dto = new MemberDto();
			dto.setStatus("success");
			dto.setData(member); // 確保正確填入
			return dto;

		}

		// 如果找不到會員
		MemberDto dto = new MemberDto();
		dto.setStatus("fail");
		dto.setMessage("會員資料不存在");
		return dto;
	}

//忘記密碼

	public MemberDto forgotPwd(String idNumber, String phone) {
		Optional<MembersBean> memberOptional = memberRepository.findByIdNumber(idNumber);
		MemberDto memberDto = new MemberDto();
		// 若查無資料，回傳錯誤代碼
		if (memberOptional.isEmpty()) {
			memberDto.setCode(-1); // 查無此會員
			memberDto.setMessage("查無此會員，請確認身份證字號");
			return memberDto;
		}

		MembersBean memberBean = memberOptional.get();

		// 比對手機號碼
		if (!Objects.equals(memberBean.getPhone(), phone)) {
			memberDto.setCode(-2); // 手機號碼不匹配
			memberDto.setMessage("手機號碼不正確，請重新輸入");
			return memberDto;
		}

		// 驗證成功，封裝會員資料到 DTO
		memberDto.setCode(0); // 驗證成功
		memberDto.setMessage("驗證成功");
		memberDto.setMember(memberBean);

		return memberDto;
	}

	public String generateVerificationCode() {
		String letters = RandomStringUtils.randomAlphabetic(4).toUpperCase(); // 4個大寫字母
		String numbers = RandomStringUtils.randomNumeric(4); // 4個數字
		return letters + "-" + numbers; // 格式：AXCD-1234
	}

	public void sendVerificationCodeEmail(MembersBean member, String verificationCode) throws MessagingException {
		MimeMessage mimeMessage = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);

		helper.setTo(member.getEmail());
		helper.setSubject("e險無憂重設密碼驗證碼通知");
		helper.setText("<p>親愛的會員 <strong>" + member.getUsername() + "</strong>：</p>"
				+ "<p>我們收到了您的密碼重設請求。請於10分鐘內於e險無憂網站會員驗證畫面，輸入以下後4碼數字：</p>" + "<p><strong>" + verificationCode
				+ "</strong></p>" + "<p>若您未提出此請求，請忽略此信件。</p>" + "<p>此信件由系統自動發送，請勿回覆。</p>", true);

		mailSender.send(mimeMessage);
	}

	@Transactional
	public void saveVerificationCode(MembersBean member, String verificationCode) {
		VerificationCodeBean code = new VerificationCodeBean();
		code.setMember(member);
		code.setCode(verificationCode);
		code.setExpiryDate(LocalDateTime.now().plusMinutes(10)); // 設置10分鐘有效期
		verificationCodeRepository.save(code);
	}

	public boolean verify(String idNumber, String userInputCode) {

		Optional<VerificationCodeBean> optionalCode = verificationCodeRepository.findByIdNumber(idNumber);

		if (optionalCode.isPresent()) {
			VerificationCodeBean codeBean = optionalCode.get();
			String fullCode = codeBean.getCode(); // 完整驗證碼，例如 "ZZLW-7533"

			// 取驗證碼的後4位數字
			String correctCodeSuffix = fullCode.split("-")[1]; // "7533"

			// 比對使用者輸入的後4位是否正確
			return correctCodeSuffix.equals(userInputCode);
		}
		return false; // 如果驗證碼不存在
	}

	@Transactional
	public boolean resetPassword(String idNumber, String newPassword) {
		Optional<MembersBean> optionalMember = memberRepository.findByIdNumber(idNumber);

		if (optionalMember.isPresent()) {
			MembersBean member = optionalMember.get();

			// 加密新密碼並更新
			String hashedPassword = PasswordUtil.hashPassword(newPassword);
			member.setPassword(hashedPassword);

			memberRepository.save(member); // 儲存更新
			return true;
		}
		return false; // 如果會員不存在
	}

	@Transactional
	// 忘記密碼顯示給使用者提示的email
	public String maskEmail(String email) {
		if (email == null || !email.contains("@")) {
			return email; // 如果 email 無效，直接返回原始值
		}
		String[] parts = email.split("@");
		String localPart = parts[0]; // @ 前的部分
		String domainPart = parts[1]; // @ 後的部分

		// 隱碼處理本地部分和域名部分
		String maskedLocal = localPart.length() > 3 ? localPart.substring(0, 3) + "***" : localPart + "***";
		String maskedDomain = domainPart.replaceAll("(?<=.).(?=.*\\.)", "*"); // 將域名中間部分隱藏

		return maskedLocal + "@" + maskedDomain;
	}

	public boolean addPoints(String username, String email, int pointsToAdd) {
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

	// 會員分析

	@Transactional(readOnly = true)
	public Long getMonthlyRegistrations() {
		LocalDate firstDayOfMonth = LocalDate.now().withDayOfMonth(1);
		LocalDate lastDayOfMonth = firstDayOfMonth.plusMonths(1).minusDays(1);

		return memberRepository.countByCreatedAtBetween(firstDayOfMonth.atStartOfDay(),
				lastDayOfMonth.atTime(23, 59, 59));
	}

	@Transactional(readOnly = true)
	public Long getTotalMembers() {
		return memberRepository.count();
	}

	@Transactional(readOnly = true)
	public List<Map<String, Object>> getRegistrationTrend() {
		LocalDate startDate = LocalDate.now().minusMonths(11).withDayOfMonth(1); // 12 個月前的第一天
		LocalDate endDate = LocalDate.now().plusMonths(1).withDayOfMonth(1); // 確保涵蓋 `2025-02`

		return Stream.iterate(startDate, date -> date.plusMonths(1)).limit(13) // ✅ 修正，確保涵蓋當前月份 + 未來 1 個月
				.map(month -> {
					LocalDateTime monthStart = month.atStartOfDay(); // 該月第一天 00:00:00
					LocalDateTime monthEnd = month.plusMonths(1).minusDays(1).atTime(23, 59, 59); // 該月最後一天 23:59:59

					// ❗ 確保 countByCreatedAtBetween() 不回傳 null
					Long registrations = memberRepository.countByCreatedAtBetween(monthStart, monthEnd);
					registrations = (registrations != null) ? registrations : 0; // ✅ 避免 null

					Map<String, Object> map = new HashMap<>();
					map.put("month", month.format(DateTimeFormatter.ofPattern("yyyy-MM"))); // ✅ 確保 `yyyy-MM` 格式
					map.put("registrations", registrations);
					return map;
				}).collect(Collectors.toList());
	}

	@Transactional(readOnly = true)
	public List<Map<String, Object>> getAgeDistribution() {
		return memberRepository.findAll().stream().collect(Collectors.groupingBy(member -> {
			int age = LocalDate.now().getYear() - member.getBirthday().getYear();
			if (age < 20)
				return "0-19";
			else if (age < 30)
				return "20-29";
			else if (age < 40)
				return "30-39";
			else if (age < 50)
				return "40-49";
			else
				return "50+";
		}, Collectors.counting())).entrySet().stream().map(entry -> {
			Map<String, Object> map = new HashMap<>();
			map.put("ageRange", entry.getKey()); // ✅ 統一 key 為 ageRange
			map.put("count", entry.getValue() != null ? entry.getValue() : 0); // ✅ 避免 null
			return map;
		}).collect(Collectors.toList());
	}

}
