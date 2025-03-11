package insurance.main.controller;

import insurance.main.model.CommentBean;
import insurance.main.model.CommentRepository;
import insurance.main.model.MembersBean;
import insurance.main.model.ReplyBean;
import insurance.main.model.ReplyRepository;
import insurance.main.model.mrepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/comments") // 修改為針對評論的路徑
@CrossOrigin(origins = "http://localhost:5173") // 允許來自前端的請求
public class Commentrestcontroller {

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private ReplyRepository replyRepository;
    
    @Autowired
    private mrepository memberRepository;
    
    // 查詢所有評論資料 (JSON 格式)
    //http://localhost:8081/api/comments/findalljson
    
    //36~39原本對的喔
//    @GetMapping("/findalljson")
//    public List<CommentBean> getAllComments() {
//        return commentRepository.findAll();
//    }

    // 新增：按關鍵字搜尋評論
//    @GetMapping("/search")
//    public List<CommentBean> searchComments(@RequestParam String keyword) {
//        return commentRepository.findByTopicContainingIgnoreCaseOrContentContainingIgnoreCase(keyword, keyword);
//    }
    
//    @GetMapping("/search")
//    public List<CommentBean> searchComments(@RequestParam String keyword) {
//        if (keyword == null || keyword.trim().isEmpty()) {
//            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "關鍵字不能為空");
//        }
//        try {
//            return commentRepository.findByTopicContainingIgnoreCaseOrContentContainingIgnoreCase(keyword, keyword);
//        } catch (Exception e) {
//            e.printStackTrace(); // 打印完整錯誤堆疊
//            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "伺服器錯誤：" + e.getMessage());
//        }
//    }

    @GetMapping("/search")
    public List<CommentBean> searchComments(@RequestParam String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "關鍵字不能為空");
        }
        try {
            return commentRepository.findByTopicContainingIgnoreCaseOrContentContainingIgnoreCaseOrCategoryContainingIgnoreCase(
                keyword, keyword, keyword
            );
        } catch (Exception e) {
            e.printStackTrace();
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "伺服器錯誤：" + e.getMessage());
        }
    }




    
 // 新增評論，並自動生成唯一的 commentId(原本的)
//    @PostMapping("/add")
//    public CommentBean addComment(@RequestBody CommentBean comment) {
//        // 查詢現有最大 commentid，生成新的唯一編號
//        int newId = commentRepository.findMaxCommentId().orElse(0) + 1;
//        comment.setCommentid(newId); // 設置自動生成的編號
//        return commentRepository.save(comment); // 保存評論
//    }
    
    @GetMapping("/getUserIdByIdNumber")
    public ResponseEntity<Integer> getUserIdByIdNumber(@RequestParam String idNumber) {
        Integer userId = memberRepository.findUserIdByIdNumber(idNumber);

        if (userId != null) {
            return ResponseEntity.ok(userId);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    @PostMapping("/add")
    public CommentBean addComment(@RequestBody CommentBean comment) {
        // 驗證必要欄位
        if (comment.getUserid() == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "用戶ID不能為空");
        }

        if (comment.getTopic() == null || comment.getTopic().trim().isEmpty()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "主題不能為空");
        }

        if (comment.getContent() == null || comment.getContent().trim().isEmpty()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "內容不能為空");
        }

        if (comment.getCategory() == null || comment.getCategory().trim().isEmpty()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "分類不能為空");
        }

        // 自動生成 commentid
        int newId = commentRepository.findMaxCommentId().orElse(0) + 1;
        comment.setCommentid(newId);

        // 保存評論
        return commentRepository.save(comment);
    }
    
    @PostMapping("/replies/add")
    public ReplyBean addReply(@RequestBody ReplyBean reply) {
        // 驗證留言內容是否為空
        if (reply.getContent() == null || reply.getContent().trim().isEmpty()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "留言內容不能為空");
        }

        // 驗證評論ID
        if (reply.getCommentid() == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "評論ID不能為空");
        }

        // 從 Session Storage 取得的身份證字號找用戶ID
        String idNumber = reply.getIdNumber();
        Integer userId = memberRepository.findUserIdByIdNumber(idNumber);

        if (userId == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "找不到對應的用戶");
        }

     // 從會員表中查詢性別
        Optional<MembersBean> memberOpt = memberRepository.findById(userId);
        String gender = memberOpt.map(MembersBean::getGender).orElse("未知");
        

        // 設置用戶ID和性別
        reply.setUserid(userId);
        reply.setGender(gender);

        
        // 自動生成 replyid
        int newId = replyRepository.findMaxReplyId().orElse(0) + 1;
        reply.setReplyid(newId);

        // 保存留言
        return replyRepository.save(reply);
    }


    
    
    @DeleteMapping("/replies/{replyId}")
    public ResponseEntity<?> deleteReply(@PathVariable Integer replyId) {
       try {
           replyRepository.deleteById(replyId);
           return ResponseEntity.ok().build();
       } catch(Exception e) {
           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
       }
    }

    @PutMapping("/replies/{replyId}")
    public ResponseEntity<ReplyBean> updateReply(@PathVariable Integer replyId, @RequestBody ReplyBean updatedReply) {
       Optional<ReplyBean> replyOpt = replyRepository.findById(replyId);
       
       if(!replyOpt.isPresent()) {
           return ResponseEntity.notFound().build();
       }

       ReplyBean reply = replyOpt.get();
       reply.setContent(updatedReply.getContent());
       
       try {
           ReplyBean savedReply = replyRepository.save(reply);
           return ResponseEntity.ok(savedReply);
       } catch(Exception e) {
           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
       }
    }
    
    
//刪除評論
//    @DeleteMapping("/{commentId}")
//    public void deleteComment(@PathVariable("commentId") int commentId) {
//        System.out.println("刪除請求的評論 ID：" + commentId);
//
//        if (commentRepository.existsById(commentId)) {
//            commentRepository.deleteById(commentId);
//            System.out.println("成功刪除評論 ID：" + commentId);
//        } else {
//            System.out.println("評論 ID 不存在：" + commentId);
//            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "評論不存在");
//        }
//    }
  //刪除評論
    @DeleteMapping("/{commentId}")
    @Transactional
    public void deleteComment(@PathVariable("commentId") int commentId) {
        replyRepository.deleteByCommentid(commentId);
        if (commentRepository.existsById(commentId)) {
            commentRepository.deleteById(commentId);
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "評論不存在");
        }
    }
    
    
    
    //修改
    @PutMapping("/{commentId}")
    public CommentBean updateComment(@PathVariable int commentId, @RequestBody CommentBean updatedComment) {
        if (!commentRepository.existsById(commentId)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "評論不存在");
        }
        updatedComment.setCommentid(commentId);
        return commentRepository.save(updatedComment);
    }


    @GetMapping("/findalljson")
    public List<Map<String, Object>> findAllCommentsWithUserDetails() {
        List<CommentBean> comments = commentRepository.findAll();
        List<Map<String, Object>> result = new ArrayList<>();

        for (CommentBean comment : comments) {
            Map<String, Object> commentMap = new HashMap<>();
            commentMap.put("commentid", comment.getCommentid());
            commentMap.put("topic", comment.getTopic());
            commentMap.put("content", comment.getContent());
            commentMap.put("category", comment.getCategory());
            commentMap.put("userid", comment.getUserid()); // 直接使用 comment.getUserid()
            // 從會員表查找用戶資訊
            Optional<MembersBean> memberOpt = memberRepository.findById(comment.getUserid());
            if (memberOpt.isPresent()) {
            	MembersBean member = memberOpt.get();
                commentMap.put("username", member.getUsername());
                commentMap.put("gender", member.getGender());
            } else {
                commentMap.put("username", "未知");
                commentMap.put("gender", "未知");
            }

            result.add(commentMap);
        }

        return result;
    }


//    @GetMapping("/replies/comment/{commentId}")
//    public List<ReplyBean> getRepliesByComment(@PathVariable Integer commentId) {
//        List<Object[]> results = replyRepository.findByCommentidWithUsername(commentId);
//        List<ReplyBean> replies = new ArrayList<>();
//        
//        for (Object[] result : results) {
//            ReplyBean reply = (ReplyBean) result[0];
//            reply.setUsername((String) result[1]);
//            replies.add(reply);
//        }
//        
//        return replies;
//    }
    
    
//    @GetMapping("/replies/comment/{commentId}")
//    public List<Map<String, Object>> getRepliesByComment(@PathVariable Integer commentId) {
//        List<ReplyBean> replies = replyRepository.findByCommentid(commentId);
//        List<Map<String, Object>> result = new ArrayList<>();
//
//        for (ReplyBean reply : replies) {
//            Map<String, Object> replyMap = new HashMap<>();
//            replyMap.put("replyid", reply.getReplyid());
//            replyMap.put("content", reply.getContent());
//            replyMap.put("commentid", reply.getCommentid());
//            replyMap.put("userid", reply.getUserid());
//            replyMap.put("username", reply.getUsername());
//
//            // 使用 findById 方法查詢用戶
//            System.out.println("Fetching member for userid: " + reply.getUserid());
//            Optional<MembersBean> memberOptional = memberRepository.findById(reply.getUserid());
//            if (memberOptional.isPresent()) {
//                MembersBean member = memberOptional.get();
//                System.out.println("Member found - ID: " + member.getId());
//                System.out.println("Member username: " + member.getUsername());
//                System.out.println("Member gender: " + member.getGender());
//
//                replyMap.put("gender", member.getGender());
//            } else {
//                System.out.println("No member found for userid: " + reply.getUserid());
//                replyMap.put("gender", null);
//            }
//
//            result.add(replyMap);
//        }
//
//        return result;
//    }
    
    @GetMapping("/replies/comment/{commentId}")
    public List<Map<String, Object>> getRepliesByComment(@PathVariable Integer commentId) {
        List<ReplyBean> replies = replyRepository.findByCommentid(commentId);
        List<Map<String, Object>> result = new ArrayList<>();

        for (ReplyBean reply : replies) {
            Map<String, Object> replyMap = new HashMap<>();
            replyMap.put("replyid", reply.getReplyid());
            replyMap.put("content", reply.getContent());
            replyMap.put("commentid", reply.getCommentid());
            replyMap.put("userid", reply.getUserid());
            replyMap.put("username", reply.getUsername());
            replyMap.put("gender", reply.getGender());

            result.add(replyMap);
        }

        return result;
    }

    
    
 // 新增: 獲取特定評論的留言數
    @GetMapping("/comment/{commentId}/count")
    public ResponseEntity<Integer> getReplyCountByCommentId(@PathVariable Long commentId) {
        try {
            int count = replyRepository.countByCommentid(commentId);
            return ResponseEntity.ok(count);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(0);
        }
    }
    
    
    
}
