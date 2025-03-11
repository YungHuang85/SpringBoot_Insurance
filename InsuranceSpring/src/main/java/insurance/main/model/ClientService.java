package insurance.main.model;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.PageRequest;


@Service
public class ClientService {

    @Autowired
    private ClientRepository clientRepository;

    @Autowired
    private BeneRepository beneRepository;

    public List<ClientBean> getAllClients() {
        return clientRepository.findAll();
    }

    public List<BeneBean1> getAllBeneficiaries() {
        return beneRepository.findAll();
    }
    
    // 新增投保人與受益人資料
    @Transactional
    public void insertClientTravel(List<ClientBean> clientList, List<BeneBean1> beneList) {
        for (int i = 0; i < clientList.size(); i++) {
            ClientBean client = clientList.get(i);
            BeneBean1 bene = beneList.get(i);

            // 儲存投保人資料
            clientRepository.save(client);
            
         // 設定受益人與投保人的關聯
            bene.setClient(client);
            beneRepository.save(bene);
        }
    }
    
    // 刪除投保人與其對應的受益人
    @Transactional
    public void deleteClient(String insuranceNumber) {
        clientRepository.findById(insuranceNumber).ifPresent(client -> {
            beneRepository.deleteAll(client.getBeneficiaries());  // 先刪除與該投保人關聯的所有受益人
            clientRepository.delete(client); // 再刪除投保人
        });
    }

    // 更新投保人資料
    @Transactional
    public void updateClient(ClientBean clientBean) {
    	// 更新投保人資料
        clientRepository.findById(clientBean.getInsuranceNumber()).ifPresent(existingClient -> {
            existingClient.setAccount(clientBean.getAccount());
            existingClient.setUsername(clientBean.getUsername());
            existingClient.setId_number(clientBean.getId_number());
            existingClient.setProduct(clientBean.getProduct());
            existingClient.setLocation(clientBean.getLocation());
            existingClient.setStartTime(clientBean.getStartTime());
            existingClient.setEndTime(clientBean.getEndTime());
            existingClient.setSumAssured(clientBean.getSumAssured());
            existingClient.setPremiums(clientBean.getPremiums());
            existingClient.setProfilePicture(clientBean.getProfilePicture());
            existingClient.setUpdateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
            existingClient.setMedicalTreatment(clientBean.getMedicalTreatment());
            existingClient.setOverseasIllness(clientBean.getOverseasIllness());
            existingClient.setOverseasFlights(clientBean.getOverseasFlights());
            existingClient.setTotalCost(clientBean.getTotalCost());
            clientRepository.save(existingClient);// 儲存更新後的投保人資料
        });
    }

    // 更新受益人資料
    @Transactional
    public void updateBeneficiary(BeneBean1 beneBean) {
        beneRepository.findById(beneBean.getInsuranceNumber()).ifPresent(existingBene -> {
            existingBene.setRelationship(beneBean.getRelationship());
            existingBene.setBeneficiaryName(beneBean.getBeneficiaryName());
            existingBene.setBeneficiaryID(beneBean.getBeneficiaryID());
            existingBene.setBeneficiaryBirthday(beneBean.getBeneficiaryBirthday());
            existingBene.setBeneficiaryGender(beneBean.getBeneficiaryGender());
            existingBene.setBeneficiaryPhone(beneBean.getBeneficiaryPhone());
            existingBene.setBeneficiaryAddress(beneBean.getBeneficiaryAddress());
            beneRepository.save(existingBene); // 儲存更新後的受益人資料
        });
    }
}
