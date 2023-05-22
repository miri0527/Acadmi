package com.acadmi.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
//**-context.xml
public class WebConfig implements WebMvcConfigurer {
	
	@Value("${app.load.base}")
	private String basePath;
	
	@Value("${app.url.path}")
	private String urlPath;
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		//<resources mapping="/resources/**" location="/resources/" />
		//<resources mapping="/file/**" location="D:/production/upload>
		registry.addResourceHandler(urlPath)
				.addResourceLocations(basePath);
		
	}

}
