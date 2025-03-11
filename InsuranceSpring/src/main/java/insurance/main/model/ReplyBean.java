package insurance.main.model;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
@Entity
@Table(name = "Reply")
public class ReplyBean {
   @Id
   @Column(name = "replyid")
   private Integer replyid;

   @Column(name = "content")
   private String content;

   @Column(name = "commentid")
   private Integer commentid;

   @Column(name = "userid")
   private Integer userid;

   @Transient
   private String idNumber;

   @Column(name = "username") // 改為 Column
   private String username;
   
   @Column(name = "gender")
   private String gender;

   public String getGender() {
	return gender;
}

public void setGender(String gender) {
	this.gender = gender;
}

public String getUsername() {
	return username;
}

public void setUsername(String username) {
	this.username = username;
}

// Getters and setters
   public Integer getReplyid() {
       return replyid;
   }

   public void setReplyid(Integer replyid) {
       this.replyid = replyid;
   }

   public String getContent() {
       return content;
   }

   public void setContent(String content) {
       this.content = content;
   }

   public Integer getCommentid() {
       return commentid;
   }

   public void setCommentid(Integer commentid) {
       this.commentid = commentid;
   }

   public Integer getUserid() {
       return userid;
   }

   public void setUserid(Integer userid) {
       this.userid = userid;
   }

   public String getIdNumber() {
       return idNumber;
   }

   public void setIdNumber(String idNumber) {
       this.idNumber = idNumber;
   }

}
