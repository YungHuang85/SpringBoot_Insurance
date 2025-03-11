package insurance.main.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import insurance.main.model.QABean;
import insurance.main.model.QARepository;

import java.util.List;

@RestController
@RequestMapping("/api/QA")
public class QArestcontroller {

    @Autowired
    private QARepository qaRepository;

    // 查詢所有 QA 資料 (JSON 格式)
    //http://localhost:8081/api/QA/findalljson
    @CrossOrigin(origins = "http://localhost:5173") // 允許來自前端的請求
    @GetMapping("/findalljson")
    public List<QABean> getAllQA() {
        return qaRepository.findAll();
    }

    @CrossOrigin(origins = "http://localhost:5173")
    @GetMapping("/search")
    public List<QABean> searchQA(@RequestParam String keyword) {
        return qaRepository.findByQuestionContainingIgnoreCaseOrAnswerContainingIgnoreCase(keyword, keyword);
    }
    
    
    
}
