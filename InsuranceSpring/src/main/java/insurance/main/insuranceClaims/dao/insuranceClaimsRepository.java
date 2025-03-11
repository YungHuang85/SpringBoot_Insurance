package insurance.main.insuranceClaims.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import insurance.main.insuranceClaims.bean.InsuranceClaimBean;

public interface insuranceClaimsRepository extends JpaRepository<InsuranceClaimBean, String> {

	List<InsuranceClaimBean> findByPolicyNumberContaining(String policyNumber);
	
	List<InsuranceClaimBean> findByIdNumber(String idNumber);

//	@Modifying
//	@Transactional
//	@Query("UPDATE insuranceClaim c SET  c.claimStatus = :claimStatus WHERE c.policyNumber = :policyNumber")
//	int updatePolicyNumberAndClaimStatus(@Param("policyNumber") String policyNumber,
//			@Param("claimStatus") String claimStatus);
//	
	
//	@Modifying
//	@Transactional
//	@Query(value = "UPDATE insuranceClaim SET claimStatus = :claimStatus WHERE policyNumber = :policyNumber", nativeQuery = true)
//	int updatePolicyNumberAndClaimStatus(@Param("policyNumber") String policyNumber,
//	                            @Param("claimStatus") String claimStatus);
	
	
	@Modifying
	@Transactional
	@Query(value = "UPDATE insuranceClaim \r\n"
			+ "SET claimStatus = :claimStatus, \r\n"
			+ "    comment = :comment, \r\n"
			+ "    claimAmount = :claimAmount, \r\n"
			+ "    reviewer = :reviewer \r\n"
			+ "WHERE policyNumber = :policyNumber;", nativeQuery = true)
	int updatePolicyNumberAndClaimStatusAndCommentAndClaimAmount(@Param("policyNumber") String policyNumber,
	                            @Param("claimStatus") String claimStatus,@Param("comment") String comment,@Param("claimAmount") String claimAmount,
	                            @Param("reviewer") String reviewer);

}
