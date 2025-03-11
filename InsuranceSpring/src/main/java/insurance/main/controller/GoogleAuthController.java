package insurance.main.controller;

import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping("/api/auth/google")
public class GoogleAuthController {

    private static final String CLIENT_ID = "";
    private static final String CLIENT_SECRET = "";
    private static final String REDIRECT_URI = "";

    @PostMapping
    public ResponseEntity<?> handleGoogleLogin(@RequestBody Map<String, String> requestBody) {
    	String code = requestBody.get("code");
    	
    	if (code == null) {
            return ResponseEntity.badRequest().body("缺少認證碼");
        }
    	
        try {
            // 使用授權碼交換 Access Token
            String tokenEndpoint = "https://oauth2.googleapis.com/token";
            RestTemplate restTemplate = new RestTemplate();
            MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
            params.add("code", code);
            params.add("client_id", CLIENT_ID);
            params.add("client_secret", CLIENT_SECRET);
            params.add("redirect_uri", REDIRECT_URI);
            params.add("grant_type", "authorization_code");

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
            HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);

            ResponseEntity<Map> response = restTemplate.postForEntity(tokenEndpoint, request, Map.class);
            Map<String, Object> responseBody = response.getBody();

            if (responseBody != null && responseBody.containsKey("access_token")) {
                String accessToken = (String) responseBody.get("access_token");

                // 使用 Access Token 獲取用戶資訊
                String userInfoEndpoint = "https://www.googleapis.com/oauth2/v1/userinfo?alt=json";
                HttpHeaders userInfoHeaders = new HttpHeaders();
                userInfoHeaders.setBearerAuth(accessToken);

                HttpEntity<String> userInfoRequest = new HttpEntity<>(userInfoHeaders);
                ResponseEntity<Map> userInfoResponse = restTemplate.exchange(
                        userInfoEndpoint, HttpMethod.GET, userInfoRequest, Map.class);
                Map<String, String> userInfo = userInfoResponse.getBody();
                
                System.out.println("Google userInfo: " + userInfo);
                
                return ResponseEntity.ok(userInfo);
            } else {
                return ResponseEntity.badRequest().body("Failed to retrieve access token");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Google 登入失敗: " + e.getMessage());
        }
    }
}

