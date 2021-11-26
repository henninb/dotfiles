@Grab('com.fasterxml.jackson.core:jackson-core:2.12.3')
// @Grab('StaticNode')

import com.fasterxml.jackson.databind.ObjectMapper
// import groovy.transform.ToString


// @ToString
// class StaticNode
//   String mac
//   String ip
//   String hostname
// }
// List<StaticNode> staticNodes = []

ObjectMapper mapper = new ObjectMapper()

new File("input.txt").eachLine { line ->
    // println line
  List<String> elements = line.split('\t')
  elements.each { String element ->
    println(element)
  }
}

// File file = new File("intput.txt")
// def x = file.eachLine { line ->
//   // staticNode.mac = list[0]
//   // staticNode.ip = list[1]
//   // staticNode.hostname = list[2]
//   // staticNodes.add(staticNode)
//   // String jsonString = mapper.writeValueAsString(staticNode)
// }

// mapper.writeValue(Paths.get("output.json").toFile(), staticNodes);

// println staticNodes
