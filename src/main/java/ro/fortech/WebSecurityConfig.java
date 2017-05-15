package ro.fortech;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 * Created by Tamas on 5/11/2017.
 */
@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    private UserDetailsService userDetailsService;

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.   userDetailsService(userDetailsService).
                passwordEncoder(bCryptPasswordEncoder);
//        auth.inMemoryAuthentication()
//                .withUser("admin").password("admin").roles("ADMIN")
//        .and()
//                .withUser("user").password("user").roles("USER");
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                .antMatchers("/", "/file","/search","/signup","/login","/car/numberOfCars", "/car/view").permitAll()

//                 .antMatchers("/car/add","/car/list","/car/edit", "/car/delete").hasRole("USER")
                .anyRequest().authenticated()

                .and()
                .csrf().disable()
                .formLogin()
                .loginPage("/login")
                .permitAll()

                .and()
                .logout().logoutSuccessUrl("/").permitAll()
                .and().exceptionHandling()
                .accessDeniedPage("/access-denied");
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web
                .ignoring()
                .antMatchers("/resources/**", "/static/**", "/css/**", "/js/**", "/images/**", "/ext-img/**");
    }
}
