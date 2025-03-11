package insurance.main.dto;

import insurance.main.model.AdminBean;

public class AdminListDto {

	private String status;
	private String message;
	private AdminBean data; // 修正類型為 AdminBean


	
	// Getters and Setters
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public AdminBean getData() { // 返回 AdminBean 類型
		return data;
	}

	public void setData(AdminBean data) { // 接收 AdminBean 類型
		this.data = data;
	}

	
	
	


}
