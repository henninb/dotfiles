@Grab('com.fasterxml.jackson.core:jackson-core:2.12.3')
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.annotation.JsonIgnoreProperties

@JsonIgnoreProperties(ignoreUnknown = true)
class SongEntry {
  String artist = "empty"
  String track
  String album
  Integer year
  String fileName
}

json = """
{ artist:"Tom Petty", track:"It's Good To Be King", album: "It's Good To Be King", year:1994, fileName:"tom_petty_its_good_to_be_king.mp3"}
"""

ObjectMapper mapper = new ObjectMapper()
SongEntry songEntry = mapper.readValue(json, SongEntry.class)
print songEntry
