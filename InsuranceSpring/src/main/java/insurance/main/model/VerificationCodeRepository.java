package insurance.main.model;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface VerificationCodeRepository extends JpaRepository<VerificationCodeBean, Long> {

	// 使用 JPQL 或 Spring Data JPA 的方法命名規範自動生成查詢
    @Query("SELECT v FROM VerificationCodeBean v WHERE v.member.idNumber = :idNumber")
    Optional<VerificationCodeBean> findByIdNumber(@Param("idNumber") String idNumber);
    
    
    Optional<VerificationCodeBean> findByMemberId(Long memberId);
    
    Optional<VerificationCodeBean> findFirstByMemberIdOrderByIdDesc(Integer memberId);


}
