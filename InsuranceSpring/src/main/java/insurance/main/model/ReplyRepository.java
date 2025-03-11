package insurance.main.model;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;



import org.springframework.data.repository.query.Param;

@Repository
public interface ReplyRepository extends JpaRepository<ReplyBean, Integer> {
    List<ReplyBean> findByCommentid(Integer commentid);
    void deleteByCommentid(Integer commentid);
    @Query("SELECT MAX(r.replyid) FROM ReplyBean r")
    Optional<Integer> findMaxReplyId();
    
    @Query("SELECT r, m.username FROM ReplyBean r JOIN MembersBean m ON r.userid = m.id WHERE r.commentid = :commentid")
    List<Object[]> findByCommentidWithUsername(@Param("commentid") Integer commentid);
    
//    // 新增: 計算特定評論的留言數
    int countByCommentid(Long commentid);
    
    
    @Query("SELECT new map(r.replyid as replyid, r.content as content, r.commentid as commentid, r.userid as userid, m.username as username, m.gender as gender) " +
            "FROM ReplyBean r LEFT JOIN MembersBean m ON r.userid = m.id " +
            "WHERE r.commentid = :commentid")
     List<Map<String, Object>> findRepliesWithUserDetails(@Param("commentid") Integer commentid);
    
    
}
