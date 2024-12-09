<template>
  <v-container>
    <div ref="treeContainer" class="tree-container"></div>
  </v-container>
</template>

<script>
import * as d3 from "d3";

export default {
  data() {
    return {
      treeData: {
        name: "Service A",
        children: [
          {
            name: "Component 1",
            children: [
              { name: "Security Audit 1" },
              { name: "Security Audit 2" },
            ],
          },
          {
            name: "Component 2",
            children: [
              { name: "Security Audit 1" },
              { name: "Security Audit 3" },
            ],
          },
          {
            name: "Component 3",
            children: [],
          },
        ],
      },
    };
  },
  mounted() {
    this.createTree(this.treeData);
  },
  methods: {
    createTree(data) {
      const width = 800;
      const height = 800;

      // Create the tree layout
      const treemap = d3.tree().size([height, width - 160]);

      // Create the root node
      const root = d3.hierarchy(data);
      treemap(root);

      const svg = d3
        .select(this.$refs.treeContainer)
        .append("svg")
        .attr("width", width)
        .attr("height", height)
        .append("g")
        .attr("transform", "translate(80,0)");

      // Links between nodes
      svg
        .selectAll(".link")
        .data(root.links())
        .enter()
        .append("path")
        .attr("class", "link")
        .attr("d", (d) => `
          M${d.source.x},${d.source.y}
          C${d.source.x},${(d.source.y + d.target.y) / 2}
          ${d.target.x},${(d.source.y + d.target.y) / 2}
          ${d.target.x},${d.target.y}
        `)
        .attr("fill", "none")
        .attr("stroke", "#ccc");

      // Nodes
      const nodes = svg
        .selectAll(".node")
        .data(root.descendants())
        .enter()
        .append("g")
        .attr("class", "node")
        .attr("transform", (d) => `translate(${d.x},${d.y})`);

      // Circles for nodes
      nodes
        .append("circle")
        .attr("r", 10)
        .attr("fill", "#42A5F5");

      // Labels for nodes
      nodes
        .append("text")
        .attr("dy", 3)
        .attr("y", (d) => (d.children ? -15 : 15))
        .style("text-anchor", "middle")
        .text((d) => d.data.name);
    },
  },
};
</script>

<style scoped>
.tree-container {
  margin-top: 0px;
}

.link {
  stroke-width: 2px;
}

.node text {
  font-size: 12px;
  fill: #333;
}

.node circle {
  stroke-width: 2px;
  stroke: #333;
}
</style>
