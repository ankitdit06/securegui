<!-- src/components/GenericDialog.vue -->
<template>
  <v-dialog v-model="localIsOpen" max-width="600px">
    <v-card>
      <!-- Dialog Title -->
      <v-card-title class="headline">{{ title }}</v-card-title>

      <!-- Dialog Content -->
      <v-card-text>
        <!-- If content slot is not provided, render the form -->
        <slot name="content">
          <v-form ref="form" v-model="isFormValid">
          <v-select
            label="Security Control"
            v-model="seccontrols"
            :items="seclist"
            item-title="name"
            item-value="id"
            multiple
            outlined
            dense
            clearable
          ></v-select>
          </v-form>
        </slot>
      </v-card-text>

      <!-- Dialog Actions -->
      <v-card-actions>
        <!-- Render action buttons passed from the parent -->
        <v-btn
          v-for="(action, index) in actions"
          :key="index"
          :color="action.color || 'primary'"
          :text="action.text"
          @click="handleAction(action)"
        />
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    title: {
      type: String,
      default: 'Dialog Title',
    },
    isOpen: {
      type: Boolean,
      default: false,
    },
    actions: {
      type: Array,
      default: () => [],
    },
  },
  data() {
    return {
      seclist: [],
      seccontrols: '',

      isFormValid: false, // Form validation state
      localIsOpen: this.isOpen, // Internal state for dialog visibility
    };
  },
  watch: {
    // Watch for changes to `isOpen` prop and sync with internal state
    isOpen(newVal) {
      this.localIsOpen = newVal;
    },
    // Watch internal state and emit update when it changes
    localIsOpen(newVal) {
      this.$emit('update:isOpen', newVal);
    },
    page() {
      this.fetchSecControl();
    },
  },
  methods: {
    handleAction(action) {
      if (action.callback) {
        if (this.isFormValid || action.text === 'Cancel') {
          action.callback(this.seccontrols); // Pass the input text to the callback
        }
      }
    },
    async fetchSecControl() {
      this.loading = true;
      try {
        const response = await fetch(`http://localhost:9090/SecurityControl/List`);
        const data = await response.json();
        this.seclist = data;
      } catch (error) {
        console.error('Error fetching users:', error);
      } finally {
        this.loading = false;
      }
    },
  },

  created() {
    this.fetchSecControl();
  },
};
</script>

<style scoped>
/* Add any specific styling here */
</style>
