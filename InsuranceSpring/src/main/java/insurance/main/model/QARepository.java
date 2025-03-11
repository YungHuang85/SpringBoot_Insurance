package insurance.main.model;


import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface QARepository extends JpaRepository<QABean, Integer> {
	List<QABean> findByQuestionContainingIgnoreCaseOrAnswerContainingIgnoreCase(String question, String answer);
	
	@Query("SELECT MAX(q.qaid) FROM QABean q")
	Optional<Integer> findMaxQaid();
	
}
