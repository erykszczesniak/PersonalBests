package com.app.service;

import com.app.models.Runner;

import java.util.List;
import java.util.Optional;


public interface RunnerService {


    List<Runner> getAllRunners();
    Optional<Runner> getRunnerById(Integer id);
    Runner createRunner(Runner runner);
    Runner update(Runner runnerDetails);
    void deleteRunner(Runner runner);
}
