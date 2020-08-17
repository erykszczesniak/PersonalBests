package com.app.controllers; 

import java.util.*;

import com.app.exception.ResourceNotFoundException;
import com.app.service.RunnerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import com.app.models.Runner;

@RestController
@RequestMapping("/runners")
public class RunnerController {

	RunnerService runnerService;



    @Autowired
	public RunnerController(RunnerService runnerService) {
		this.runnerService = runnerService;
	}

	@RequestMapping(method = RequestMethod.OPTIONS)
	ResponseEntity<?> options() {
	  return ResponseEntity.ok().allow(
		       HttpMethod.GET,
		       HttpMethod.POST,
		       HttpMethod.HEAD,
		       HttpMethod.OPTIONS,
		       HttpMethod.PUT,
		       HttpMethod.DELETE).
		       build(); 
	}

	@GetMapping
	public ResponseEntity<List<Runner>> getAllRunners() {
		return ResponseEntity.ok(this.runnerService.getAllRunners());
	}

	@PostMapping
	public ResponseEntity<Runner> createRunner(@RequestBody Runner runner) {
		Runner save = this.runnerService.createRunner(runner);
		return ResponseEntity.ok(save);
	}

	@GetMapping(value = "/{id}")
	public ResponseEntity<Runner> getRunnerById(@PathVariable("id") int id) {
		Optional<Runner> object = this.runnerService.getRunnerById(id);
		if (object.isPresent()) {
			return ResponseEntity.ok(object.get());
		}
		return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
	}

	@DeleteMapping(value="/{id}")
	Map<String, Boolean> deleteContact(@PathVariable Integer id) throws ResourceNotFoundException {

		Runner runner = runnerService.getRunnerById(id)
				.orElseThrow(() -> new ResourceNotFoundException("Contact with this id not found" + id));

		runnerService.deleteRunner(runner);

		Map<String, Boolean> response = new HashMap<>();
		response.put("deleted", Boolean.TRUE);
		return response;

	}

	@PutMapping(value="/{id}")
	public ResponseEntity<Runner> update(@PathVariable int id, @RequestBody Runner runnerDetails){
		Optional<Runner> object = this.runnerService.getRunnerById(id);
		if(object.isPresent()) {
			runnerDetails.setId(id);
			this.runnerService.update(runnerDetails);
			return ResponseEntity.noContent().build();
		}
		return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
	}
}
