package insurance.main.model;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "Comment")
public class CommentBean {

    @Id
    @Column(name = "commentid") // 主鍵
    private Integer commentid;

    @Column(name = "topic", nullable = false) // 主題名稱
    private String topic;

    @Column(name = "content", nullable = false) // 評論內容
    private String content;

    @Column(name = "category", nullable = false, length = 50) // 分類
    private String category;

    @Column(name = "userid", nullable = false)
    private Integer userid;

    private String username;  // 非資料庫欄位，用於顯示使用者名稱

    // 新增 userid 和 username 的 Getter 和 Setter
    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    // Getters and Setters
    public Integer getCommentid() {
        return commentid;
    }

    public void setCommentid(Integer commentid) {
        this.commentid = commentid;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

}


