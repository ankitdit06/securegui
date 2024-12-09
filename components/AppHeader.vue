<template>

<v-app-bar image="https://cdn.vuetifyjs.com/images/backgrounds/bg-2.jpg"
    theme="dark" app elevate-on-scroll>
   <v-row align="center" justify="space-between" class="mx-4">
     <v-col cols="auto"  class="text-right">
      <!-- <v-avatar size="40">
         <img src="https://via.placeholder.com/40" alt="User Profile" />
       </v-avatar>-->
     </v-col>

     <v-col cols="auto" class="text-right">
     <v-btn icon>
        <v-icon>mdi-magnify</v-icon>
      </v-btn>

      <v-btn icon>
        <v-icon>mdi-heart</v-icon>
      </v-btn>

      <v-btn icon>
        <v-icon>mdi-dots-vertical</v-icon>
      </v-btn>
       <v-btn icon @click="logout">
         <v-icon>mdi-logout</v-icon>
       </v-btn>
     </v-col>
   </v-row>
 </v-app-bar>
 </template>
