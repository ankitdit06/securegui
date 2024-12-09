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
          <v-toolbar-title>Components</v-toolbar-title>
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
      <template v-slot:item.team.name="{ value }">
     <v-chip  color="indigo"
      prepend-icon="mdi-account-circle">
       <a href="#">{{ value }}</a>
     </v-chip>
   </template>
   <template v-slot:item.platform="{ value }">
 <img :src="getLogo(value)" :alt="value" height="30px" />
</template>
   <template v-slot:[`item.last_updated`]="{ item }">
        <span>{{ formatDate(item.last_updated) }}</span>
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
import { formatDistanceToNow, parseISO } from 'date-fns';  // Ensure both are imported

export default {
  data() {
    return {
      headers: [
        { title: 'Name', value: 'name' },
        { title: 'Team', value: 'team.name' },
        { title: 'Version', value: 'version' },
        { title: 'URL', value: 'url' },
        { title: 'platform', value: 'platform' },
        { title: 'API Reference', value: 'api_ref' },
        { title: 'Document Reference', value: 'document_ref' },
        { title: 'Last Update', value: 'last_updated' },
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
  computed: {
    // Computed property to return the formatted items with human-readable dates
    formattedItems() {
      return this.items.map((item) => {
        return {
          ...item,
          date: this.formatDate(item.last_updated),
        };
      });
    },
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
  // Method to return the logo based on the technology name
    getLogo(tech) {
      const logos = {
        java: 'https://upload.wikimedia.org/wikipedia/de/e/e1/Java-Logo.svg',
        python: 'https://upload.wikimedia.org/wikipedia/commons/c/c3/Python-logo-notext.svg',
        javascript: 'https://upload.wikimedia.org/wikipedia/commons/6/6a/JavaScript-logo.png',
        c: 'https://upload.wikimedia.org/wikipedia/commons/1/18/C_Programming_Language_logo.svg',
      };

      // Return the appropriate logo URL or a placeholder if not found
      return logos[tech] || 'https://via.placeholder.com/150';
    },
  openItem (item) {
    this.$router.push("component/"+item); // Navigate to the specified route

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
  const response = await fetch(`http://217.160.221.142:9090/Component/List?${params}`);
  const data = await response.json();

  this.items = data; // Assuming response is a JSON array
  this.totalItems = data.length; // Use the length of the array if needed
} catch (error) {
  console.error('Failed to fetch data:', error);
} finally {
  this.loading = false;
}
},
// Method to format the date as "5 days ago", "2 minutes ago", etc.
    formatDate(date) {
      const parsedDate = parseISO(date); // Parse the UTC date string
      return formatDistanceToNow(parsedDate, { addSuffix: true }); // Convert to human-readable format
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
