package insurance.main.awsmodel;

import com.itextpdf.kernel.colors.ColorConstants;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.pdf.*;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.*;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.layout.properties.UnitValue;

import java.io.ByteArrayOutputStream;

/**
 * PdfGenerator (PDF 產生器)
 * 此類別負責生成 PDF 保單文件，內容包括：
 * - 保單號碼或投保類型
 * - 投保人資訊 (表格)
 * - 受益人資訊 (表格)
 */
public class PdfGenerator {

	//產生PDF保單
    
    public static byte[] generateSimplePdf(String policyNumber, String clientData, String beneficiaryData) throws Exception {
        // 用於存放 PDF 文件的內存
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();

        // 初始化 PDF 寫入器和文檔
        PdfWriter writer = new PdfWriter(byteArrayOutputStream);
        PdfDocument pdfDoc = new PdfDocument(writer);
        Document document = new Document(pdfDoc);

        // 載入支持中文的字體
        String fontPath = "src/main/resources/fonts/NotoSansCJKtc-Regular.otf"; // 字體檔案路徑
        PdfFont font = PdfFontFactory.createFont(fontPath, PdfFontFactory.EmbeddingStrategy.FORCE_EMBEDDED);

        // 主標題
        document.add(new Paragraph("保單內容")
                .setFont(font)
                .setBold()
                .setFontSize(16)
                .setTextAlignment(TextAlignment.CENTER)
        );

        // 顯示保單號碼
        document.add(new Paragraph(policyNumber)
                .setFont(font)
                .setFontSize(12)
                .setBold()
                .setMarginBottom(5)
        );

        // 投保人資訊 - 標題
        document.add(new Paragraph("■ 投保人資訊")
                .setFont(font)
                .setFontSize(13)
                .setBold()      
        );

        // 建立「投保人資訊」表格
        Table clientTable = new Table(UnitValue.createPercentArray(new float[]{3, 7}))
                .useAllAvailableWidth();
        // 表頭 (可自行取捨是否需要)
        clientTable.addHeaderCell(new Cell().add(new Paragraph("欄位").setFont(font).setBold())
                .setBackgroundColor(ColorConstants.LIGHT_GRAY)
                .setTextAlignment(TextAlignment.CENTER));
        clientTable.addHeaderCell(new Cell().add(new Paragraph("內容").setFont(font).setBold())
                .setBackgroundColor(ColorConstants.LIGHT_GRAY)
                .setTextAlignment(TextAlignment.CENTER));

        // 逐行加入投保人資料
        for (String line : clientData.split("\n")) {
            String[] parts = line.split("：", 2);
            if (parts.length == 2) {
                clientTable.addCell(new Cell().add(new Paragraph(parts[0]).setFont(font).setBold()));
                clientTable.addCell(new Cell().add(new Paragraph(parts[1]).setFont(font)));
            }
        }
        // 將投保人表格加入 PDF
        document.add(clientTable);

        // 與下一個表格之間留一點空行
        document.add(new Paragraph("\n"));

        // 受益人資訊 - 標題
        document.add(new Paragraph("■ 受益人資訊")
                .setFont(font)
                .setFontSize(13)
                .setBold()
                .setMarginBottom(5)
        );

        // 建立「受益人」表格
        Table beneTable = new Table(UnitValue.createPercentArray(new float[]{3, 7}))
                .useAllAvailableWidth();
        // 表頭 (可自行取捨是否需要)
        beneTable.addHeaderCell(new Cell().add(new Paragraph("欄位").setFont(font).setBold())
                .setBackgroundColor(ColorConstants.LIGHT_GRAY)
                .setTextAlignment(TextAlignment.CENTER));
        beneTable.addHeaderCell(new Cell().add(new Paragraph("內容").setFont(font).setBold())
                .setBackgroundColor(ColorConstants.LIGHT_GRAY)
                .setTextAlignment(TextAlignment.CENTER));

        // 逐行加入受益人資料
        for (String line : beneficiaryData.split("\n")) {
            String[] parts = line.split("：", 2);
            if (parts.length == 2) {
                beneTable.addCell(new Cell().add(new Paragraph(parts[0]).setFont(font).setBold()));
                beneTable.addCell(new Cell().add(new Paragraph(parts[1]).setFont(font)));
            }
        }
        // 將受益人表格加入 PDF
        document.add(beneTable);

        // 7) 結尾
        document.add(new Paragraph("\n感謝您的投保！")
                .setFont(font)
                .setTextAlignment(TextAlignment.RIGHT)
        );

        // 關閉文檔
        document.close();

        // 回傳產生的 PDF
        return byteArrayOutputStream.toByteArray();
    }
}
