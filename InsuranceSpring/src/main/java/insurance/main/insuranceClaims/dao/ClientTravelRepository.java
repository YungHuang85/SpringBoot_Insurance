package insurance.main.insuranceClaims.dao;

import java.util.List;
import insurance.main.insuranceClaims.dto.TravelClient2AndBeneficiary;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import insurance.main.insuranceClaims.bean.ClientTravelBean2;

public interface ClientTravelRepository  extends JpaRepository<ClientTravelBean2, String> {

    

	@Transactional
	@Query("SELECT c FROM ClientTravelBean c WHERE c.id_number = :idNumber")
    Optional<ClientTravelBean2> findByIdNumber(@Param("idNumber") String idNumber);
	
	@Transactional
	@Query("SELECT new insurance.main.insuranceClaims.dto.TravelClient2AndBeneficiary("
            + "b.beneficiaryName, b.beneficiaryID, "
            + "t.insuranceNumber, t.username, "
            + "t.id_number, t.birthday, t.phone, "
            + "t.email, t.address, t.insuranceProduct) "
            + "FROM ClientTravelBean t "
            + "LEFT JOIN BeneBean b ON b.insuranceNumber = t.insuranceNumber "
            + "LEFT JOIN InsuranceClaimBean i ON t.insuranceNumber = i.policyNumber "
            + "WHERE t.id_number = :id_number "
            + "AND i.policyNumber IS NULL")
	List<TravelClient2AndBeneficiary> findBeneficiaryAndTravelClientByID(
	    @Param("id_number") String idNumber);
	
	
	
}

