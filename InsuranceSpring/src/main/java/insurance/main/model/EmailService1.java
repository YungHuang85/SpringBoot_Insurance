package insurance.main.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService1 {

    @Autowired
    private JavaMailSender javaMailSender;

    // 發送郵件的邏輯
    public void sendEmail(String to, String subject, String body) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(to); // 設定收件人
        message.setSubject(subject); // 設定主題
        message.setText(body); // 設定郵件內容
        javaMailSender.send(message); // 發送郵件
    }
}
