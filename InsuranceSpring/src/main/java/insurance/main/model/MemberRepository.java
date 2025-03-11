package insurance.main.model;

import java.time.LocalDateTime;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface MemberRepository extends JpaRepository<MembersBean, Long> {
////    MembersBean findByIdNumber(String idNumber); 
//	 Optional<MembersBean> findByIdNumber(String idNumber);
//
//	 @Query("SELECT CASE WHEN COUNT(m) > 0 THEN true ELSE false END FROM MembersBean m WHERE m.idNumber = :idNumber AND m.password = :password")
//	 boolean existsByIdNumberAndPassword(@Param("idNumber") String idNumber, @Param("password") String password);
//
//	 Optional<MembersBean> findById(Long id);
//
//	 MembersBean indByIdNumber(String idNumber);
    // 查詢會員資料 by 身份證字號
    Optional<MembersBean> findByIdNumber(String idNumber);

    // 驗證會員是否存在 (身份證字號和密碼)
    @Query("SELECT COUNT(m) > 0 FROM MembersBean m WHERE m.idNumber = :idNumber AND m.password = :password")
    boolean existsByIdNumberAndPassword(@Param("idNumber") String idNumber, @Param("password") String password);

    // 查詢會員資料 by ID
    Optional<MembersBean> findById(Long id);
    
    @Query("SELECT m FROM MembersBean m WHERE LOWER(m.idNumber) = LOWER(:idNumber)")
    Optional<MembersBean> findByIdNumberIgnoreCase(@Param("idNumber") String idNumber);
    

    @Query("SELECT COUNT(m) FROM MembersBean m WHERE m.createdAt BETWEEN :start AND :end")
    Long countByCreatedAtBetween(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);


}
