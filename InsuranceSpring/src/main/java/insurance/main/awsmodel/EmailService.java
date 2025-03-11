package insurance.main.awsmodel;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.ses.SesClient;
import software.amazon.awssdk.services.ses.model.RawMessage;
import software.amazon.awssdk.services.ses.model.SendRawEmailRequest;
import software.amazon.awssdk.services.ses.model.SesException;

import jakarta.mail.MessagingException;
import jakarta.mail.Session;
import jakarta.mail.internet.*;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Properties;

/**
 * EmailService (電子郵件服務)
 * 此類別負責透過 Amazon SES (Simple Email Service) 寄送電子郵件，並支援附加 PDF 檔案。
 */

@Service
public class EmailService {

    @Autowired
    private SesClient sesClient;

    
    //透過 AWS SES 寄送含 PDF 附件的電子郵件
    public void sendEmailWithPdfAttachment(String to, String subject, String bodyText, byte[] pdfData) {
        try {
            // 透過 Session 建立 MimeMessage
            Session session = Session.getDefaultInstance(new Properties());
            MimeMessage mimeMessage = new MimeMessage(session);

            // 寄件人 (必須是你已驗證過的 SES 信箱)
            mimeMessage.setFrom(new InternetAddress("yihuang3840@gmail.com"));

            // 收件人
            mimeMessage.setRecipients(jakarta.mail.Message.RecipientType.TO, InternetAddress.parse(to));
            // 信件主旨
            mimeMessage.setSubject(subject, "UTF-8");

            // 建立 Multipart，"mixed" 代表此郵件包含附件
            MimeMultipart mimeMultipart = new MimeMultipart("mixed"); 

            // 設定郵件正文 (純文字)
            MimeBodyPart textPart = new MimeBodyPart();
            textPart.setContent(bodyText, "text/plain; charset=UTF-8");
            mimeMultipart.addBodyPart(textPart);

            // 設定 PDF 附件
            MimeBodyPart attachmentPart = new MimeBodyPart();
            attachmentPart.setFileName(MimeUtility.encodeText("保單內容.pdf", "UTF-8", null));
            attachmentPart.setContent(pdfData, "application/pdf");
            mimeMultipart.addBodyPart(attachmentPart);

            // 將 multipart 設定為信件內容
            mimeMessage.setContent(mimeMultipart);

            // 換為 byte[] 格式，以便傳遞給 AWS SES
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            mimeMessage.writeTo(outputStream);
            byte[] rawBytes = outputStream.toByteArray();

            // 建立並發送 RawEmail 請求
            RawMessage rawMessage = RawMessage.builder()
                    .data(SdkBytes.fromByteArray(rawBytes))
                    .build();

            // 5) 寄送
            SendRawEmailRequest rawEmailRequest = SendRawEmailRequest.builder()
                    .rawMessage(rawMessage)
                    .build();
            sesClient.sendRawEmail(rawEmailRequest);

            System.out.println("郵件 (含 PDF 附件) 已成功發送至 " + to);

        } catch (SesException e) {
            System.err.println("郵件發送失敗 (SES)： " + e.getMessage());
        } catch (MessagingException | IOException e) {
            System.err.println("郵件建立失敗 (MIME)： " + e.getMessage());
        }
    }
}
