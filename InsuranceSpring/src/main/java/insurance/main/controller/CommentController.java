package insurance.main.controller;

import insurance.main.model.CommentBean;
import insurance.main.model.CommentRepository;

import insurance.main.model.ReplyBean;
import insurance.main.model.MembersBean;
import insurance.main.model.mrepository; 
import insurance.main.model.MemberRepository;
import insurance.main.model.ReplyRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.ui.Model;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;



//網址    http://localhost:8081/comments
@Controller
@RequestMapping("/comments")
public class CommentController {
    private static final List<String> COMMENT_CATEGORIES = List.of(
            "保單設計", "理賠服務", "客服服務", "優惠活動", "網站體驗", "其他"
    );

    @Autowired
    private CommentRepository commentRepository;
    @Autowired
    private MemberRepository membersRepository;
    
    @Autowired
    private ReplyRepository replyRepository;
    
    
    @Autowired
    private mrepository mrepository;

    @GetMapping
    public String showCommentPage(Model model) {
        List<CommentBean> comments = commentRepository.findAll();
        model.addAttribute("comments", comments);
        model.addAttribute("commentBean", new CommentBean());
        model.addAttribute("commentCategories", COMMENT_CATEGORIES);
        return "Comment";
    }
    
    
 // 添加更新評論的方法
    @PostMapping("/update/{id}")  // 確保這個路徑正確
    @ResponseBody
    public ResponseEntity<?> updateComment(
        @PathVariable("id") Integer id,
        @RequestParam String topic,
        @RequestParam String content,
        @RequestParam String category
    ) {
        try {
            Optional<CommentBean> optionalComment = commentRepository.findById(id);
            if (optionalComment.isPresent()) {
                CommentBean comment = optionalComment.get();
                comment.setTopic(topic);
                comment.setContent(content);
                comment.setCategory(category);
                commentRepository.save(comment);
                return ResponseEntity.ok().build();
            }
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            e.printStackTrace();  // 加入這行來看錯誤詳情
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
    
    
    
    

    @PostMapping("add")
    public String createComment(@ModelAttribute CommentBean commentBean) {
        // Get the maximum commentid
        int newId = commentRepository.findMaxCommentId().orElse(0) + 1;
        commentBean.setCommentid(newId);

        // Find the "e保通" member
        Optional<MembersBean> optionalMember = mrepository.findByUsername("e保通");
        if (optionalMember.isPresent()) {
            MembersBean member = optionalMember.get();
            commentBean.setUserid(member.getId());
            commentBean.setUsername(member.getUsername());
        } else {
            commentBean.setUserid(0);
            commentBean.setUsername("匿名");
        }

        // Save the comment
        commentRepository.save(commentBean);
        return "redirect:/comments";
    }

//    @PostMapping("/update/{id}")
//    public ResponseEntity<?> updateComment(
//        @PathVariable Integer id,
//        @RequestParam String topic,
//        @RequestParam String content,
//        @RequestParam String category
//    ) {
//        Optional<CommentBean> optionalComment = commentRepository.findById(id);
//        
//        if (optionalComment.isPresent()) {
//            CommentBean comment = optionalComment.get();
//            
//            // 更新評論內容
//            comment.setTopic(topic);
//            comment.setContent(content);
//            comment.setCategory(category);
//            
//            commentRepository.save(comment); // 保存更新
//            
//            return ResponseEntity.ok().build(); // 返回成功響應
//        } else {
//            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("評論不存在");
//        }
//    }



    
    
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<?> deleteComment(@PathVariable Integer id) {
        try {
            commentRepository.deleteById(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // Method to get the maximum commentid
    public int findMaxCommentId() {
        return commentRepository.findMaxCommentId().orElse(0);
    }
    
    
    @GetMapping("/search")
    @ResponseBody  // 重要：加上這個註解
    public List<CommentBean> searchComments(@RequestParam String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return Collections.emptyList(); // 返回空列表比拋出異常更友好
        }
        try {
            return commentRepository.findByTopicContainingIgnoreCaseOrContentContainingIgnoreCaseOrCategoryContainingIgnoreCase(
                keyword, keyword, keyword
            );
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList(); // 出錯也返回空列表
        }
    }
    
    
    
 // 添加這些新方法
    @GetMapping("/reply")  // 從 /insurance/reply 改成 /reply
    public String showReply(Model model) {
        List<ReplyBean> replies = replyRepository.findAll();
        model.addAttribute("replies", replies);
        return "Reply";
    }

    @DeleteMapping("/reply/delete/{id}")
    @ResponseBody
    public ResponseEntity<?> deleteReply(@PathVariable Integer id) {
        try {
            replyRepository.deleteById(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
    
    
    
    
    
    
}

