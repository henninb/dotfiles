@Grab('org.xerial:sqlite-jdbc:3.34.0')
@Grab('com.fasterxml.jackson.core:jackson-core:2.12.3')

import com.fasterxml.jackson.databind.ObjectMapper
import groovy.transform.ToString
import java.nio.file.Paths

@ToString
class SongEntry {
  String artist
  String track
  String album
  Integer year
}

void readthem() {
  List<SongEntry> songEntries = []
  ObjectMapper mapper = new ObjectMapper()

  new File("input.txt").eachLine { line ->
    SongEntry songEntry = new SongEntry()
    List<String> list = line.split(' - ')
    songEntry.artist = list[0]
    songEntry.track = list[1].replace('.mp3', '')
    // println list[1].replace('.mp3', '')
    songEntries.add(songEntry)
  }
  mapper.writeValue(Paths.get("output.json").toFile(), songEntries)
}

readthem()

void process() {
  String json = ''' { "artist": "Tom Petty", "track": "It's Good To Be King", "album": "It's Good To Be King", "year": 1994 } '''
  File jsonListFile = new File("list.json")
  File jsonFile = new File("tom_petty_its_good_to_be_king.json")

  ObjectMapper mapper = new ObjectMapper()
  SongEntry songEntry = mapper.readValue(json, SongEntry)
  println songEntry
  SongEntry songEntry1 = mapper.readValue(jsonFile, SongEntry)
  println songEntry1
  List<SongEntry> list = mapper.readValue(jsonListFile, SongEntry[])
  print list
}

process()
