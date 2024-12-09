<template>
  <v-container>
    <v-data-table
      :headers="headers"
      :items="items"
      :server-items-length="totalItems"
      :items-per-page="itemsPerPage"
      :options.sync="options"
      :loading="loading"
      item-value="id"
    >
      <template v-slot:top>
        <v-toolbar flat>
          <v-toolbar-title>Services</v-toolbar-title>
          <v-spacer></v-spacer>
          <v-text-field
            v-model="search"
            label="Search"
            clearable
          ></v-text-field>
        </v-toolbar>
      </template>
      <template v-slot:item.name="{ value }">
     <v-chip  class="ma-2"
      color="primary"
       label>
       {{ value }}
     </v-chip>
   </template>
      <template v-slot:item.Team.name="{ value }">
     <v-chip  color="indigo"
      prepend-icon="mdi-account-circle">
       <a href="#">{{ value }}</a>
     </v-chip>
   </template>
      <template v-slot:item.publicfacing="{ value }">
     <v-chip :color="getColor(value)">
       {{ value }}
     </v-chip>
   </template>
   <template v-slot:item.id="{ value }">
   <v-icon
     class="me-2"
     size="small"
     @click="openItem(value)"
   >
     mdi-eye
   </v-icon>
      <v-icon
        class="me-2"
        size="small"
        @click="editItem(value)"
      >
        mdi-pencil
      </v-icon>
      <v-icon
        class="me-2"
        size="small"
        @click="editItem(value)"
      >
        mdi-delete
      </v-icon>

    </template>
    </v-data-table>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      headers: [
        { title: 'Name', value: 'name' },
        { title: 'Team', value: 'Team.name' },
        { title: 'Public Facing', value: 'publicfacing' },
        { title: 'Release', value: 'release' },
        { title: 'Action', value: 'id' },
      ],
      items: [],
      totalItems: 0,
      itemsPerPage: 10,
      options: {
        page: 1,
        itemsPerPage: 10,
        sortBy: [],
        sortDesc: [],
      },
      search: '',
      loading: false,
    };
  },
  watch: {
    options: {
      handler() {
        this.fetchData();
      },
      deep: true,
    },
    search: {
      handler() {
        this.fetchData();
      },
      immediate: true,
    },
  },
  methods: {
  openItem (item) {
    this.$router.push("service/"+item); // Navigate to the specified route

      },
  editItem (item) {
        alert(item)
      },
  async fetchData() {
this.loading = true;
const { page, itemsPerPage, sortBy, sortDesc } = this.options;
const params = new URLSearchParams({
  page,
  itemsPerPage,
  search: this.search,
  sortBy: sortBy[0] || '',
  sortDesc: sortDesc[0] ? 'desc' : 'asc',
});

try {
  const response = await fetch(`http://localhost:9090/Service/List?${params}`);
  const data = await response.json();

  this.items = data; // Assuming response is a JSON array
  this.totalItems = data.length; // Use the length of the array if needed
} catch (error) {
  console.error('Failed to fetch data:', error);
} finally {
  this.loading = false;
}
},
getColor (publicfacing) {
        if (publicfacing == "True") return 'red'

        else return 'green'
      },
  },
  mounted() {
    this.fetchData();
  },
};
</script>
