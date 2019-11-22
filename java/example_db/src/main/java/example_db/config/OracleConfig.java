package example_db.config;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.PlatformTransactionManager;

import java.util.Properties;

@Configuration
//@EnableTransactionManagement
// @EnableJpaRepositories(
//         basePackages = "example_db.repositories",
//         entityManagerFactoryRef = "OracleConfigEntityManager",
//         transactionManagerRef = "OracleConfigTransactionManager"
// )
public class OracleConfig {
    @Autowired
    private Environment env;

    @Bean
    public LocalContainerEntityManagerFactoryBean OracleConfigEntityManager() {
        LocalContainerEntityManagerFactoryBean em = new LocalContainerEntityManagerFactoryBean();

        Properties jpaProperties = new Properties();
        jpaProperties.put("hibernate.jdbc.batch_size", 1000);
        jpaProperties.put("hibernate.order_inserts", true);
        jpaProperties.put("hibernate.order_updates", true);
        em.setJpaProperties(jpaProperties);
        em.setDataSource(GetDBDataSource());
        em.setPackagesToScan(new String[] {"example_db.entities", "example_db.repositories" });
        HibernateJpaVendorAdapter vendorAdapter = new HibernateJpaVendorAdapter();
        em.setJpaVendorAdapter(vendorAdapter);
        return em;
    }

    @Primary
    @Bean
    public DataSource GetDBDataSource() {

        java.util.Properties props = new java.util.Properties();
        props.setProperty("v$session.program","application.name");

        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setUrl(env.getProperty("spring.datasource.url"));
        dataSource.setUsername(env.getProperty("spring.datasource.username"));
        dataSource.setPassword(env.getProperty("spring.datasource.password"));
        dataSource.setConnectionProperties(props);

        DataSource dataSourcePool = new DataSource();
        dataSourcePool.setDataSource(dataSource);
        dataSourcePool.setInitialSize(5);
        dataSourcePool.setMaxIdle(20);
        return dataSourcePool;
    }

    @Bean
    public PlatformTransactionManager OracleConfigTransactionManager() {
        JpaTransactionManager transactionManager  = new JpaTransactionManager();
        transactionManager.setEntityManagerFactory(OracleConfigEntityManager().getObject());
        return transactionManager;
    }
}

