package insurance.main.model;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface CommentRepository extends JpaRepository<CommentBean, Integer> {
	// 新增：按 topic 或 content 模糊搜尋
//    List<CommentBean> findByTopicContainingIgnoreCaseOrContentContainingIgnoreCase(String topicKeyword, String contentKeyword);
//	List<CommentBean> findByTopicContainingIgnoreCaseOrContentContainingIgnoreCase(String topic, String content);
	 @Query(value = "SELECT c.*, m.username AS username " +
             "FROM Comment c " +
             "JOIN members m ON c.userid = m.id", 
     nativeQuery = true)
List<Object[]> findAllCommentsWithUsername();
	
	//模糊查詢的
	List<CommentBean> findByTopicContainingIgnoreCaseOrContentContainingIgnoreCaseOrCategoryContainingIgnoreCase(
	        String topic, String content, String category
	    );
	

    
    // 查詢當前最大 commentId
    @Query("SELECT MAX(c.commentid) FROM CommentBean c")
    Optional<Integer> findMaxCommentId();


}
