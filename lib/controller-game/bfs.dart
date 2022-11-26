class Node {
  dynamic value;
  bool? discovered = false;
  List<Node>? links = [];
  int? distance = 0;
  int? weight;

  Node({
    this.value,
    this.discovered,
    this.links,
    this.distance,
    this.weight,
  });

  @override
  String toString() => '''
  
  value:      $value
  discovered: $discovered
  distance:   $distance
  links:      ${links!.length}
  ''';

  bfs(List<Node> graph, Node start) {
    final queue = [start];
    while (queue.isNotEmpty) {
      Node node = queue.removeLast();
      for (Node link in node.links!) {
        if (link.distance == 0) {
          queue.add(link);
          link.distance = node.distance! + 1;
        }
      }
    }
  }

  dfs(List<Node> graph, [cb]) {
    for (final node in graph) {
      if (!node.discovered!) {
        explore(graph, node, cb);
      }
    }
  }

  explore(List<Node> graph, Node node, callback) {
    node.discovered = true;
    callback != null && callback(node);

    for (Node link in node.links!) {
      if (!link.discovered!) {
        explore(graph, link, callback);
      }
    }
  }
}