package insurance.premiums.model;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TravelPremiumsRepository extends MongoRepository<TravelPremiumsBean, Integer> {
	//根據 _id 查詢 TravelPremiumsBean
    TravelPremiumsBean findBy_id(Integer id);
}
