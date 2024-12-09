<template>
<v-card >

<v-card-text style="color: black; font-size: 20px; font-weight: bold; background-color:#e4e8f0">
      Component Information
    </v-card-text>
<div class="d-flex flex-row">
    <v-tabs

      v-model="tab"
      bg-color="#e4e8f0"
       direction="vertical"
    >
      <v-tab value="one">Basic Component Details</v-tab>
      <v-tab value="two">Vulnerabilities</v-tab>

    </v-tabs>

    <v-card-text>
      <v-tabs-window v-model="tab">
        <v-tabs-window-item value="one">
        <v-row>

          <!-- Name Field -->
          <v-col cols="6">
        <v-text-field
          label="Component Name"
          v-model="component.name"

          outlined
          dense
          clearable
          readonly
        ></v-text-field>
        </v-col>
        <v-col cols="6">
      <v-text-field
        label="Team Name"
        v-model="component.team"

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
          label="Version"
          v-model="component.version"

          outlined
          dense
          clearable
          readonly
        ></v-text-field>
        </v-col>
        <v-col cols="6">
        <v-text-field
        label="Target URL"
        v-model="component.url"

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
          label="Platform"
          v-model="component.platform"

          outlined
          dense
          clearable
          readonly
        ></v-text-field>
        </v-col>
        <v-col cols="6">
      <v-text-field
        label="Document Reference"
        v-model="component.document_ref"

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
          label="API Reference"
          v-model="component.api_ref"

          outlined
          dense
          clearable
          readonly
        ></v-text-field>
        </v-col>
        <v-col cols="6">
        <v-text-field
        label="Team"
        v-model="component.team"

        outlined
        dense
        clearable
        readonly
        ></v-text-field>
        </v-col>

        </v-row>


        </v-tabs-window-item>

        <v-tabs-window-item value="two">
          two
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
      component: {
        id: '',
        name: '',
        team:'',
        version:'',
        url:'',
        platform: '',
        document_ref: '',
        api_ref:'',
        metadata: '',


      },
      selectedTab: 0,  // Default selected tab
      loading: false,  // Flag for loading state
    };
  },
  mounted() {
    this.fetchComponentData();
  },
  methods: {
    // Fetch data for the product information and security assessment
    async fetchComponentData() {
    var sid= useRoute()
    var serId=sid.params.id

      this.loading = true;
      try {
        const response = await fetch('http://localhost:9090/Component/'+serId); // Replace with your API URL
        const data = await response.json();
        //alert(JSON.stringify(data))
        // Assign product information data
        this.component = {
          name: data.name,
          version:data.version,
          url:data.url,
          platform: data.platform,
          document_ref: data.document_ref,
          api_ref: data.api_ref,
          team:data.team.name,
          service_id: data.service_id,
          id:data.id,

        };


        this.$nextTick()
      } catch (error) {
        console.error('Error fetching data:', error);
      } finally {
        this.loading = false;
      }
    },
  },
};
</script>
