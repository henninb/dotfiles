@Grab('com.fasterxml.jackson.core:jackson-core:2.12.3')

import com.fasterxml.jackson.databind.ObjectMapper
import groovy.transform.ToString
import java.nio.file.Paths

@ToString
class StaticNode {
  String mac
  String ip
  String hostname
}

void process() {
List<StaticNode> staticNodes = []
ObjectMapper mapper = new ObjectMapper()

new File("input.txt").eachLine { line ->
  List<String> elements = line.split('\t')
  StaticNode staticNode = new StaticNode()
  staticNode.mac = elements[0]
  staticNode.ip = elements[1]
  staticNode.hostname = elements[2]
  staticNodes.add(staticNode)
  elements.each { String element ->
    println(element)
  }
}

mapper.writeValue(Paths.get("output.json").toFile(), staticNodes)
}

process()
