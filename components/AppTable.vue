<!-- src/components/DataTable.vue -->
<template>
  <v-card>
    <v-card-title>
      <span class="headline">{{ cardTitle }}</span>
    </v-card-title>
    <v-card-text>
      <!-- Loading state -->
      <v-progress-circular v-if="loading" indeterminate color="primary" />

      <!-- Data Table -->
      <v-data-table
        v-else
        :items="items"
        :headers="headers"
        :items-per-page="itemsPerPage"
        :page.sync="page"
        :search="search"
        item-key="id"
      >
        <template v-slot:top>
          <v-text-field
            v-bind="search"
            label="Search"
            class="mx-4"
            append-icon="mdi-magnify"
            single-line
            hide-details
          />
        </template>

        <!-- Table header styling -->
        <template v-slot:column.header="{ column }">
          <v-th class="header-cell">
            <span>{{ column.text }}</span>
            <v-icon v-if="column.sortable" class="ml-2">mdi-sort</v-icon>
          </v-th>
        </template>

        <!-- Dynamic column rendering -->
        <template v-slot:item="{ item }">
          <tr>
            <!-- Loop through each header dynamically -->



            <td v-for="header in headers" :key="header.value">
              {{ item[header.value] }}
            </td>
          </tr>
        </template>
      </v-data-table>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  props: {
    items: Array,
    headers: Array,
    loading: Boolean,
    itemsPerPage: {
      type: Number,
      default: 5,
    },
    page: {
      type: Number,
      default: 1,
    },
    search: {
      type: String,
      default: '',
    },
    cardTitle: {
      type: String,
      default: 'Data Table',
    },
  },
};
</script>
<style>
.header-cell{
font-weight:'bold';
font-size:'20px';
}
</style>
