package com.app;

import com.app.models.Runner;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import static org.junit.Assert.assertNotNull;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit4.SpringRunner;


@RunWith(SpringRunner.class)
@SpringBootTest(classes = DemoApplication.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class DemoApplicationTests {



	@Autowired
	private TestRestTemplate restTemplate;


	private String getRootUrl() {
		return "http://localhost:8080/runners";
	}

	@Test
	void contextLoads() {

	}

	@Test
	public void testCreateRunner() {
		Runner runner = new Runner();
        runner.setId(1);
        runner.setName("Kenenisa Beke");
        runner.setPb(12.37);

        ResponseEntity<Runner> postResponse = restTemplate.postForEntity(getRootUrl(),runner,Runner.class);
        assertNotNull(postResponse);
        assertNotNull(postResponse.getBody());
	}


	@Test
	public void testGetRunnerById() {
		Runner runner = restTemplate.getForObject(getRootUrl() + "/3" , Runner.class);
		System.out.println(runner);
		assertNotNull(runner);
	}

	@Test
	public void testGetAllEmployees() {
		HttpHeaders headers = new HttpHeaders();
		HttpEntity<String> entity = new HttpEntity<>(null,headers);

		ResponseEntity<String> response = restTemplate.exchange(getRootUrl(), HttpMethod.GET, entity, String.class);

		System.out.println(response);
		assertNotNull(response.getBody());


	}

}
