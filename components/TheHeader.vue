<template>
  <header>
    <nav>
      <ul>
        <li>
          <NuxtLink to="/">Home</NuxtLink>
        </li>

        <li>
          <NuxtLink to="/services">Services</NuxtLink>
        </li>
        <li>
          <NuxtLink to="/component">Component</NuxtLink>
        </li>
        <li>
          <NuxtLink to="/admin/team">Team</NuxtLink>
        </li>
        <li>
          <NuxtLink to="/admin/securitycontrols">Security Controls</NuxtLink>
        </li>



      </ul>

    </nav>

  </header>

</template>

<style scoped lang="scss">
header {
  background-color: black;
  color: #fff;
  padding: 0.2rem;

  nav {
    ul {
      list-style: none;
      display: flex;
      align-items: center;

      li {
        margin-right: 1rem;

        a {
          color: #fff;
          text-decoration: none;
        }
      }
    }
  }
}
</style>
<script>
export default {
data() {
  return {
    menu: false,
  };
},
methods: {
  navigateTo(route) {
    this.$router.push(route); // Navigate to the specified route
    this.menu = false; // Close the menu after navigating
  },
},
};
</script>
