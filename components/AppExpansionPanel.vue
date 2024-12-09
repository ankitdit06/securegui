<template>
  <v-container>
    <!-- v-expansion-panels to display fetched data -->
    <v-expansion-panels v-if="items.length > 0" multiple>
      <!-- Loop through the items and create a v-expansion-panel for each -->
      <v-expansion-panel v-for="(item, index) in items" :key="index">
        <v-expansion-panel-title>
          <b>{{ item.name }}</b> v{{ item.version }}
        </v-expansion-panel-title>
        <v-expansion-panel-text>
        <v-table class="text-caption" density="compact">
              <tbody>
                <tr align="right">
                  <th>URL:</th>

                  <td>{{ item.url }}</td>

                  <th>Document Reference:</th>

                  <td>{{ item.document_ref }}</td>
                </tr>
                <tr align="right">
                  <th>Platform:</th>

                  <td>{{ item.platform}}</td>

                  <th>Team:</th>

                  <td>{{ item.team.name}}</td>
                </tr>
                <tr align="right">
                  <th>API Reference:</th>

                  <td>{{ item.api_ref}}</td>

                  <th>Last Updated:</th>

                  <td>{{ item.last_updated}}</td>
                </tr>


              </tbody>
            </v-table>
        </v-expansion-panel-text>

      </v-expansion-panel>
    </v-expansion-panels>

    <!-- Loading spinner while fetching data -->
    <v-progress-circular
      v-else
      indeterminate
      color="primary"
      size="64"
      width="6"
    ></v-progress-circular>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      items: [], // To store fetched data
    };
  },
  methods: {
    // Method to fetch data from API
    async fetchData() {
    var sid= useRoute()
    var serId=sid.params.id

      try {
        const response = await fetch('http://localhost:9090/Component/Service/'+serId); // Replace with your API URL
        const data = await response.json();
        this.items = data; // Assign fetched data to items array
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    },
  },
  mounted() {
    this.fetchData(); // Fetch data when the component is mounted
  },
};
</script>

<style scoped>
/* Custom styles for the expansion panels (optional) */
.label-text {
  font-size: 14px;
  display: inline;
  font-weight: bold;
  color: #333;
  margin-bottom: 4px;
  padding-left: 4px;
}

.label-value {
display: inline;
  font-size: 14px;
  font-weight: bold;
  color: #333;
  margin-bottom: 4px;
  padding-left: 4px;
}
</style>
