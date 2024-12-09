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
            <v-text-field
              v-model="inputSecControl"
              label="Enter Security Control"
              outlined
              :rules="[v => !!v || 'This field is required']"
            />
            <v-text-field
              v-model="inputRisk"
              label="Enter Risk"
              outlined
              :rules="[v => !!v || 'This field is required']"
            />
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
      inputSecControl: '', // Text field value
      inputRisk: '', // Text field value
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
  },
  methods: {
    handleAction(action) {
      if (action.callback) {
        if (this.isFormValid || action.text === 'Cancel') {
          action.callback(this.inputSecControl,this.inputRisk); // Pass the input text to the callback
        }
      }
    },
  },
};
</script>

<style scoped>
/* Add any specific styling here */
</style>
