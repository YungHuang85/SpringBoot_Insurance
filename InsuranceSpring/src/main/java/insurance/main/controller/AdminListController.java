package insurance.main.controller;

import java.nio.file.Files;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.api.client.http.HttpHeaders;

import insurance.main.dto.AdminListDto;
import insurance.main.model.AdminBean;
import insurance.main.model.AdminListRepository;
import insurance.main.model.AdminListService;
import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;

@Controller

public class AdminListController {

	@Autowired
	private AdminListService adminListService;

	@Autowired
	private AdminListRepository adminListRepository;
	
	@Autowired
	private RequestMappingHandlerAdapter handlerAdapter;

	// 查詢全部管理員
	@GetMapping("/list")
	public String getAllAdmins(HttpServletRequest request) {
		adminListService.getAllAdmins(request);
		return "AdminList"; // 導向 JSP 頁面
	}

	/*
	 * // 查詢單筆管理員
	 * 
	 * @PostMapping("/get")
	 * 
	 * @ResponseBody public ResponseEntity<AdminListDto> getAdminById(@RequestBody
	 * String json) { try { ObjectMapper objectMapper = new ObjectMapper();
	 * Map<String, String> requestMap = objectMapper.readValue(json, Map.class);
	 * Long id = Long.valueOf(requestMap.get("id")); // 解析 ID AdminListDto adminDto
	 * = adminListService.findAdminById(id); return ResponseEntity.ok(adminDto); }
	 * catch (Exception e) { e.printStackTrace(); return
	 * ResponseEntity.badRequest().build(); } }
	 */
	@PostMapping("/get")
	@ResponseBody
	public ResponseEntity<AdminListDto> getAdminById(@RequestBody String json) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			Map<String, Object> requestMap = objectMapper.readValue(json, Map.class);

			// 正確處理 id 類型
			Number idNumber = (Number) requestMap.get("id"); // 確保類型為 Number
			Long id = idNumber.longValue(); // 轉換為 Long

			AdminListDto adminDto = adminListService.findAdminById(id);
			return ResponseEntity.ok(adminDto);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.badRequest().build();
		}
	}

	// 新增管理員
	@PostMapping("/add")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> addAdmin(@RequestBody AdminBean adminBean) {
		Map<String, Object> response = new HashMap<>();
		try {

//        	if (adminBean.getProfilePicture() == null || adminBean.getProfilePicture().isEmpty()) {
//                adminBean.setProfilePicture("/picture/defaultPic.jpg");  // 預設圖片名稱
//            }
			// 儲存 Admin 資料
			AdminBean savedAdmin = adminListRepository.save(adminBean);

			// 返回成功訊息和儲存的資料
			response.put("status", "success");
			response.put("message", "新增成功");
			response.put("admin", savedAdmin); // 傳回新建的管理員資料
		} catch (Exception e) {
			response.put("status", "error");
			response.put("message", "新增失敗: " + e.getMessage());
		}
		return ResponseEntity.ok(response);
	}

	/*
	 * @PostMapping("/add") public Map<String, Object> addAdmin(@RequestBody
	 * AdminBean adminBean) { Map<String, Object> response = new HashMap<>(); try {
	 * // 儲存 Admin 資料 AdminBean savedAdmin = adminListRepository.save(adminBean);
	 * 
	 * // 返回成功訊息和儲存的資料 response.put("status", "success"); response.put("message",
	 * "新增成功"); response.put("admin", savedAdmin); // 傳回新建的管理員資料 } catch (Exception
	 * e) { response.put("status", "error"); response.put("message", "新增失敗: " +
	 * e.getMessage()); } return response; }
	 */

	// 修改管理員資料
	@PostMapping("/edit")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> editAdmin(@RequestParam("id") Long id,
			@RequestParam("username") String username, @RequestParam("password") String password,
			@RequestParam("name") String name, @RequestParam("adminEmail") String adminEmail,
			@RequestParam(value = "profilePicture", required = false) MultipartFile profilePicture) {
		Map<String, Object> response = new HashMap<>();
		try {
			AdminListDto adminDto = adminListService.findAdminById(id);

			if (!"success".equals(adminDto.getStatus()) || adminDto.getData() == null) {
				response.put("status", "error");
				response.put("message", "找不到管理員資料");
				return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
			}

			AdminBean admin = adminDto.getData();
			admin.setUsername(username);
			admin.setPassword(password);
			admin.setName(name);
			admin.setAdminEmail(adminEmail);

            if (profilePicture != null && !profilePicture.isEmpty()) {
//                String profilePicturePath = adminListService.saveProfilePicture(profilePicture);
//                admin.setProfilePicture(profilePicturePath);
            	admin.setProfilePicture(profilePicture.getBytes());
    			admin.setProfilePictureImageType(profilePicture.getContentType());
            }

			adminListService.updateAdmin(admin);
			response.put("status", "success");
			response.put("message", "資料已更新");
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status", "error");
			response.put("message", "伺服器發生問題，無法更新資料");
		}
		return ResponseEntity.ok(response);
	}

	// 取得管理員圖片
	@GetMapping("/getImage/{id}")
	public ResponseEntity<byte[]> getImage(@PathVariable Long id) {
		try {
			Optional<AdminBean> option = adminListRepository.findById(id);
			byte[] image = null;
			String contentType = null;
			
			if (option.isPresent() && option.get().getProfilePicture() != null) {
	            AdminBean admin = option.get();
	            image = admin.getProfilePicture();
	            contentType = admin.getProfilePictureImageType();
	        } else {
	            // 使用 ClassPathResource 加載預設圖片
	            Resource resource = new ClassPathResource("static/picture/defaultPic.jpg");
	            image = Files.readAllBytes(resource.getFile().toPath());
	            contentType = "image/jpeg";
	        }
			
			// 設定回應標頭
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(contentType);

			return new ResponseEntity<>(image, HttpStatus.OK);
		} catch (Exception e) {
			return ResponseEntity.status(404).body(null);
		}
	}

	// 刪除管理員
	@PostMapping("/delete")
	@ResponseBody
	public ResponseEntity<AdminListDto> deleteAdmin(@RequestBody AdminBean admin) {
	    AdminListDto adminDto = new AdminListDto();
	    try {
	        if (admin == null || admin.getId() == null) {
	            throw new IllegalArgumentException("管理員ID為空！");
	        }
	        adminListService.deleteAdmin(admin);
	        adminDto.setStatus("success");
	    } catch (IllegalArgumentException e) {
	        adminDto.setStatus("error");
	        adminDto.setMessage(e.getMessage());
	    } catch (Exception e) {
	        adminDto.setStatus("error");
	        adminDto.setMessage("刪除失敗，請稍後再試！");
	        e.printStackTrace();
	    }
	    return ResponseEntity.ok(adminDto);
	}
	
	@PostMapping(value = "/getDetail", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<AdminListDto> getAdminDetailsById(@RequestBody String json) {
	    AdminListDto response = new AdminListDto();
	    try {
	        ObjectMapper objectMapper = new ObjectMapper();
	        Map<String, Object> requestMap = objectMapper.readValue(json, Map.class);

	        Long id = ((Number) requestMap.get("id")).longValue();
	        AdminBean admin = adminListService.getAdminById(id);

	        System.out.println("查詢到的 AdminBean：" + admin);

	        if (admin == null) {
	            response.setStatus("error");
	            response.setMessage("未找到管理員");
	            return ResponseEntity.ok(response);
	        }

	        response.setStatus("success");
	        response.setMessage("查詢成功");
	        response.setData(admin);

	        System.out.println("返回 JSON：" + new ObjectMapper().writeValueAsString(response));

	        return ResponseEntity.ok(response);
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.setStatus("error");
	        response.setMessage("伺服器錯誤");
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	    }
	}


	@PostConstruct
	public void logMessageConverters() {
	    handlerAdapter.getMessageConverters().forEach(converter -> {
	        System.out.println("MessageConverter: " + converter);
	    });
	}



}
