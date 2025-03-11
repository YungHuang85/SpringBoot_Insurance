package insurance.main.products.dto;

public class PdfEmailRequestDTO {

	private String email;
    private String pdf; // Base64 編碼的 PDF
    
    
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPdf() {
		return pdf;
	}
	public void setPdf(String pdf) {
		this.pdf = pdf;
	}
    
    
}
