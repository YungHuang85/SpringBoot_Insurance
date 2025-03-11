package insurance.premiums.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TravelPremiumsService {

    @Autowired
    private TravelPremiumsRepository exampleRepository;

    public Integer findValueByIdAndKey(Integer id, String key) {
    	// 透過 Repository 層查詢 MongoDB，找出對應 ID 的文件
        TravelPremiumsBean document = exampleRepository.findBy_id(id);
        // 如果找到資料，根據 key 取得對應的保費數值
        if (document != null) {
            switch (key) {
                case "100W":
                    return document.getW100();
                case "300W":
                    return document.getW300();
                case "500W":
                    return document.getW500();
                case "700W":
                    return document.getW700();
                case "1000W":
                    return document.getW1000();
                default:
                	// 若 key 不符合預期值，拋出 IllegalArgumentException
                    throw new IllegalArgumentException("Invalid key: " + key);
            }
        }
        // 如果找不到該 ID 的文件，拋出 RuntimeException
        throw new RuntimeException("Document not found for id: " + id);
    }
}
