<template>
  <v-container>
    <!-- Dashboard Row 1 -->
    <v-row>
      <!-- Card 1: Total Sales -->
      <v-col cols="12" md="4">
        <v-card class="pa-4" elevation="2">
          <v-card-title>Available Services</v-card-title>
          <v-card-subtitle class="text-h5">{{dashboard.serviceCount}}</v-card-subtitle>
          <v-card-actions>
            <v-btn text color="primary">View Details</v-btn>
          </v-card-actions>
        </v-card>
      </v-col>

      <!-- Card 2: New Users -->
      <v-col cols="12" md="4">
        <v-card class="pa-4" elevation="2">
          <v-card-title>Registered Components</v-card-title>
          <v-card-subtitle class="text-h5">{{dashboard.componentCount}}</v-card-subtitle>
          <v-card-actions>
            <v-btn text color="primary">View Details</v-btn>
          </v-card-actions>
        </v-card>
      </v-col>

      <!-- Card 3: Revenue -->
      <v-col cols="12" md="4">
        <v-card class="pa-4" elevation="2">
          <v-card-title>Teams</v-card-title>
          <v-card-subtitle class="text-h5">{{dashboard.teamCount}}</v-card-subtitle>
          <v-card-actions>
            <v-btn text color="primary">View Details</v-btn>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>

    <!-- Dashboard Row 2 -->
    <v-row>
      <!-- Card 4: Monthly Overview with Chart -->
      <v-col cols="12" md="6">
        <v-card class="pa-4" elevation="2">
          <v-card-title>SecurityControls</v-card-title>
          <v-card-text>
            <line-chart :data="monthlyData" :options="chartOptions" />
          </v-card-text>
        </v-card>
      </v-col>

      <!-- Card 5: Activity -->
      <v-col cols="12" md="6">
        <v-card class="pa-4" elevation="2">
          <v-card-title>Recent Activity</v-card-title>
          <v-list>
            <v-list-item v-for="activity in activities" :key="activity.id">
              <v-list-item-content>
                <v-list-item-title>{{ activity.title }}</v-list-item-title>
                <v-list-item-subtitle>{{ activity.time }}</v-list-item-subtitle>
              </v-list-item-content>
            </v-list-item>
          </v-list>
        </v-card>
      </v-col>
    </v-row>




  </v-container>
</template>

<script>
// Import the necessary components from chart.js
import { Line } from 'vue-chartjs';
import { reactive } from 'vue';
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  LineElement,
  PointElement,  // Register the Point element explicitly
  CategoryScale,
  LinearScale
} from 'chart.js';

// Register the required chart components globally
ChartJS.register(
  Title,
  Tooltip,
  Legend,
  LineElement,
  PointElement,  // Register PointElement
  CategoryScale,
  LinearScale
);

export default {
  components: {
    LineChart: Line, // Register Line chart component
  },
  data() {
    return {
      // Dummy Data for Cards
      dashboard:{
      serviceCount:'',
      componentCount:'',
      teamCount:''
      },
      monthlyData: {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
        datasets: [
          {
            label: 'Revenue',
            data: [3000, 4000, 3500, 4500, 5000, 4800],
            fill: false,
            borderColor: '#42A5F5',
            tension: 0.1
          }
        ]
      },
      // Chart options
      chartOptions: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          y: {
            beginAtZero: true,
          },
        },
      },
      activities: [
        { id: 1, title: 'User signed up', time: '2 hours ago' },
        { id: 2, title: 'New product added', time: '5 hours ago' },
        { id: 3, title: 'Server maintenance', time: '1 day ago' },
        { id: 4, title: 'System update completed', time: '2 days ago' }
      ]
    };
  },

  watch: {
    page() {
      this.fetchDashboardCount();
    },
  },
  methods: {
  async fetchDashboardCount(){

    try {
      // Replace with your API URL
      const response = await fetch("http://217.160.221.142:9090/Dashboard");

      if (!response.ok) {
        throw new Error(`Error: ${response.status} ${response.statusText}`);
      }

      const data = await response.json();
      this.dashboard.serviceCount=data.serviceCount
      this.dashboard.componentCount=data.componentCount
      this.dashboard.teamCount=data.teamCount
      } catch (error) {

    } finally {

    }
  }
  }
  ,
  created() {
    this.fetchDashboardCount();
  },
};
</script>

<style scoped>
/* Add custom styling for the dashboard */
.v-card {
  background-color: #f9fafb;
}

.v-card-title {
  font-size: 1.2em;
  font-weight: 600;
}

.v-card-subtitle {
  font-size: 2em;
  font-weight: bold;
}

.v-btn {
  text-transform: none;
}

.v-alert {
  margin-top: 20px;
}

.v-card-text {
  padding: 16px;
}
</style>
