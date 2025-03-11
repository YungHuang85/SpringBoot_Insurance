package insurance.main.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import insurance.main.model.QABean;
import insurance.main.model.QARepository;

import java.util.List;
//網址  http://localhost:8081/QA/page
@Controller
@RequestMapping("/QA")
public class QAController {

    @Autowired
    private QARepository qaRepository;

    // 顯示 QA 操作介面 (導向 QA.jsp)
  //網址為:   http://localhost:8081/QA/page
    @GetMapping("/page")
    public String showQAPage(Model model) {
        List<QABean> qaList = qaRepository.findAll();
        model.addAttribute("qaList", qaList);
        return "QA";
    }

 // 搜尋功能
    @GetMapping("/search")
    public String searchQA(@RequestParam String keyword, Model model) {
        List<QABean> qaList;
        if (keyword != null && !keyword.trim().isEmpty()) {
            // 修改這裡使用正確的Repository方法名稱
            qaList = qaRepository.findByQuestionContainingIgnoreCaseOrAnswerContainingIgnoreCase(keyword, keyword);
        } else {
            qaList = qaRepository.findAll();
        }
        model.addAttribute("qaList", qaList);
        return "QA";
    }
    
    // 新增 QA
    @PostMapping("/add")
    public String createQA(@ModelAttribute QABean qaBean) {
    	 int newId = qaRepository.findMaxQaid().orElse(0) + 1;
    	 qaBean.setQaid(newId);
        qaRepository.save(qaBean);
        return "redirect:/QA/page";
    }

    // 刪除 QA
    @PostMapping("/delete")
    public String deleteQA(@RequestParam Integer qaid) {
        if (!qaRepository.existsById(qaid)) {
            throw new IllegalArgumentException("QA 編號不存在！");
        }
        qaRepository.deleteById(qaid);
        return "redirect:/QA/page";
    }

    // 更新 QA
    @PostMapping("/update")
    public String updateQA(@ModelAttribute QABean qaBean) {
        qaRepository.findById(qaBean.getQaid()).ifPresent(existingQA -> {
            existingQA.setQuestion(qaBean.getQuestion());
            existingQA.setAnswer(qaBean.getAnswer());
            qaRepository.save(existingQA);
        });
        return "redirect:/QA/page";
    }
}

