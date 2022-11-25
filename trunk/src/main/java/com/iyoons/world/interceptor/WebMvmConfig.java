package com.iyoons.world.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.iyoons.world.service.UserService;

@Configuration
public class WebMvmConfig implements WebMvcConfigurer{
	

//	@Autowired 
//	private CommonInterceptor commonInterceptor;
	
	

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		registry.addInterceptor(getInterceptor())
					.addPathPatterns("/**") // 적용할 url (모든 url)
					.excludePathPatterns("/","/html/**","/css/**","/images/**","/js/**","/login/**","/main","/board/getListForMain","/board/getAllBoardListForReadCountForMonth"); //제외할 url /* "/css/**","/images/**","/js/**", */ 정적리소스에서도 세션체크하면 뱉어버리는 현상이 일어날 수 있으니( login페이지도 css,js가 있기때문 ) 넣을지않넣어도 될지 확인필요   
		
	}
	
	@Bean
	public CommonInterceptor getInterceptor() {
		return new CommonInterceptor();
	}

}
