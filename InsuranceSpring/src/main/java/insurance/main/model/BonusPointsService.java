package insurance.main.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.time.LocalDate;

@Service
public class BonusPointsService {

    @Autowired
    private BonusPointsRepository pointsRepository;

    @Autowired
    private BonusProductRepository bonusProductRepository;
    
    @Autowired
    private BonusHistoryRepository bonusHistoryRepository;

    @Autowired
    private JavaMailSender javaMailSender;

    // 根據 email 查詢點數
    public BonusPointsBean getPointsByEmail(String email) {
        // 查詢資料庫中的用戶資料
        BonusPointsBean pointsBean = pointsRepository.findByEmail(email);
        if (pointsBean == null) {
            return null; // 如果用戶不存在，返回 null
        }
        return pointsBean;
    }

    // 更新用戶的點數，並且發送郵件
    public ExchangeResult exchangeProduct(String email, int productno) {
        // 查詢用戶點數資料
        BonusPointsBean pointsBean = pointsRepository.findByEmail(email);
        if (pointsBean == null) {
            return new ExchangeResult(false, "用戶不存在");  // 用戶不存在
        }

        // 查找商品資料
        BonusProductBean product = bonusProductRepository.findById(productno);
        if (product == null) {
            return new ExchangeResult(false, "商品不存在");  // 商品不存在
        }

        // 檢查點數是否足夠
        if (pointsBean.getPoints() < product.getCost()) {
            return new ExchangeResult(false, "點數不足，無法兌換");  // 點數不足
        }

        // 扣除點數
        pointsBean.setPoints(pointsBean.getPoints() - product.getCost());
        pointsRepository.save(pointsBean);  // 更新資料庫中的用戶點數
        
        // 更新商品的 count 欄位，表示已兌換
        product.setCount(product.getCount() + 1);  // 假設每次成功兌換，兌換次數加 1
        bonusProductRepository.save(product);  // 更新商品資料

        // 寫入兌換紀錄
        BonusHistoryBean bonusHistory = new BonusHistoryBean();
        bonusHistory.setUsername(pointsBean.getUsername());
        bonusHistory.setEmail(email);
        bonusHistory.setProductname(product.getProductname());
        bonusHistory.setCost(product.getCost());
        bonusHistory.setDate(LocalDate.now());  // 設定為今天的日期
        bonusHistoryRepository.save(bonusHistory);  // 保存兌換紀錄
        
        
        // 發送郵件通知用戶
        try {
			sendEmail(email, product);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        return new ExchangeResult(true, "兌換成功！已寄送兌換通知至您的郵箱");  // 返回成功訊息
    }
    
    
    // 內部類別，表示兌換結果
    public static class ExchangeResult {
        private boolean success;
        private String message;

        public ExchangeResult(boolean success, String message) {
            this.success = success;
            this.message = message;
        }

        public boolean isSuccess() {
            return success;
        }

        public String getMessage() {
            return message;
        }
    }

    // 發送郵件通知用戶
    private void sendEmail(String email, BonusProductBean product) throws IOException, MessagingException {
        BonusPointsBean pointsBean = pointsRepository.findByEmail(email);

        // 生成隨機QR碼內容
        String qrCodeContent = "兌換成功！商品名稱：" + product.getProductname() + ", 消耗點數：" + product.getCost();

        // 生成QR碼圖片
        ByteArrayOutputStream qrCodeOutputStream = generateQRCode(qrCodeContent);

        // 設置郵件內容
        MimeMessage mimeMessage = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);

        helper.setFrom("your-email@example.com");  // 設置發件人
        helper.setTo(email);  // 設置收件人
        helper.setSubject("e險無憂 紅利兌換");  // 設置郵件主題

        // 文字部分
        String text = "親愛的" + pointsBean.getUsername() + "\n\n您已成功兌換 " + product.getProductname() + "，消耗了 " + product.getCost() + " 點數。\n\n感謝您使用我們的服務！";
        helper.setText(text);

        // 附加QR碼圖片
        ByteArrayResource qrCodeResource = new ByteArrayResource(qrCodeOutputStream.toByteArray());
        helper.addAttachment("qrcode.png", qrCodeResource);

        // 寄送郵件
        javaMailSender.send(mimeMessage);
    }

    // 生成QR碼圖片
    private ByteArrayOutputStream generateQRCode(String content) throws IOException {
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = null;
		try {
			bitMatrix = qrCodeWriter.encode(content, BarcodeFormat.QR_CODE, 200, 200);
		} catch (WriterException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // 200x200 像素
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        MatrixToImageWriter.writeToStream(bitMatrix, "png", outputStream);
        return outputStream;
    }

    
}
