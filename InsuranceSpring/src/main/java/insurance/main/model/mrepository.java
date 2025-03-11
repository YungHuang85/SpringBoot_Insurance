package insurance.main.model;



import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;


@Repository

public interface mrepository extends JpaRepository<MembersBean, Integer> {
//    MembersBean findByIdNumber(String idNumber); 
	 Optional<MembersBean> findByIdNumber(String idNumber);

	 @Query("SELECT CASE WHEN COUNT(m) > 0 THEN true ELSE false END FROM MembersBean m WHERE m.idNumber = :idNumber AND m.password = :password")
	 boolean existsByIdNumberAndPassword(@Param("idNumber") String idNumber, @Param("password") String password);

//	 Optional<MembersBean> findById(Long id);
	 
	 Optional<MembersBean> findById(Integer userid);
	 
	 
	// 通過 idNumber 查找用戶 ID 的方法
	 @Query("SELECT m.id FROM MembersBean m WHERE m.idNumber = :idNumber")
	    Integer findUserIdByIdNumber(@Param("idNumber") String idNumber);
	 
	 
	 @Query("SELECT m FROM MembersBean m WHERE m.username = :username")
	    Optional<MembersBean> findByUsername(@Param("username") String username);
	 
	 
	 // 添加這個方法
	    @Query("SELECT m FROM MembersBean m WHERE m.id = :userId")
	    Optional<MembersBean> findMemberById(@Param("userId") Integer userId);
	 
	 
}