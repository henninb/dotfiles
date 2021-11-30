#!/usr/bin/env groovy

@GrabConfig(systemClassLoader=true)
@Grab('com.fasterxml.jackson.core:jackson-core:2.13.0')
@Grab('org.postgresql:postgresql:42.3.1')
@Grab('com.drewnoakes:metadata-extractor:2.16.0')

//EXIF (Exchangeable Image File Format) is the standard to specify the image and sound formats

import com.fasterxml.jackson.databind.ObjectMapper
import groovy.transform.ToString
import groovy.sql.Sql
import java.sql.Driver
import java.sql.DriverManager
import java.sql.PreparedStatement
import java.security.MessageDigest
import com.drew.metadata.Metadata
import com.drew.imaging.jpeg.JpegMetadataReader
import com.drew.imaging.jpeg.ImageMetadataReader
import com.drew.metadata.Directory

@ToString
class JpegFile {
  String jpegId
  String notes
}

// void generateMD5(File file) {
//    file.withInputStream {
//       new DigestInputStream(it, MessageDigest.getInstance('MD5')).withStream {
//          it.eachByte {}
//          it.messageDigest.digest().encodeHex() as String
//       }
//    }
// }

void process() {
  // def digest = java.security.MessageDigest.getInstance("MD5")
  println('start')
  println('not connected')
  // def connection = DriverManager.getConnection('jdbc:postgresql://raspi:5432/finance_db', 'henninb', 'monday1')
  def sql = Sql.newInstance('jdbc:postgresql://raspi:5432/finance_db', 'henninb', 'monday1', 'org.postgresql.Driver')
  println('connected')
  // PreparedStatement preparedStatement = connection.prepareStatement(query)

  new File("input.txt").eachLine { line ->
    List<String> list = line.split('  ')
    println("${list[0]},${list[1]}")
    // Metadata metadata = JpegMetadataReader.readMetadata(new File(list[1]))
    Metadata metadata = ImageMetadataReader.readMetadata(list[1])
    // Directory exifDirectory = metadata.getDirectory(Class.forName("com.drew.metadata.exif.ExifDirectory"))
    def exifDirectory = metadata.getDirectories()
    // Date value = exifDirectory.getDate(36867)
    println(value)
  }

  // sql.execute([accountNameOwner: 'tcf-savings_brian'], 'select * from t_account where account_name_owner = :accountNameOwner', { _, result ->
  //   result.each { row ->
  //       println "account_id: ${row.account_id}, accountNameOwner: ${row.account_name_owner}"
  //   }
  // })

  // sql.execute([accountNameOwner: 'tcf-savings_brian'], 'select * from t_transaction where account_name_owner = :accountNameOwner', { _, result ->
  //   result.each { row ->
  //       println row
  //   }
  // })

  // sql.execute([accountNameOwner: 'tcf-savings_brian'], 'update t_transaction set active_status=false where account_name_owner = :accountNameOwner', { _, result ->
  //   result.each { row ->
  //       println row
  //   }
  // })

  // sql.execute([accountNameOwner: 'tcf-savings_brian'], 'update t_account set active_status=false where account_name_owner = :accountNameOwner', { _, result ->
  //   result.each { row ->
  //       println row
  //   }
  // })
 println('done')
}

process()
