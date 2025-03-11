package insurance.main.model;


import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.Column;
import jakarta.persistence.Id;
@Entity
@Table(name="QA")
public class QABean {

	@Id
    @Column(name = "QA_id") // 對應資料表中的主鍵欄位
    private Integer qaid;

    @Column(name = "question", nullable = false)
    private String question;

    @Column(name = "answer", nullable = false)
    private String answer;

	public Integer getQaid() {
		return qaid;
	}

	public void setQaid(Integer qaid) {
		this.qaid = qaid;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}
	
}
