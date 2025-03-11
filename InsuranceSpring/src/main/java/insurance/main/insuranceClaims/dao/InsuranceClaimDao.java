package insurance.main.insuranceClaims.dao;

import java.util.List;
import insurance.main.insuranceClaims.dto.TravelClient2AndBeneficiary;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import insurance.main.insuranceClaims.bean.ClientTravelBean2;
import insurance.main.insuranceClaims.bean.InsuranceClaimBean;
import insurance.main.insuranceClaims.dto.TravelClient2AndBeneficiary;

@Repository
@Transactional
public class InsuranceClaimDao {

	@Autowired
	private insuranceClaimsRepository iResp;
	@Autowired
	private ClientTravelRepository cResp;

	public ClientTravelBean2 grtTravelClient(String policyNumber) {

		Optional<ClientTravelBean2> bean = cResp.findById(policyNumber);

		if (bean.isPresent()) {
			return bean.get();
		}
		return null;
	}
	
	public List<ClientTravelBean2> grtTravelClientAll() {

		List<ClientTravelBean2> bean = cResp.findAll();

		return  bean;
	}
	public List<TravelClient2AndBeneficiary> findBeneficiaryAndTravelClientByID(String id_number) {

		List<TravelClient2AndBeneficiary> beans = cResp.findBeneficiaryAndTravelClientByID(id_number);

		return  beans;
	}
	
	public ClientTravelBean2 getTravelClientById(String idNumber) {

		Optional<ClientTravelBean2> bean = cResp.findByIdNumber(idNumber);
		
		if (bean.isPresent()) {
			return bean.get();
		}

		return null;
		
	}

	public InsuranceClaimBean getOne(String policyNumber) {

		Optional<InsuranceClaimBean> bean = iResp.findById(policyNumber);
		if (bean.isPresent()) {
			return bean.get();
		}

		return null;

	}

	public List<InsuranceClaimBean> getSome(String policyNumber) {

		List<InsuranceClaimBean> claimBeans = iResp.findByPolicyNumberContaining(policyNumber);

		return claimBeans;

	}
	
	public List<InsuranceClaimBean> findByIdNumber(String idNumber) {

		List<InsuranceClaimBean> claimBeans = iResp.findByIdNumber(idNumber);

		return claimBeans;

	}
	public List<InsuranceClaimBean> getAll() {

		List<InsuranceClaimBean> beans = iResp.findAll();

		return beans;

	}

	public void insert(InsuranceClaimBean ClaimBean) {
		iResp.save(ClaimBean);
	}

	public void update(String policyNumber,
			 String claimStatus,String comment,String claimAmount,String reviewer){

		iResp.updatePolicyNumberAndClaimStatusAndCommentAndClaimAmount(policyNumber,claimStatus,comment,claimAmount,reviewer);

	}

	public boolean delete(String policyNumber) {

	    try {
	        // 檢查記錄是否存在
	        if (iResp.existsById(policyNumber)) {
	            iResp.deleteById(policyNumber); // 刪除記錄
	            return true; // 刪除成功
	        } else {
	            return false; // 記錄不存在
	        }
	    } catch (Exception e) {
	        // 捕捉異常，記錄錯誤資訊（可選）
	        System.err.println("刪除失敗，錯誤訊息: " + e.getMessage());
	        return false; // 刪除失敗
	    }
	}
	

}
