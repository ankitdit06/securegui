
<template>
  <v-container>
  <!-- Trigger Button to Open Dialog -->
 <v-btn @click="openDialog" color="primary">Add Team</v-btn>
 <!-- Success or Error Message After Form Submission -->
    <v-alert
      v-if="alertVisible"
      :type="alertType"
      dismissible
      @input="alertVisible = false"
    >
      {{ alertMessage }}
    </v-alert>

 <!-- Generic Dialog Component with Form -->
 <AppFormDialog
   v-model:isOpen="dialogOpen"
   title="Team Name"
   :actions="dialogActions"
    @submit="submitData"
 />
    <AppTable
      :items="teams"
      :headers="userHeaders"
      :loading="loading"
      :items-per-page="10"
      :page.sync="page"
      :search="search"
      cardTitle="Teams"
    />
  </v-container>
</template>

<script>
import AppTable from '@/components/AppTable.vue';

export default {
  components: {
    AppTable,
  },
  data() {
    return {
      teams: [],
      userHeaders: [
        { title: 'Team Name', align: 'start', value: 'name' },

      ],
      loading: false,
      page: 1,
      search: '',
      dialogOpen: false,
      alertVisible: false,  // Flag to show/hide the alert
      alertMessage: '',     // Message to display in the alert
      alertType: '',        // Type of the alert ('success', 'error', etc.)
      dialogActions: [
        {
          text: 'Cancel',
          color: 'secondary',
          callback: this.closeDialog,
        },
        {
          text: 'Submit',
          color: 'primary',
          callback: this.submitData,
        },
         ],
    };
  },
  watch: {
    page() {
      this.fetchTeams();
    },
  },
  methods: {
    async fetchTeams() {
      this.loading = true;
      try {
        const response = await fetch(`http://localhost:9090/Team/List`);
        const data = await response.json();
        this.teams = data;  // Assuming the API returns a list of users
      } catch (error) {
        console.error('Error fetching users:', error);
      } finally {
        this.loading = false;
      }
    },
    openDialog() {
      this.dialogOpen = true;
    },
    closeDialog() {
      this.dialogOpen = false;
    },
    submitForm() {
      // Handle form submission logic
      alert('Form was cancelled.');
      this.dialogOpen = false;
    },
    // Async function that will handle the submit event and make the POST request
    async submitData(inputText) {
      try {
        const response = await this.postData(inputText); // Awaiting the POST request response
        this.showAlert('Team Created successfully!', 'success');
        this.teams.push(response);

        this.dialogOpen = false; // Close the dialog after successful submission
      } catch (error) {
        console.error('Error submitting data:', error);
        this.showAlert('An error occurred while submitting the data', 'error');

      }
    },

    async postData(inputText) {
      // Replace the URL with the actual endpoint
      const url = 'http://217.160.221.142:9090/Team/Create';
      const data = { name: inputText };

      // Make a POST request using fetch API
      const response = await fetch(url, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(data),
      });

      // Handle the response (parse JSON or check for errors)
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return await response.json();
    },

    showAlert(message, type) {
      this.alertMessage = message;
      this.alertType = type;
      this.alertVisible = true;  // Show the alert
      // Automatically hide the alert after 5 seconds
    setTimeout(() => {
      this.alertVisible = false;
    }, 5000); // 5000ms = 5 seconds
    },
  },
  created() {
    this.fetchTeams();
  },
};
</script>
