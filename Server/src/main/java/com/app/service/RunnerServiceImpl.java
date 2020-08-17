package com.app.service;

import com.app.models.Runner;
import com.app.repositories.RunnerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RunnerServiceImpl implements RunnerService {


    RunnerRepo runnerRepo;

    @Autowired
    public RunnerServiceImpl(RunnerRepo runnerRepo) {
        this.runnerRepo = runnerRepo;
    }

    @Override
    public List<Runner> getAllRunners() {
        return runnerRepo.findAll();
    }

    @Override
    public Optional<Runner> getRunnerById(Integer id) {
        return runnerRepo.findById(id);
    }

    @Override
    public Runner createRunner(Runner runner) {
        return runnerRepo.save(runner);
    }

    @Override
    public Runner update(Runner runnerDetails) {
        return runnerRepo.save(runnerDetails);
    }

    @Override
    public void deleteRunner(Runner runner) {
     runnerRepo.delete(runner);
    }
}
