package insurance.main.controller;




import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import insurance.main.model.ReplyBean;
import insurance.main.model.ReplyRepository;

import java.util.List;


@RestController
@RequestMapping("/api/replies")
@CrossOrigin(origins = "http://localhost:5173")
public class ReplyRestController {
    
    @Autowired
    private ReplyRepository replyRepository;
    
    @PostMapping("/add")
    public ReplyBean addReply(@RequestBody ReplyBean reply) {
        int newId = replyRepository.findMaxReplyId().orElse(0) + 1;
        reply.setReplyid(newId);
        return replyRepository.save(reply);
    }
    
    @GetMapping("/comment/{commentid}")
    public List<ReplyBean> getRepliesByComment(@PathVariable Integer commentid) {
        return replyRepository.findByCommentid(commentid);
    }
    
    
    
    
    
    
}
