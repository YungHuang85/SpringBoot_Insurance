package insurance.main;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.http.client.HttpClientAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;



@SpringBootApplication(exclude = {HttpClientAutoConfiguration.class})
public class DemoSpringWebProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(DemoSpringWebProjectApplication.class, args);
	}

}
