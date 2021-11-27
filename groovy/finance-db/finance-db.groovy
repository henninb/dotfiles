@GrabConfig(systemClassLoader=true)
@Grab('com.fasterxml.jackson.core:jackson-core:2.13.0')
@Grab('org.postgresql:postgresql:42.3.1')

import com.fasterxml.jackson.databind.ObjectMapper
import groovy.transform.ToString
import groovy.sql.Sql
import java.sql.Driver
// import org.postgresql.jdbc.PgConnection
import java.sql.DriverManager
import java.sql.PreparedStatement

@ToString
class Transaction {
  String transactionId
  String notes
}

void process() {
  String query = ''' SELECT * FROM t_account where account_name_owner='chase_brian' '''
  println('start')
  println('not connected')
  // def connection = DriverManager.getConnection('jdbc:postgresql://raspi:5432/finance_db', 'henninb', 'monday1')
  def sql = Sql.newInstance('jdbc:postgresql://raspi:5432/finance_db', 'henninb', 'monday1', 'org.postgresql.Driver')
  println('connected')
  // PreparedStatement preparedStatement = connection.prepareStatement(query)

  sql.execute([accountNameOwner: 'chase_brian'], 'select * from t_account where account_name_owner = :accountNameOwner', { _, result ->
    result.each { row ->
        println "account_id: ${row.account_id}, accountNameOwner: ${row.account_name_owner}"
    }
})

  // if (connection != null && !connection.isClosed()) {
  //     connection.close()
  //     println('not connected')
  // }
 println('done')
}

process()
