<!-- src/components/Sidebar.vue -->
<template>
  <v-navigation-drawer

        permanent app >
    <!-- Sidebar Content -->
    <v-row class="align-center pa-4">
      <v-col>

        <img src="public/SecuReg_logo_new.png" />

      </v-col>

    </v-row>





    <!-- Navigation Links -->
    <v-list>
      <v-list-item @click="navigateTo('/')">
        <v-list-item-content>
          <v-list-item-title>Home</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <v-list-item @click="navigateTo('/service')">
        <v-list-item-content>
          <v-list-item-title>Services</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <v-list-item @click="navigateTo('/component')">
        <v-list-item-content>
          <v-list-item-title>Component</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <v-list-item @click="navigateTo('/team')">
        <v-list-item-content>
          <v-list-item-title>Teams</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <v-list-item @click="navigateTo('/securitycontrol')">
        <v-list-item-content>
          <v-list-item-title>Security Controls</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>

    <!-- Sidebar Footer -->
    <v-divider></v-divider>
    <v-footer class="pa-3" padless>
      <v-row>
        <v-col class="text-center" cols="12">
          <span>Copyright - 2024 SecuReg</span>
        </v-col>
      </v-row>
    </v-footer>
  </v-navigation-drawer>
</template>

<script>

export default {

  methods: {

    navigateTo(route) {
      this.$router.push(route); // Navigate to the specified route
    },
  },
};
</script>
