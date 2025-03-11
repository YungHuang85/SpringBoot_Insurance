package insurance.main.awsmodel;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 電子郵件控制器 (EmailController)
 * 負責處理與電子郵件發送相關的 API 請求，包括產生 PDF 並附加至郵件發送。
 */

@RestController
@RequestMapping("/api/emails")
public class EmailController {

    @Autowired
    private EmailService emailService;

    @PostMapping("/send-pdf") // 設定 POST 請求端點
    public String sendEmailWithPdf(@RequestBody EmailRequest emailRequest) {
        try {
        	// 取得郵件內容
            String body = emailRequest.getBody();
            // 按照雙換行符號拆分內容
            String[] sections = body.split("\n\n");

            // 假設前端送了三段內容：sections[0] = 保單號碼, sections[1] = 投保人資料, sections[2] = 受益人資料
            String policyNumber   = sections.length > 0 ? sections[0] : "";
            String clientData     = sections.length > 1 ? sections[1] : "";
            String beneficiaryData = sections.length > 2 ? sections[2] : "";

            // 產生 PDF
            byte[] pdfBytes = PdfGenerator.generateSimplePdf(policyNumber, clientData, beneficiaryData);

            // 發送電子郵件，並附加 PDF 檔案
            emailService.sendEmailWithPdfAttachment(
                emailRequest.getTo(),
                emailRequest.getSubject(),
                "感謝您使用本服務! 我們非常高興地通知您的投保申請已經成功完成，詳細資料請參考附件，如有問題歡迎聯繫客服。", 
                pdfBytes
            );

            return "已成功寄出 PDF 保單至 " + emailRequest.getTo();
        } catch (Exception e) {
            e.printStackTrace();
            return "寄送失敗: " + e.getMessage();
        }
    }
}
