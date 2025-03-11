package insurance.main.dto;

import insurance.main.model.AdminBean;

public class AdminDto {

	// 把狀態改為數字表示狀態
	// private String message;
	private Integer code;

	// 用來定義帳號錯誤或密碼錯誤
	private AdminBean admin;

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public AdminBean getAdmin() {
		return admin;
	}

	public void setAdmin(AdminBean admin) {
		this.admin = admin;
	}
//	public String getMessage() {
//		return message;
//	}
//	public void setMessage(String message) {
//		this.message = message;
//	}

	@Override
	public String toString() {
		return "AdminDto [code=" + code + ", admin=" + admin + "]";
	}

}
