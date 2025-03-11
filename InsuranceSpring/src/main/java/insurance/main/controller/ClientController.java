package insurance.main.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import com.fasterxml.jackson.databind.ObjectMapper;

import insurance.main.model.BeneBean1;
import insurance.main.model.ClientBean;
import insurance.main.model.ClientService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//內建tomcat使用語法
@Controller
@RequestMapping("/clients")
public class ClientController {

    @Autowired
    private ClientService clientService;

    /**
     * 取得所有投保人與受益人資料
     * http://localhost:8081/clients
     */
    @GetMapping
    public String getAllClients(Model model) {
        List<ClientBean> clients = clientService.getAllClients();
        List<BeneBean1> beneficiaries = clientService.getAllBeneficiaries();

        model.addAttribute("clients", clients);
        model.addAttribute("beneficiaries", beneficiaries);
        return "/GetAllClient";
    }
    
    //更新投保人受益人資料
    @PutMapping("/update")
    public String updateClient(
            @RequestParam(value = "insuranceNumber", required = false) String insuranceNumber,
            @RequestParam(value = "account") String account,
            @RequestParam(value = "username", required = false) String username,
            @RequestParam(value = "id_number", required = false) String idNumber,
            @RequestParam(value = "insuranceProduct") String insuranceProduct,
            @RequestParam(value = "country") String country,
            @RequestParam(value = "startTime") String startTime,
            @RequestParam(value = "endTime") String endTime,
            @RequestParam(value = "sumAssured") String sumAssured,
            @RequestParam(value = "premiums") String premiums,
            @RequestParam(value = "profilePicture") MultipartFile profilePicture,       
            @RequestParam(value = "medicalTreatment") String medicalTreatment,
            @RequestParam(value = "overseasIllness") String overseasIllness,
            @RequestParam(value = "overseasFlights") String overseasFlights,
            @RequestParam(value = "totalCost") String totalCost,       
            @RequestParam(value = "relationship") String relationship,
            @RequestParam(value = "beneficiaryName") String beneficiaryName,
            @RequestParam(value = "beneficiaryID") String beneficiaryID,
            @RequestParam(value = "beneficiaryBirthday") String beneficiaryBirthday,
            @RequestParam(value = "beneficiaryGender") String beneficiaryGender,
            @RequestParam(value = "beneficiaryPhone") String beneficiaryPhone,
            @RequestParam(value = "beneficiaryAddress") String beneficiaryAddress,
            RedirectAttributes redirectAttributes) {
        try {
            ClientBean clientBean = new ClientBean();
            clientBean.setInsuranceNumber(insuranceNumber);
            clientBean.setAccount(account);
            clientBean.setUsername(username);
            clientBean.setId_number(idNumber);
            clientBean.setProduct(insuranceProduct);
            clientBean.setLocation(country);
            clientBean.setStartTime(startTime);
            clientBean.setEndTime(endTime);
            clientBean.setSumAssured(sumAssured);
            clientBean.setPremiums(premiums);
            clientBean.setMedicalTreatment(medicalTreatment);
            clientBean.setOverseasIllness(overseasIllness);
            clientBean.setOverseasFlights(overseasFlights);
            clientBean.setTotalCost(totalCost);

            if (profilePicture != null && !profilePicture.isEmpty()) {
                clientBean.setProfilePicture(profilePicture.getBytes());
            } else {
                clientBean.setProfilePicture(null);
            }

            clientService.updateClient(clientBean);

            BeneBean1 beneBean = new BeneBean1();
            beneBean.setInsuranceNumber(insuranceNumber);
            beneBean.setRelationship(relationship);
            beneBean.setBeneficiaryName(beneficiaryName);
            beneBean.setBeneficiaryID(beneficiaryID);
            beneBean.setBeneficiaryBirthday(beneficiaryBirthday);
            beneBean.setBeneficiaryGender(beneficiaryGender);
            beneBean.setBeneficiaryPhone(beneficiaryPhone);
            beneBean.setBeneficiaryAddress(beneficiaryAddress);

            clientService.updateBeneficiary(beneBean);

            redirectAttributes.addFlashAttribute("message", "資料更新成功");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "更新資料時發生錯誤");
            e.printStackTrace();
        }
        return "redirect:/clients";
    }

    //插入投保人受益人資料
    @PostMapping("/insert")
    public ModelAndView insertClientTravel(
            @RequestParam("insuranceNumber[]") String[] insuranceNumber,
            @RequestParam("username[]") String[] username,
            @RequestParam("id_number[]") String[] idNumber,
            @RequestParam("birthday[]") String[] birthday,
            @RequestParam("gender[]") String[] gender,
            @RequestParam("phone[]") String[] phone,
            @RequestParam("email[]") String[] email,
            @RequestParam("address[]") String[] address,
            @RequestParam("insuranceProduct[]") String[] insuranceProduct,
            @RequestParam("country[]") String[] country,
            @RequestParam("startTime[]") String[] startTime,
            @RequestParam("endTime[]") String[] endTime,
            @RequestParam("sumAssured[]") String[] sumAssured,
            @RequestParam("premiums[]") String[] premiums,
            
            @RequestParam("medicalTreatment[]") String[] medicalTreatment,
            @RequestParam("overseasIllness[]") String[] overseasIllness,
            @RequestParam("overseasFlights[]") String[] overseasFlights,
            @RequestParam("totalCost[]") String[] totalCost,       
            
            @RequestParam("relationship[]") String[] relationship,
            @RequestParam("beneficiaryName[]") String[] beneficiaryName,
            @RequestParam("beneficiaryID[]") String[] beneficiaryID,
            @RequestParam("beneficiaryBirthday[]") String[] beneficiaryBirthday,
            @RequestParam("beneficiaryGender[]") String[] beneficiaryGender,
            @RequestParam("beneficiaryPhone[]") String[] beneficiaryPhone,
            @RequestParam("beneficiaryAddress[]") String[] beneficiaryAddress,
            @RequestParam("profilePicture[]") MultipartFile[] profilePictures,
            Model model) {

        List<ClientBean> clientList = new ArrayList<>();
        List<BeneBean1> beneList = new ArrayList<>();

        for (int i = 0; i < insuranceNumber.length; i++) {
            ClientBean client = new ClientBean();
            client.setInsuranceNumber(insuranceNumber[i]);
            client.setUsername(username[i]);
            client.setId_number(idNumber[i]);
            client.setBirthday(birthday[i]);
            client.setGender(gender[i]);
            client.setPhone(phone[i]);
            client.setEmail(email[i]);
            client.setAddress(address[i]);
            client.setProduct(insuranceProduct[i]);
            client.setLocation(country[i]);
            client.setStartTime(startTime[i]);
            client.setEndTime(endTime[i]);
            client.setSumAssured(sumAssured[i]);
            client.setPremiums(premiums[i]);
            
            client.setMedicalTreatment(medicalTreatment[i]);
            client.setOverseasIllness(overseasIllness[i]);
            client.setOverseasFlights(overseasFlights[i]);
            client.setTotalCost(totalCost[i]);
            try {
                if (profilePictures[i] != null && !profilePictures[i].isEmpty()) {
                    client.setProfilePicture(profilePictures[i].getBytes());
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            clientList.add(client);

            BeneBean1 bene1 = new BeneBean1();
            bene1.setInsuranceNumber(insuranceNumber[i]);
            bene1.setRelationship(relationship[i]);
            bene1.setBeneficiaryName(beneficiaryName[i]);
            bene1.setBeneficiaryID(beneficiaryID[i]);
            bene1.setBeneficiaryBirthday(beneficiaryBirthday[i]);
            bene1.setBeneficiaryGender(beneficiaryGender[i]);
            bene1.setBeneficiaryPhone(beneficiaryPhone[i]);
            bene1.setBeneficiaryAddress(beneficiaryAddress[i]);
            beneList.add(bene1);
        }

        try {
            clientService.insertClientTravel(clientList, beneList);
            model.addAttribute("clientList", clientList);
            model.addAttribute("beneList", beneList);
            return new ModelAndView("/InsertClientResult");
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Failed to insert client travel details.");
            return new ModelAndView("error");
        }
    }
    
    //前端請求插入
    @PostMapping("/insert1")
    public ResponseEntity<String> insertClientTravel1(
            @RequestBody Map<String, List<Map<String, Object>>> requestData) {

        ObjectMapper mapper = new ObjectMapper();
        try {
            // 解析投保人資料列表
            List<ClientBean> clientList = requestData.get("clientList").stream()
                .map(data -> mapper.convertValue(data, ClientBean.class))
                .collect(Collectors.toList());

            // 解析受益人資料列表
            List<BeneBean1> beneList = requestData.get("beneList").stream()
                .map(data -> mapper.convertValue(data, BeneBean1.class))
                .collect(Collectors.toList());

            // 保存到資料庫
            clientService.insertClientTravel(clientList, beneList);

            return ResponseEntity.ok("資料提交成功！");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body("資料提交失敗！");
        }
    }
    
   
    //根據帳號查詢保單資訊
    @GetMapping("/policies")
    public ResponseEntity<?> getPoliciesByAccount(@RequestParam String account) {
        try {
            List<ClientBean> policies = clientService.getAllClients().stream()
                    .filter(client -> client.getAccount().equals(account))
                    .collect(Collectors.toList());

            if (policies.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
                    "error", "無保單資料",
                    "account", account
                ));
            }

            return ResponseEntity.ok(policies);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of(
                "error", "查詢保單資料失敗",
                "message", e.getMessage()
            ));
        }
    }
   
    //刪除指定保單的投保人資訊
    @DeleteMapping("/delete")
    public RedirectView deleteClient(@RequestParam("insuranceNumber") String insuranceNumber, RedirectAttributes redirectAttributes) {
        try {
            clientService.deleteClient(insuranceNumber);
            redirectAttributes.addFlashAttribute("message", "Client deleted successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting client: " + e.getMessage());
        }
        return new RedirectView("/clients");
    }
    

}
