package example_db.configurations;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

/*
@Configuration
public class OracleConfigNew {

    private Environment env;

    @Autowired
    public OracleConfigNew(Environment env) {
        this.env = env;
    }

    @Primary
    @Bean
    public DataSource getDBDataSource() {
        java.util.Properties props = new java.util.Properties();
        props.setProperty("v$session.program",env.getProperty("spring.application.name"));

        DriverManagerDataSource dataSource
                = new DriverManagerDataSource();
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

}
*/
