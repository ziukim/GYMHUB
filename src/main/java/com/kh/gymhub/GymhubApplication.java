package com.kh.gymhub;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class GymhubApplication {

    public static void main(String[] args) {
        SpringApplication.run(GymhubApplication.class, args);
    }

}
