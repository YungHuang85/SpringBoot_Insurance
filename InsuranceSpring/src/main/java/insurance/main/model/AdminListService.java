package insurance.main.model;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import insurance.main.dto.AdminListDto;
import jakarta.servlet.http.HttpServletRequest;

@Service
public class AdminListService {

	@Autowired
	private AdminListRepository adminListRepository;

	// 查詢全部管理員
	@Transactional
	public void getAllAdmins(HttpServletRequest request) {
		List<AdminBean> adminList = adminListRepository.findAll(); // 使用 AdminBean
		if (adminList == null || adminList.isEmpty()) {
			request.setAttribute("message", "目前沒有管理員資料！");
			adminList = new ArrayList<>();
		}
		request.setAttribute("adminList", adminList);
	}
/*
	// 查詢單筆管理員
	public AdminListDto findAdminById(Long id) {
		Optional<AdminBean> adminOptional = adminListRepository.findById(id); // 使用 AdminBean
		AdminListDto adminListDto = new AdminListDto();
		if (adminOptional.isPresent()) {
			adminListDto.setStatus("success");
			adminListDto.setData(adminOptional.get()); // 設置正確的 AdminBean 類型
		} else {
			adminListDto.setStatus("error");
			adminListDto.setMessage("找不到該管理員！");
		}
		return adminListDto;
	}*/
	public AdminListDto findAdminById(Long id) {
	    AdminBean admin = adminListRepository.findById(id).orElse(null);
	    AdminListDto responseDto = new AdminListDto();
	    if (admin == null) {
	        responseDto.setStatus("error");
	        responseDto.setMessage("找不到管理員資料");
	        responseDto.setData(null);
	        return responseDto;
	    }
	    responseDto.setStatus("success");
	    responseDto.setMessage("查詢成功");
	    responseDto.setData(admin);
	    return responseDto;
	}



	// 新增管理員
	@Transactional
	public void addAdmin(AdminBean admin) { // 使用 AdminBean
		adminListRepository.save(admin);
	}

	// 修改管理員
	@Transactional
	public void updateAdmin(AdminBean admin) { // 使用 AdminBean
		adminListRepository.save(admin);
	}

	// 刪除管理員
	@Transactional
	public void deleteAdmin(AdminBean admin) { 
		adminListRepository.delete(admin);
	}
	
	//存圖片
	public String saveProfilePicture(MultipartFile profilePicture) throws IOException {
        String uploadDir = "src/main/resources/static/picture/";

      
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }

      
        String fileName = UUID.randomUUID().toString() + "-" + profilePicture.getOriginalFilename();
        File targetFile = new File(uploadDir, fileName);
        profilePicture.transferTo(targetFile); 
        return "/picture/" + fileName; 
    }
	// 返回 AdminBean
	public AdminBean getAdminById(Long id) {
	    return adminListRepository.findById(id).orElse(null);
	}

	
}
