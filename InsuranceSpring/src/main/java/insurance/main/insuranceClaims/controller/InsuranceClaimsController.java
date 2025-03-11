package insurance.main.insuranceClaims.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.parser.Part;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import insurance.main.insuranceClaims.bean.ClientTravelBean2;
import insurance.main.insuranceClaims.bean.InsuranceClaimBean;
import insurance.main.insuranceClaims.dao.InsuranceClaimDao;
import insurance.main.insuranceClaims.dto.TravelClient2AndBeneficiary;
import insurance.main.insuranceClaims.service.MailService;
import jakarta.servlet.ServletContext;

// http://localhost:8081/insuranceClaims
@Controller
@CrossOrigin(origins = "http://localhost:5173")
//@CrossOrigin(origins = "*", allowedHeaders = "*", methods = {RequestMethod.GET, RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE})
public class InsuranceClaimsController {
	@Autowired
	private ServletContext servletContext;

	@Autowired
	private MailService mailService;

	@Autowired
	private InsuranceClaimDao InsuranceClaimDao;

	// 寄信
	@PostMapping("/send-mail")
	@ResponseBody
	public ResponseEntity<String> sendMail(@RequestParam String email, @RequestParam String claimStatus,
			@RequestParam String claimAmount, @RequestParam String comment, @RequestParam String policyNumber) {
		String subject = "理賠狀態更改";
		if (comment.isEmpty()) {
			comment = "無";
		}
		String body = "親愛的顧客您好" + "\n" + "保單號碼: " + policyNumber + "\n" + "理賠狀態已更改為: " + claimStatus + "\n" + "理賠金額為 "
				+ claimAmount + "元" + "\n" + "備註: " + comment;
		mailService.sendEmail(email, subject, body);
		return ResponseEntity.ok("寄信成功");
	}

	// 查全部
	@RequestMapping("/insuranceClaims")
	public String InsuranceClaims(Model m) {
		List<InsuranceClaimBean> claims = InsuranceClaimDao.getAll();
		m.addAttribute("claims", claims);
		return "index2";
	}

	
		// 後台申請書表單
		@GetMapping("/GetFormClaim/{policyNumber}")
		public String GetFormClaim(@PathVariable String policyNumber, Model m) {
			System.out.println("GetFormClaim");
			InsuranceClaimBean bean = InsuranceClaimDao.getOne(policyNumber);
			System.out.println("comment" + bean.getComment());
			System.out.println("claimAmount" + bean.getClaimAmount());
			System.out.println("GetFormClaimgetIdNumber" + bean.getIdNumber());
			m.addAttribute("bean", bean);

			if (bean == null) {
				return null; // 讓前端處理 null 情況
			}
			return "Form";
		}
		// 查詢未申請理賠的保單
		
		@GetMapping("/GetNotApplyCliams/{id_number}")
		@ResponseBody
		public List<TravelClient2AndBeneficiary> GetNotApplyCliams(@PathVariable String id_number) {
			System.out.println("doGetNotApplyCliams");
			List<TravelClient2AndBeneficiary> beans = InsuranceClaimDao.findBeneficiaryAndTravelClientByID(id_number);
			if (beans == null) {
				return null; // 讓前端處理 null 情況
			}
			return beans;
		}
		
		// 查理賠資料庫by idNumber
		@GetMapping("/GetInsuranceClaimbyID/{idNumber}")
		@ResponseBody
		public List<InsuranceClaimBean> GetInsuranceClaimbyID(@PathVariable String idNumber) {
			System.out.println("doGetInsuranceClaimbyID");
			
			List<InsuranceClaimBean> claims = InsuranceClaimDao.findByIdNumber(idNumber);
			if (claims == null) {
				return null; // 讓前端處理 null 情況
			}
			return claims;
		}

	
	// 查詢travelclient2和受益人資料庫
	// 查保單資料庫
//	@GetMapping("/GetClientTravel2AndBeneficiary/{id_number}")
//	@ResponseBody
//	public List<TravelClient2AndBeneficiary> GetClientTravel2AndBeneficiary(@PathVariable String id_number) {
//		System.out.println("doGetClientTravel2AndBeneficiary");
//		List<TravelClient2AndBeneficiary> beans = InsuranceClaimDao.findBeneficiaryAndTravelClientByID(id_number);
//		if (beans == null) {
//			return null; // 讓前端處理 null 情況
//		}
//		return beans;
//	}

	// update
	@PutMapping("/UpdateClaims")
	public ResponseEntity<String> UpdateClaims(@RequestBody InsuranceClaimBean bean) {
		
		System.out.println("bean.getReviewer()"+bean.getReviewer());

		InsuranceClaimDao.update(bean.getPolicyNumber(), bean.getClaimStatus(), bean.getComment(),
				bean.getClaimAmount(),bean.getReviewer());
		return ResponseEntity.ok("更新成功");
	}

	// 查保單資料庫
	@GetMapping("/GetClientTravel/{policyNumber}")
	@ResponseBody
	public ClientTravelBean2 GetClientTravel(@PathVariable String policyNumber) {
		System.out.println("doGetClientTravel");
		ClientTravelBean2 bean = InsuranceClaimDao.grtTravelClient(policyNumber);
		if (bean == null) {
			return null; // 讓前端處理 null 情況
		}
		return bean;
	}

	// 查保單資料庫
	@GetMapping("/GetClientTravelID/{idNumber}")
	@ResponseBody
	public ClientTravelBean2 GetClientTravelByIdNumber(@PathVariable String idNumber) {
		System.out.println("doGetClientTravel");
		ClientTravelBean2 bean = InsuranceClaimDao.getTravelClientById(idNumber);
		if (bean == null) {
			return null; // 讓前端處理 null 情況
		}
		return bean;
	}

	// 查理賠資料庫by 保單號碼
	@GetMapping("/GetInsuranceClaim/{policyNumber}")
	@ResponseBody
	public ClientTravelBean2 GetInsuranceClaim(@PathVariable String policyNumber) {
		System.out.println("doGetClientTravel");
		ClientTravelBean2 bean = InsuranceClaimDao.grtTravelClient(policyNumber);
		if (bean == null) {
			return null; // 讓前端處理 null 情況
		}
		return bean;
	}

	// 查理賠資料庫全部
	@GetMapping("/GetInsuranceClaimAll")
	@ResponseBody
	public List<InsuranceClaimBean> GetInsuranceClaimAll() {
		System.out.println("GetInsuranceClaimAll");
		List<InsuranceClaimBean> beans = InsuranceClaimDao.getAll();
		if (beans == null) {
			return null; // 讓前端處理 null 情況
		}
		return beans;
	}

	// 查保單資料庫全部
	@GetMapping("/GetClientTravelAll")
	@ResponseBody
	public List<ClientTravelBean2> GetClientTravelAll() {
		System.out.println("doGetClientTravelAll");
		List<ClientTravelBean2> bean = InsuranceClaimDao.grtTravelClientAll();
		if (bean == null) {
			return null; // 讓前端處理 null 情況
		}
		return bean;
	}

	// update先查詢
	@GetMapping("/GetOneClaim/{policyNumber}")
	public String GetOneClaim(@PathVariable String policyNumber, Model m) {
		System.out.println("doGetOneClaim");
		InsuranceClaimBean bean = InsuranceClaimDao.getOne(policyNumber);
		System.out.println("comment" + bean.getComment());
		System.out.println("claimAmount" + bean.getClaimAmount());
		m.addAttribute("bean", bean);

		if (bean == null) {
			return null; // 讓前端處理 null 情況
		}
		return "Update";
	}

	// 模糊查詢
	@GetMapping("/GetSomeClaims/{policyNumber}")
	@ResponseBody
	public List<InsuranceClaimBean> GetSomeClaims(@PathVariable String policyNumber, Model m) {
		System.out.println("doGetSomeClaims");
		List<InsuranceClaimBean> claims = InsuranceClaimDao.getSome(policyNumber);
		// m.addAttribute("claims", claims);

		if (claims == null) {
			return null; // 讓前端處理 null 情況
		}

		return claims;
	}

	// DELETE
	@DeleteMapping("/DeleteClaims/{policyNumber}")
	@ResponseBody
	public boolean DeleteClaims(@PathVariable String policyNumber, Model m) {
		System.out.println("doDeleteClaims");

		boolean result = InsuranceClaimDao.delete(policyNumber);
		System.out.println("刪除執行結果: " + result);

		// 更新查詢列表

		if (result) {
			m.addAttribute("message", "刪除成功！");
		} else {
			m.addAttribute("message", "刪除失敗，記錄可能不存在。");
		}

		return result;
	}

	// DELETE
	@GetMapping("/test")
	@ResponseBody
	public String test() {

		System.out.println("okokokoko");

		return "ok";
	}

	// 新增Vue
	@PostMapping("/InsertClaimsVueNEW")
	public ResponseEntity<String> InsertClaimsVueNEW(@RequestParam Map<String, String> formData,
		    @RequestParam(value = "idCopy", required = false) MultipartFile idCopy,
		    @RequestParam(value = "accountCopy", required = false) MultipartFile accountCopy,
		    @RequestParam(value = "proveFile", required = false) MultipartFile proveFile)

			throws IllegalStateException, IOException {
		System.out.println("doInsertClaimsVue");
			try {
				
				InsuranceClaimBean ClaimBean = new InsuranceClaimBean();
				
				 // 單獨取得表單欄位值
		        String policyNumber = formData.get("policyNumber"); // 保單號碼
		        String policyName = formData.get("policyName"); // 保單名稱
		        String clientName = formData.get("clientName");     // 客戶姓名
		        String idNumber = formData.get("id_number");        // 身分證字號
		        String accidentReason = formData.get("accidentReason"); // 事故原因
		        String address = formData.get("address");           // 地址
		        String phone = formData.get("phone");               // 聯絡電話
		        String email = formData.get("email");               // 電子郵件
		        String applicationDate = formData.get("applicationDate"); // 申請日期
		        String beneficiaryName = formData.get("beneficiaryName"); // 受益人姓名
		        String beneficiaryID = formData.get("beneficiaryID");     // 受益人身分證
		        String bankCode = formData.get("bankCode");         // 銀行代號
		        String accountCode = formData.get("accountCode");   // 行庫帳號
		        String claimCategories = formData.get("claimCategories"); //理賠類別
		        String signature = formData.get("signature"); //理賠類別
		        
		        ClaimBean.setClaimCategories(claimCategories);
				ClaimBean.setPolicyNumber(policyNumber);
				ClaimBean.setPolicyName(policyName);
				ClaimBean.setClientName(clientName);
				ClaimBean.setClaimStatus("待審核");
				ClaimBean.setIdNumber(idNumber);
				System.out.println("新增的身分證字號"+idNumber);
				ClaimBean.setAccidentReason(accidentReason);
				ClaimBean.setAddress(address);
				ClaimBean.setPhone(phone);
				ClaimBean.setEmail(email);
				LocalDate localDate = LocalDate.parse(applicationDate);
				ClaimBean.setApplicationDate(localDate);
				ClaimBean.setBeneficiaryName(beneficiaryName);
				ClaimBean.setBeneficiaryID(beneficiaryID);
				ClaimBean.setBankCode(bankCode);
				ClaimBean.setAccountCode(accountCode);
				ClaimBean.setSignature(signature);


				// String filename = null;
				String pathname = null;
				Part part = null;
				String custom_proveFile = null;
				String custom_idCopy = null;
				String custom_accountCopy = null;
				String directory = "file/";
				String AnchorPath = null;

				// 創建保存路徑：動態獲取專案內部的 file 資料夾
				String uploadPath = servletContext.getRealPath("/file");
				// String fileName = mf.getOriginalFilename();
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists()) {
					uploadDir.mkdirs(); // 如果資料夾不存在，則創建
				}

				custom_proveFile = policyNumber + "_proveFile";
				String Provefilename = proveFile.getOriginalFilename();

				if (Provefilename != null && Provefilename.contains(".")) {

					String fileExtension = Provefilename.substring(Provefilename.lastIndexOf("."));

					custom_proveFile += fileExtension; // 加上副檔名
					File saveFilePath = new File(uploadPath, custom_proveFile);
					AnchorPath = directory + custom_proveFile;
					ClaimBean.setProveFile(AnchorPath);
					// 儲存檔案到指定路徑
					proveFile.transferTo(saveFilePath);

				}

				custom_idCopy = policyNumber + "_idCopy";
				String IDfilename = idCopy.getOriginalFilename();

				if (IDfilename != null && IDfilename.contains(".")) {
					String fileExtension = IDfilename.substring(IDfilename.lastIndexOf("."));
					custom_idCopy += fileExtension; // 加上副檔名
					File saveFilePath = new File(uploadPath, custom_idCopy);
					AnchorPath = directory + custom_idCopy;
					ClaimBean.setIdCopy(AnchorPath);
					// 儲存檔案到指定路徑
					idCopy.transferTo(saveFilePath);

				}

				custom_accountCopy = policyNumber + "_accountCopy";
				String Accountfilename = accountCopy.getOriginalFilename();
				if (Accountfilename != null && Accountfilename.contains(".")) {
					String fileExtension = Accountfilename.substring(Accountfilename.lastIndexOf("."));
					custom_accountCopy += fileExtension; // 加上副檔名
					File saveFilePath = new File(uploadPath, custom_accountCopy);
					AnchorPath = directory + custom_accountCopy;
					ClaimBean.setAccountCopy(AnchorPath);
					// 儲存檔案到指定路徑
					accountCopy.transferTo(saveFilePath);
				}

				InsuranceClaimDao.insert(ClaimBean);
			
				System.out.println("執行結束");
		        return ResponseEntity.ok("新增成功");
			} catch (Exception e) {
				e.printStackTrace();

				return ResponseEntity.status(500).body("新增失敗");
			}

			
	}

//	// 新增Vue
//	@PostMapping("/InsertClaimsVue")
//	public ResponseEntity<String> InsertClaimsVue(@RequestParam("applicationDate") String applicationDate,
//			@RequestParam("policyNumber") String policyNumber, @RequestParam("policyName") String policyName,
//			@RequestParam("clientName") String clientName,
//			@RequestParam("applicationForm") MultipartFile applicationForm, // 文件字段
//			@RequestParam("idCopy") MultipartFile idCopy, @RequestParam("accountCopy") MultipartFile accountCopy)
//			throws IllegalStateException, IOException {
//
//		try {
//			System.out.println("doInsertClaimsVue");
//			InsuranceClaimBean ClaimBean = new InsuranceClaimBean();
//			ClaimBean.setClaimStatus("待審核");
//			ClaimBean.setPolicyNumber(policyNumber);
//			ClaimBean.setPolicyName(policyName);
//			ClaimBean.setClientName(clientName);
//			LocalDate localDate = LocalDate.parse(applicationDate);
//			ClaimBean.setApplicationDate(localDate);
//
//			// String filename = null;
//			String pathname = null;
//			Part part = null;
//			String custom_applicationForm = null;
//			String custom_idCopy = null;
//			String custom_accountCopy = null;
//			String directory = "file/";
//			String AnchorPath = null;
//
//			// 創建保存路徑：動態獲取專案內部的 file 資料夾
//			String uploadPath = servletContext.getRealPath("/file");
//			// String fileName = mf.getOriginalFilename();
//			File uploadDir = new File(uploadPath);
//			if (!uploadDir.exists()) {
//				uploadDir.mkdirs(); // 如果資料夾不存在，則創建
//			}
//
//			custom_applicationForm = policyNumber + "_applicationForm";
//			String Applyfilename = applicationForm.getOriginalFilename();
//
////			if (Applyfilename != null && Applyfilename.contains(".")) {
////
////				String fileExtension = Applyfilename.substring(Applyfilename.lastIndexOf("."));
////
////				custom_applicationForm += fileExtension; // 加上副檔名
////				File saveFilePath = new File(uploadPath, custom_applicationForm);
////				AnchorPath = directory + custom_applicationForm;
////				ClaimBean.setApplicationForm(AnchorPath);
////				// 儲存檔案到指定路徑
////				applicationForm.transferTo(saveFilePath);
////
////			}
//
//			custom_idCopy = policyNumber + "_idCopy";
//			String IDfilename = idCopy.getOriginalFilename();
//
//			if (IDfilename != null && IDfilename.contains(".")) {
//				String fileExtension = IDfilename.substring(IDfilename.lastIndexOf("."));
//				custom_idCopy += fileExtension; // 加上副檔名
//				File saveFilePath = new File(uploadPath, custom_idCopy);
//				AnchorPath = directory + custom_idCopy;
//				ClaimBean.setIdCopy(AnchorPath);
//				// 儲存檔案到指定路徑
//				idCopy.transferTo(saveFilePath);
//
//			}
//
//			custom_accountCopy = policyNumber + "_accountCopy";
//			String Accountfilename = accountCopy.getOriginalFilename();
//			if (Accountfilename != null && Accountfilename.contains(".")) {
//				String fileExtension = Accountfilename.substring(Accountfilename.lastIndexOf("."));
//				custom_accountCopy += fileExtension; // 加上副檔名
//				File saveFilePath = new File(uploadPath, custom_accountCopy);
//				AnchorPath = directory + custom_accountCopy;
//				ClaimBean.setAccountCopy(AnchorPath);
//				// 儲存檔案到指定路徑
//				accountCopy.transferTo(saveFilePath);
//			}
//
//			InsuranceClaimDao.insert(ClaimBean);
//			// 更新查詢列表
//			// List<InsuranceClaimBean> claims = InsuranceClaimDao.getAll();
////			m.addAttribute("claims", claims);
////			m.addAttribute("alertMessage", "新增成功！");
////			m.addAttribute("alertType", "success");
//			System.out.println("執行結束");
//			return ResponseEntity.ok("新增成功");
//		} catch (Exception e) {
//			e.printStackTrace();
////			m.addAttribute("alertMessage", "新增失敗！");
////			m.addAttribute("alertType", "error");
//			return ResponseEntity.status(500).body("新增失敗");
//		}
//
//		// 返回查詢頁面
//		// return "index2";
//
//	}
//
//	// 新增
//	@PostMapping("/InsertClaims")
//	public String InsertClaims(@ModelAttribute("insuranceClaim") InsuranceClaimBean bean, BindingResult result, Model m,
//			@RequestParam("applicationForm") MultipartFile applicationForm, // 文件字段
//			@RequestParam("idCopy") MultipartFile idCopy, @RequestParam("accountCopy") MultipartFile accountCopy)
//			throws IllegalStateException, IOException {
//
//		try {
//			System.out.println("doInsertClaims");
//			InsuranceClaimBean ClaimBean = new InsuranceClaimBean();
//			ClaimBean.setClaimStatus(bean.getClaimStatus());
//			ClaimBean.setPolicyNumber(bean.getPolicyNumber());
//			ClaimBean.setPolicyName(bean.getPolicyName());
//			ClaimBean.setClientName(bean.getClientName());
//			ClaimBean.setApplicationDate(bean.getApplicationDate());
//			System.out.println("bean.getId_number()" + bean.getIdNumber());
//			ClaimBean.setIdNumber(bean.getIdNumber());
//			// String filename = null;
//			String pathname = null;
//			Part part = null;
//			String custom_applicationForm = null;
//			String custom_idCopy = null;
//			String custom_accountCopy = null;
//			String directory = "file/";
//			String AnchorPath = null;
//			String policyNumber = bean.getPolicyNumber();
//
//			// 創建保存路徑：動態獲取專案內部的 file 資料夾
//			String uploadPath = servletContext.getRealPath("/file");
//			// String fileName = mf.getOriginalFilename();
//			File uploadDir = new File(uploadPath);
//			if (!uploadDir.exists()) {
//				uploadDir.mkdirs(); // 如果資料夾不存在，則創建
//			}
//
//			custom_applicationForm = policyNumber + "_applicationForm";
//			String Applyfilename = applicationForm.getOriginalFilename();
////
////			if (Applyfilename != null && Applyfilename.contains(".")) {
////
////				String fileExtension = Applyfilename.substring(Applyfilename.lastIndexOf("."));
////
////				custom_applicationForm += fileExtension; // 加上副檔名
////				File saveFilePath = new File(uploadPath, custom_applicationForm);
////				AnchorPath = directory + custom_applicationForm;
////				ClaimBean.setApplicationForm(AnchorPath);
////				// 儲存檔案到指定路徑
////				applicationForm.transferTo(saveFilePath);
////
////			}
//
//			custom_idCopy = policyNumber + "_idCopy";
//			String IDfilename = idCopy.getOriginalFilename();
//
//			if (IDfilename != null && IDfilename.contains(".")) {
//				String fileExtension = IDfilename.substring(IDfilename.lastIndexOf("."));
//				custom_idCopy += fileExtension; // 加上副檔名
//				File saveFilePath = new File(uploadPath, custom_idCopy);
//				AnchorPath = directory + custom_idCopy;
//				ClaimBean.setIdCopy(AnchorPath);
//				// 儲存檔案到指定路徑
//				idCopy.transferTo(saveFilePath);
//
//			}
//
//			custom_accountCopy = policyNumber + "_accountCopy";
//			String Accountfilename = accountCopy.getOriginalFilename();
//			if (Accountfilename != null && Accountfilename.contains(".")) {
//				String fileExtension = Accountfilename.substring(Accountfilename.lastIndexOf("."));
//				custom_accountCopy += fileExtension; // 加上副檔名
//				File saveFilePath = new File(uploadPath, custom_accountCopy);
//				AnchorPath = directory + custom_accountCopy;
//				ClaimBean.setAccountCopy(AnchorPath);
//				// 儲存檔案到指定路徑
//				accountCopy.transferTo(saveFilePath);
//			}
//
//			InsuranceClaimDao.insert(ClaimBean);
//			// 更新查詢列表
//			List<InsuranceClaimBean> claims = InsuranceClaimDao.getAll();
//			m.addAttribute("claims", claims);
//			m.addAttribute("alertMessage", "新增成功！");
//			m.addAttribute("alertType", "success");
//		} catch (Exception e) {
//			e.printStackTrace();
//			m.addAttribute("alertMessage", "新增失敗！");
//			m.addAttribute("alertType", "error");
//
//		}
//
//		// 返回查詢頁面
//		return "index2";
//
//	}

}
