package insurance.main.config;

import java.util.Properties;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;
import org.springframework.jndi.JndiObjectFactoryBean;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.web.filter.HiddenHttpMethodFilter;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.ses.SesClient;

//註冊區

@Configuration
@ComponentScan(basePackages = {"insurance.main", "insurance.premiums"}) // 掃描指定的 Spring Bean
@EnableMongoRepositories(basePackages = "insurance.premiums") // 啟用 MongoDB Repository
@EnableAspectJAutoProxy // 啟用 AOP (面向切面編程)
public class RootAppConfig implements WebMvcConfigurer {
	@Override
	public void addCorsMappings(CorsRegistry registry) {
		registry.addMapping("/**") // 配置所有後端 API 路徑
				.allowedOrigins("http://localhost:8081","http://localhost:5173") // 允許的前端來源
				.allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS") // 允許的方法
				.allowedHeaders("*") // 允許的標頭
				.allowCredentials(true); // 是否允許攜帶憑據
	}
	
	private Properties addProperties() {
		Properties props = new Properties();
		props.put("hibernate.show_sql", "true"); // 顯示 SQL 查詢語句
		props.put("hibernate.format_sql", "true"); // 格式化 SQL 輸出
		props.put("hibernate.current_session_context_class", "thread"); // 使用 Thread 為 Session 管理策略
		props.put("hibernate.allow_update_outside_transaction", "true"); // 允許在 Transaction 之外執行更新
		return props;
	}
	
	@Bean
	public InternalResourceViewResolver clientJspViewResolver() {
	    InternalResourceViewResolver resolver = new InternalResourceViewResolver();
	    resolver.setPrefix("/ClientJSP/"); // JSP 檔案所在目錄
	    resolver.setSuffix(".jsp"); // 檔案副檔名
	    resolver.setOrder(1); // 優先級高
	    return resolver;
	}

    @Bean
    public InternalResourceViewResolver htmlViewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/ClientHTML/"); // HTML 檔案所在目錄
        resolver.setSuffix(".html");
        resolver.setOrder(2); 
        return resolver;
    }
    
    // 允許 CORS (跨來源資源共享) 設定
    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**") // 允許所有 API 路徑
                        .allowedOrigins("http://localhost:5173") // 允許的前端 URL
                        .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS") // 允許的 HTTP 方法
                        .allowedHeaders("*") // 允許的請求標頭
                        .allowCredentials(true); // 允許發送憑據 (Cookies)
            }
        };
    }
   
    // 讀取 AWS 相關設定
    @Value("${aws.accessKeyId}")
    private String accessKey;

    @Value("${aws.secretAccessKey}")
    private String secretKey;

    @Value("${aws.region}")
    private String region;
    
    // 設定 AWS SES 服務 (用於發送電子郵件)
    @Bean
    public SesClient sesClient() {
        AwsBasicCredentials awsCreds = AwsBasicCredentials.create(accessKey, secretKey);

        return SesClient.builder()
                .region(Region.of(region))
                .credentialsProvider(StaticCredentialsProvider.create(awsCreds))
                .build();
    }
    
    // 設定靜態資源處理 (處理圖片存取)
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/picture/**")  // 映射 "/picture" 路徑
                .addResourceLocations("classpath:/static/picture/");  // 指向對應的資料夾
    }
   

}
