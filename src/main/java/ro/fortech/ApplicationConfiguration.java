package ro.fortech;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.jdbc.JdbcDaoImpl;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import ro.fortech.dao.CarDAO;
import ro.fortech.dao.jdbcTemplate.JdbcTemplateCarDAO;

import javax.sql.DataSource;

/**
 * Created by Tamas on 5/9/2017.
 */
@Configuration
public class ApplicationConfiguration {

    @Value("${db.host}")
    private String dbHost;

    @Value("${db.password}")
    private String dbPassword;

    @Value("${db.user}")
    private String dbUser;

    @Value("${db.name}")
    private String dbName;

    @Value("${db.driver}")
    private String dbDriver;

    @Value("${hibernate.dialect}")
    private String hibernateDialect;

    @Value("${hibernate.show_sql}")
    private String hibernateShowSql;

    @Value("${hibernate.hbm2ddl.auto}")
    private String hibernateHbm2ddlAuto;

    @Value("${entitymanager.packagesToScan}")
    private String entityManagerPackagesToScan;

    @Bean
    public DataSource dataSource() {
        String url = new StringBuilder()
                .append("jdbc:")
                .append("postgresql")
                .append("://")
                .append(dbHost)
                .append(":")
                .append("5432")
                .append("/")
                .append(dbName).toString();

        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName(dbDriver);
        dataSource.setUrl(url);
        dataSource.setUsername(dbUser);
        dataSource.setPassword(dbPassword);
        return dataSource;
    }

    @Bean
    public CarDAO carDAO() {

        return new JdbcTemplateCarDAO(dataSource());
    }

    private String query = "select u.email, r.role_name from users u join user_role_relation ur on u.id = ur.user_id join roles r on r.id = ur.role_id where email = ?";

    @Bean
    public UserDetailsService userDetailsService() {
        JdbcDaoImpl jdbcImpl = new JdbcDaoImpl();
        jdbcImpl.setDataSource(dataSource());
        jdbcImpl.setUsersByUsernameQuery("select email, password, enabled from users where email=?");
        jdbcImpl.setAuthoritiesByUsernameQuery(query);
        return jdbcImpl;
    }
//
//    @Bean
//    public LocalSessionFactoryBean sessionFactory() {
//        LocalSessionFactoryBean sessionFactoryBean = new LocalSessionFactoryBean();
//        sessionFactoryBean.setDataSource(dataSource());
//        sessionFactoryBean.setPackagesToScan(entityManagerPackagesToScan);
//        Properties hibernateProperties = new Properties();
//        hibernateProperties.put("hibernate.dialect", hibernateDialect);
//        hibernateProperties.put("hibernate.show_sql", hibernateShowSql);
//        hibernateProperties.put("hibernate.hbm2ddl.auto", hibernateHbm2ddlAuto);
//        sessionFactoryBean.setHibernateProperties(hibernateProperties);
//
//        return sessionFactoryBean;
//    }
    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
