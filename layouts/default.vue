<!-- src/layouts/default.vue -->
<template>
  <v-app>

    <AppHeader />
    <!-- Sidebar inclusion -->
    <AppSidebar />

    <!-- Main Content Area -->
    <v-main>
      <v-container>
        <!-- The content will be injected here dynamically -->
        <slot />
      </v-container>
    </v-main>
  </v-app>
</template>
