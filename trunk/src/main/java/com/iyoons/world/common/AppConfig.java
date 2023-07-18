/*package com.iyoons.world.common;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
@Configuration
//@PropertySource("classpath:/config/server-${spring.profiles.active}.properties")
@PropertySource("classpath:application-${spring.profiles.active}.properties")
//@PropertySource("resources/json-20070829.jar ")
public class AppConfig {
    @Bean
    public static PropertySourcesPlaceholderConfigurer propertyConfigInDev() {
        return new PropertySourcesPlaceholderConfigurer();
    }
}
*/