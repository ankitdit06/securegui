<template>
<v-card >

<v-card-text style="color: black; font-size: 20px; font-weight: bold; background-color:#e4e8f0">
      Service Information
    </v-card-text>
<div class="d-flex flex-row">
    <v-tabs

      v-model="tab"
      bg-color="#e4e8f0"
       direction="vertical"
    >
      <v-tab value="one">Basic Service Details</v-tab>
      <v-tab value="two">Security Assessment</v-tab>
      <v-tab value="three">Security Controls</v-tab>
      <v-tab value="four">Integration Guide</v-tab>
      <v-tab value="five">Components</v-tab>
      <v-tab value="six">Threat Model</v-tab>
    </v-tabs>

    <v-card-text>
      <v-tabs-window v-model="tab">
        <v-tabs-window-item value="one">
        <v-row>

          <!-- Name Field -->
          <v-col cols="6">
        <v-text-field
          label="Service Name"
          v-model="service.name"

          outlined
          dense
          clearable
          readonly
        ></v-text-field>
        </v-col>
        <v-col cols="6">
      <v-text-field
        label="Team Name"
        v-model="service.team"

        outlined
        dense
        clearable
        readonly
      ></v-text-field>
      </v-col>

        </v-row>

        <v-row>

          <!-- Name Field -->
          <v-col cols="6">
        <v-text-field
          label="Public Facing"
          v-model="service.publicfacing"

          outlined
          dense
          clearable
          readonly
        ></v-text-field>
        </v-col>
        <v-col cols="6">
        <v-text-field
        label="Release"
        v-model="service.release"

        outlined
        dense
        clearable
        readonly
        ></v-text-field>
        </v-col>

        </v-row>

        </v-tabs-window-item>

        <v-tabs-window-item value="two">
        <v-row>

          <!-- Name Field -->
          <v-col cols="6">
        <v-text-field
          label="Last Reviewed"
          v-model="service.last_reviewed"

          outlined
          dense
          clearable
          readonly
        ></v-text-field>
        </v-col>
        <v-col cols="6">
      <v-text-field
        label="Reviewed By"
        v-model="service.reviewed_by"

        outlined
        dense
        clearable
        readonly
      ></v-text-field>
      </v-col>

        </v-row>

        <v-row>

          <!-- Name Field -->
          <v-col cols="6">
        <v-text-field
          label="Review Summary"
          v-model="service.reviewsummary"

          outlined
          dense
          clearable
          readonly
        ></v-text-field>
        </v-col>
        <v-col cols="6">
        <v-text-field
        label="Data Classification"
        v-model="service.data_classification"

        outlined
        dense
        clearable
        readonly
        ></v-text-field>
        </v-col>

        </v-row>


        <v-row>

          <!-- Name Field -->
          <v-col cols="6">
        <v-text-field
          label="Data Retention Policy"
          v-model="service.data_retention_policy"

          outlined
          dense
          clearable
          readonly
        ></v-text-field>
        </v-col>
        <v-col cols="6">
        <v-text-field
        label="Confidentiality"
        v-model="service.confidentiality"

        outlined
        dense
        clearable
        readonly
        ></v-text-field>
        </v-col>

        </v-row>

        <v-row>

          <!-- Name Field -->
          <v-col cols="6">
        <v-text-field
          label="Avaibility"
          v-model="service.avaibility"

          outlined
          dense
          clearable
          readonly
        ></v-text-field>
        </v-col>
        <v-col cols="6">
        <v-text-field
        label="Integrity"
        v-model="service.integrity"

        outlined
        dense
        clearable
        readonly
        ></v-text-field>
        </v-col>

        </v-row>


        <v-row>

          <!-- Name Field -->
          <v-col cols="6">
        <v-text-field
          label="Business Impact"
          v-model="service.business_impact"

          outlined
          dense
          clearable
          readonly
        ></v-text-field>
        </v-col>
        <v-col cols="6">
        <v-text-field
        label="Status"
        v-model="service.status"

        outlined
        dense
        clearable
        readonly
        ></v-text-field>
        </v-col>
        <v-col cols="6">
        <v-text-field
        label="Status"
        v-model="service.reviewsummary"

        outlined
        dense
        clearable
        readonly
        ></v-text-field>
        </v-col>

        </v-row>

        </v-tabs-window-item>

        <v-tabs-window-item value="three">


        <v-btn @click="openDialog" color="primary">Select Security Control</v-btn>
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
        <SecControlFormDialog
          v-model:isOpen="dialogOpen"
          title="Select Security Controls"
          :actions="dialogActions"
           @submit="submitData"

        />

        <v-card
    class="mx-auto pa-2"
    max-width="300"
  >
   <v-list-subheader>Securitys Controls</v-list-subheader>
    <v-list  v-if="servicesecontrols.length">
      <v-list-item
        v-for="(item, index) in servicesecontrols"
        :key="index"
      >


          <v-list-item-title>{{ item.name }}</v-list-item-title>
          <v-list-item-subtitle></v-list-item-subtitle>

      </v-list-item>
    </v-list>


 </v-card>

        </v-tabs-window-item>
        <v-tabs-window-item value="five">
          <AppExpansionPanel/>
        </v-tabs-window-item>
      </v-tabs-window>
    </v-card-text>
</div>
</v-card>
</template>
<script>
export default {
  data() {
    return {
      tab:null,
      // Data structure for Product Information and Security Assessment
      service: {
        name: '',
        team:'',
        publicfacing:'',
        release:'',
        last_reviewed: '',
        reviewed_by: '',
        reviewsummary:'',
        data_classification: '',
        data_retention_policy:'',
        confidentiality: '',
        avaibility: '',
        integrity:'',
        business_impact: '',
        status:'',


      },
      selectedTab: 0,  // Default selected tab
      loading: false,  // Flag for loading state
      servicesecontrols:[],
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
  mounted() {
    this.fetchProductData();
    this.fetchServiceSecControl();
  },
  methods: {

  async fetchServiceSecControl() {
  var sid= useRoute()
  var serId=sid.params.id

    try {
      // Replace with your API URL
      const response = await fetch("http://217.160.221.142:9090/Service/SecurityControl/"+serId);

      if (!response.ok) {
        throw new Error(`Error: ${response.status} ${response.statusText}`);
      }

      const data = await response.json();
      // Assuming each item has `title` and `description` fields
      this.servicesecontrols = data.map((item) => ({
        name: item.SecurityControl.name,
        description: "Aad",
      }));
    //  alert(JSON.stringify(this.servicesecontrols))
    } catch (error) {

    } finally {

    }
  },
    // Fetch data for the product information and security assessment
    async fetchProductData() {
    var sid= useRoute()
    var serId=sid.params.id

      this.loading = true;
      try {
        const response = await fetch('http://217.160.221.142:9090/Service/'+serId); // Replace with your API URL
        const data = await response.json();
        //alert(JSON.stringify(data))
        // Assign product information data
        this.service = {
          name: data.name,
          team:data.Team.name,
          release:data.release,
          publicfacing: data.publicfacing,
          last_reviewed: '',
          reviewed_by: '',
          reviewsummary:data.audits.reviewsummary,
          data_classification: data.audits.data_classification,
          data_retention_policy:data.audits.data_retention_policy,
          confidentiality: data.audits.confidentiality,
          avaibility:data.audits.avaibility,
          integrity:data.audits.integrity,
          business_impact: data.audits.business_impact,
          status:data.audits.status,
        };


        this.$nextTick()
      } catch (error) {
        console.error('Error fetching data:', error);
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
    async submitData(selectItems) {
      try {
      var sid= useRoute()
      var serId=sid.params.id

      selectItems = selectItems.filter(item => item.trim() !== "");
           var formattedObject = { 'controlIds': selectItems,'serviceId': serId};
      alert(JSON.stringify(formattedObject))
        const response = await this.postData(formattedObject); // Awaiting the POST request response
        this.showAlert('Security Controls Created successfully!', 'success');
        //this.teams.push(response);

        this.dialogOpen = false; // Close the dialog after successful submission
      } catch (error) {
        console.error('Error submitting data:', error);
        this.showAlert('An error occurred while submitting the data', 'error');

      }
    },

    async postData(selectItems) {
      // Replace the URL with the actual endpoint
      const url = 'http://217.160.221.142:9090/SecurityControl/AddService';
      const data = selectItems;

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
};
</script>
