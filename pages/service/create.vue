<template>
  <v-container>
  <v-alert
    v-if="alertVisible"
    :type="alertType"
    dismissible
    @input="alertVisible = false"
  >
    {{ alertMessage }}
  </v-alert>
    <v-form ref="form" v-model="valid">
      <!-- Column Layout -->
      <v-row>
      <v-col cols="12">
        <h3>Basic Service Details</h3>
      </v-col>

        <!-- Name Field -->
        <v-col cols="6">
          <v-text-field
            label="Name"
            v-model="formData.name"
            :rules="[rules.required]"
            outlined
            dense
            clearable
          ></v-text-field>
        </v-col>

        <!-- Release Field -->
        <v-col cols="6">
          <v-text-field
            label="Release"
            v-model="formData.release"
            :rules="[rules.required]"
            outlined
            dense
            clearable
          ></v-text-field>
        </v-col>

        <!-- Public Facing Field -->
        <v-col cols="6">
          <v-select
            label="Public Facing"
            v-model="formData.publicFacing"
            :items="['Yes', 'No']"


            outlined
            dense
            clearable
          ></v-select>
        </v-col>
        <v-col cols="6">
          <v-select
            label="Team"
            v-model="formData.teamid"
            :items="teams"
            item-title="name"
            item-value="id"

            outlined
            dense
            clearable
          ></v-select>
        </v-col>
        <!-- Business Description Field -->
       <v-col cols="12">
         <v-textarea
           label="Business Description"
           v-model="formData.description"
           outlined
           dense
           clearable
           rows="3"
         ></v-textarea>
           </v-col>
      </v-row>


      <!-- Divider -->
      <v-divider class="my-4"></v-divider>

      <!-- Security Review Section -->
      <v-row>
        <v-col cols="12">
          <h3>Security Review</h3>
        </v-col>

        <!-- Data Classification Field -->
        <v-col cols="6">
          <v-select
            label="Data Classification"
            v-model="formData.audits.dataClassification"
            :items="['Low', 'Medium', 'High']"
            outlined
            dense
            clearable
          ></v-select>
        </v-col>

        <!-- CIA Options -->
        <v-col cols="6">
          <v-select
            label="Confidentiality"
            v-model="formData.audits.confidentiality"
            :items="['High', 'Medium', 'Low']"
            outlined
            dense
            clearable
          ></v-select>
        </v-col>
        <v-col cols="6">
          <v-select
            label="Integrity"
            v-model="formData.audits.integrity"
            :items="['High', 'Medium', 'Low']"
            outlined
            dense
            clearable
          ></v-select>
        </v-col>
        <v-col cols="6">
          <v-select
            label="Avaibility"
            v-model="formData.audits.avaibility"
            :items="['High', 'Medium', 'Low']"
            outlined
            dense
            clearable
          ></v-select>
        </v-col>
        <v-col cols="6">
          <v-select
            label="Business Impact"
            v-model="formData.audits.businessImpact"
            :items="['High', 'Medium', 'Low']"
            outlined
            dense
            clearable
          ></v-select>
        </v-col>
        <v-col cols="6">
          <v-select
            label="Status"
            v-model="formData.audits.status"
            :items="['In-Progress', 'Closed']"
            outlined
            dense
            clearable
          ></v-select>
        </v-col>
        <!-- Remarks Field -->
       <v-col cols="12">
         <v-textarea
           label="Remarks"
           v-model="formData.audits.remarks"
           outlined
           dense
           clearable
           rows="3"
         ></v-textarea>
       </v-col>
      </v-row>

      <!-- Divider -->
      <v-divider class="my-4"></v-divider>

      <!-- Key-Value Section -->
      <v-row>
        <v-col cols="12">
          <h3>Additional Metadata</h3>
        </v-col>

        <v-col cols="5">
          <v-text-field
            label="Key"
            v-model="keyValue.key"
            outlined
            dense
            clearable
          ></v-text-field>
        </v-col>

        <v-col cols="5">
          <v-text-field
            label="Value"
            v-model="keyValue.value"
            outlined
            dense
            clearable
          ></v-text-field>
        </v-col>

        <v-col cols="2" class="d-flex align-center justify-center">
          <v-btn color="primary" @click="addKeyValue" small>
            Add
          </v-btn>
        </v-col>

        <v-col cols="12">
          <v-list>
            <v-list-item v-for="(item, index) in formData.keyValuePairs" :key="index" dense>
              <v-list-item-content>
              <span style="flex: 1;">{{ item.key }}: {{ item.value }}</span>
                <v-btn @click="removeKeyValue(index)" class="text-danger" small>
                  <v-icon small color="error">mdi-delete-outline</v-icon>
                </v-btn>
              </v-list-item-content>

            </v-list-item>
          </v-list>
        </v-col>
      </v-row>

      <!-- Submit Button -->
      <v-btn :disabled="!valid" @click="submitData" color="primary" class="mt-4">
        Submit
      </v-btn>
    </v-form>
  </v-container>
</template>

<script>
export default {
  data() {
    return {

      teams: [],            // Store the fetched data for v-select options
      valid: false,
      alertVisible: false,  // Flag to show/hide the alert
      alertMessage: '',     // Message to display in the alert
      alertType: '',        // Type of the alert ('success', 'error', etc.)
      formData: {
        name: "",
        release: "",
        publicFacing: "",
        dataClassification: "",
        audits: {
        dataClassification: "",
        confidentiality: "",
        integrity: "",
        avaibility: "",
        remarks: "",
        },
        keyValuePairs: [],
      },
      keyValue: {
        key: "",
        value: "",
      },
      rules: {
        required: (value) => !!value || "Required.",
      },
    };
  },
  mounted() {
    this.fetchTeams();
  },
  methods: {

  async fetchTeams() {
    this.loading = true;
    try {
      const response = await fetch(`http://217.160.221.142:9090/Team/List`);
      const data = await response.json();
      this.teams = data;  // Assuming the API returns a list of users
    } catch (error) {
      console.error('Error fetching users:', error);
    } finally {
      this.loading = false;
    }
  },
    addKeyValue() {
      if (this.keyValue.key && this.keyValue.value) {
        this.formData.keyValuePairs.push({ ...this.keyValue });
        this.keyValue.key = "";
        this.keyValue.value = "";
      }
    },
    removeKeyValue(index) {
      this.formData.keyValuePairs.splice(index, 1);
    },
    submitForm() {
      if (this.$refs.form.validate()) {
      const keyValueObject = this.formData.keyValuePairs.reduce((acc, pair) => {
          acc[pair.key] = pair.value;
          return acc;
        }, {});
        const formDataWithKeyValue = {
          ...this.formData,
          keyValuePairs: keyValueObject,
          audits: [this.formData.audits],
        };
        //submitData(JSON.stringify(formDataWithKeyValue, null, 2))
      alert("Form Submitted!\n" + JSON.stringify(formDataWithKeyValue, null, 2));
      }
    },

    // Async function that will handle the submit event and make the POST request
    async submitData() {
    var inputText
      try {
      if (this.$refs.form.validate()) {
      const keyValueObject = this.formData.keyValuePairs.reduce((acc, pair) => {
          acc[pair.key] = pair.value;
          return acc;
        }, {});
        const formDataWithKeyValue = {
          ...this.formData,
          keyValuePairs: keyValueObject,
          audits: this.formData.audits,
        };
        inputText=JSON.stringify(formDataWithKeyValue, null, 2)
      //  alert("Form Submitted!\n" + JSON.stringify(formDataWithKeyValue, null, 2));
      }
        const response = await this.postData(inputText); // Awaiting the POST request response
        this.showAlert('Service Created successfully!', 'success');
      } catch (error) {
        console.error('Error submitting data:', error);
        this.showAlert('An error occurred while submitting the data', 'error');

      }
    },

    async postData(data) {
      // Replace the URL with the actual endpoint
      const url = 'http://217.160.221.142:9090/Service/Create';

      // Make a POST request using fetch API
      const response = await fetch(url, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body:data,
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
    }
  },
};
</script>

<style scoped>
.v-btn {
  width: auto;
  min-width: 80px;
}
.text-danger {
  margin-left:10px;
  color: #e53935 !important;
}
</style>
