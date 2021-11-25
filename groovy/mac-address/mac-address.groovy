@Grab('com.fasterxml.jackson.core:jackson-core:2.12.3')

import com.fasterxml.jackson.databind.ObjectMapper
// import com.fasterxml.jackson.databind.DeserializationFeature
import groovy.transform.ToString
// import groovy.json.JsonOutput
// import groovy.json.JsonSlurper

@ToString
class StaticNode
  String mac
  String ip
  String hostname
}

ObjectMapper mapper = new ObjectMapper()
List<StaticNode> staticNodes = []

File files = new File("intput.txt")
files.eachLine { line ->
  StaticNode staticNode = new StaticNode()
  List<String> list = line.split('\t')
  staticNode.mac = list[0]
  staticNode.ip = list[1]
  staticNode.hostname = list[2]
  staticNodes.add(staticNode)
  // String jsonString = mapper.writeValueAsString(staticNode)
}

staticNodes
