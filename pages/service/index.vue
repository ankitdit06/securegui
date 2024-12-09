<template>
  <div>



    <!-- Include the child component -->

    <v-btn @click="navigateTo('service/create')" color="primary">Add Service</v-btn>
   <AppDataTable/>
     </div>

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
