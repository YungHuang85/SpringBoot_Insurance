package insurance.main.model;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
@Transactional
public class BonusProductService {
    
    @Autowired
    private BonusProductRepository bonusproductRepository;

    
    public BonusProductBean getProductByNo(int productno) {
        return bonusproductRepository.findById(productno);
    }
    
    public BonusProductBean getUpdateBonusProduct(Integer productno) {
        Optional<BonusProductBean> result = bonusproductRepository.findById(productno);
        return result.orElseThrow(() -> new RuntimeException("Product not found with id: " + productno));
    }

    public List<BonusProductBean> findAllBonusProduct() {
        return bonusproductRepository.findAll();
    }

    public BonusProductBean insertBonusProduct(BonusProductBean bonusproduct, MultipartFile bonusproductimage) throws IOException {
        if (bonusproductimage != null && !bonusproductimage.isEmpty()) {
            saveImage(bonusproduct, bonusproductimage);
        }
        // 預設 count 值為 0
        bonusproduct.setCount(0);  // 初始化 count 為 0
        return bonusproductRepository.save(bonusproduct);
    }

    
    public BonusProductBean updateBonusProduct(BonusProductBean bonusproduct, MultipartFile bonusproductimage) throws IOException {
        // 查詢並保留原有的 count 值
        Integer originalCount = bonusproduct.getCount(); // 保留原來的兌換次數

        // 只更新圖片，不改動 count 值
        if (bonusproductimage != null && !bonusproductimage.isEmpty()) {
            // 刪除舊圖片（如果存在）
            String oldImagePath = "src/main/webapp" + bonusproduct.getProductimage();
            Files.deleteIfExists(Paths.get(oldImagePath)); // 刪除舊圖片

            // 保存新圖片
            saveImage(bonusproduct, bonusproductimage);
        }
        
        // 設置回保留的 count 值，避免其被更改
        bonusproduct.setCount(originalCount);  // 重設 count 為原來的值

        return bonusproductRepository.save(bonusproduct);  // 更新商品
    }


    private void saveImage(BonusProductBean bonusproduct, MultipartFile bonusproductimage) throws IOException {
        // 獲取原始文件名
        String originalFileName = bonusproductimage.getOriginalFilename();

        // 設置保存路徑
        Path directory = Paths.get("src/main/webapp/BonusMallPic");
        
        // 檢查資料夾是否存在，如果不存在則創建
        if (!Files.exists(directory)) {
            Files.createDirectories(directory);
        }

        // 使用原始文件名直接保存，這樣會覆蓋同名文件
        Path path = directory.resolve(originalFileName); // 使用原始文件名
        
        // 保存文件
        Files.copy(bonusproductimage.getInputStream(), path, java.nio.file.StandardCopyOption.REPLACE_EXISTING); // 覆蓋舊文件
        
        // 將文件路徑存入資料庫
        bonusproduct.setProductimage("/BonusMallPic/" + originalFileName); // 存儲相對於 webapp 的路徑
    }

    public void deleteBonusProduct(Integer productno) {
        bonusproductRepository.deleteById(productno);
    }

    // 根據分類查詢產品
    public List<BonusProductBean> findBonusProductsByCategory(String category) {
        return bonusproductRepository.findByCategory(category);
    }

    // 根據產品名稱模糊查詢
    public List<BonusProductBean> searchBonusProducts(String keyword) {
        return bonusproductRepository.findByProductnameContaining(keyword);
    }
}
