package insurance.main.awsmodel;


public class EmailRequest {
	// 收件人電子郵件地址
    private String to;
    // 郵件標題
    private String subject;
    // 郵件正文內容
    private String body;

    // Getter / Setter
    public String getTo() {
        return to;
    }
    public void setTo(String to) {
        this.to = to;
    }

    public String getSubject() {
        return subject;
    }
    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getBody() {
        return body;
    }
    public void setBody(String body) {
        this.body = body;
    }
}
