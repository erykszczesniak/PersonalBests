package com.app.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.app.models.Runner;

@Repository
public interface RunnerRepo extends JpaRepository<Runner, Integer> {

}
