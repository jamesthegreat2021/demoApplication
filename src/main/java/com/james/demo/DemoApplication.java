package com.james.demo;

import com.james.demo.student.Student;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.List;


@SpringBootApplication
@RestController


public class DemoApplication {
    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }

    @GetMapping

    public List <Student> hello () {
       return List.of(new Student(
               1L, "christina","christina@gmail.com", LocalDate.of(2000,3,11),20
       ),
               new Student(2L, "james","james@gmail.com", LocalDate.of(2000,3,11),20),
               new Student(3L, "Robin","Robin@gmail.com", LocalDate.of(2000,3,11),20));
    }
}




