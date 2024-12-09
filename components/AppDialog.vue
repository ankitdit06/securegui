<template>
  <div class="text-center pa-4">
    <v-dialog
      v-bind="dialog"
      transition="dialog-bottom-transition"
      fullscreen
    >
      <template v-slot:activator="{ props: activatorProps }">
        <v-btn
          prepend-icon="mdi-cog"
          size="small"
          text="Add Service"
          v-bind="activatorProps"
        ></v-btn>
      </template>

      <v-card>
        <v-toolbar>
          <v-btn
            icon="mdi-close"
            @click="dialog = false"
          ></v-btn>

          <v-toolbar-title>Add Service</v-toolbar-title>

          <v-spacer></v-spacer>

          <v-toolbar-items>
            <v-btn
              text="Save"
              variant="text"
              @click="dialog = false"
            ></v-btn>
          </v-toolbar-items>
        </v-toolbar>
        <v-card-text>
                  <v-row dense>
                    <v-col
                      cols="12"
                      md="4"
                      sm="6"
                    >
                      <v-text-field
                        label="Service Name*"
                        required
                      ></v-text-field>
                    </v-col>


                    <v-col
                      cols="6"
                      sm="2"
                    >
                      <v-select
                        :items="['Delta', 'Gamma', 'Alpha', 'Beta']"
                        label="Team*"
                        required
                      ></v-select>
                    </v-col>

                    <v-col
                      cols="12"
                      sm="6"
                    >
                      <v-autocomplete
                        :items="['Skiing', 'Ice hockey', 'Soccer', 'Basketball', 'Hockey', 'Reading', 'Writing', 'Coding', 'Basejump']"
                        label="Interests"
                        auto-select-first
                        multiple
                      ></v-autocomplete>
                    </v-col>
                  </v-row>

                  <small class="text-caption text-medium-emphasis">*indicates required field</small>
                </v-card-text>
        <v-list
          lines="two"
          subheader
        >
          <v-list-subheader>Data Classification</v-list-subheader>
          <v-list-item
            subtitle="High"
            title="Integrity"
            @click="notifications = !notifications"
          >
            <template v-slot:prepend>
              <v-list-item-action start>
                <v-checkbox-btn v-model="notifications" color="primary"></v-checkbox-btn>
              </v-list-item-action>
            </template>
          </v-list-item>


          <v-list-item
            subtitle="Require password for purchase or use password to restrict purchase"
            title="Password"
            link
          ></v-list-item>


          <v-list-item
            subtitle="Set the content filtering level to restrict apps that can be downloaded"
            title="General"
            link
          ></v-list-item>

          <v-list-item
            subtitle="Require password for purchase or use password to restrict purchase"
            title="Password"
            link
          ></v-list-item>

          <v-divider></v-divider>

          <v-list-subheader>Security Audit</v-list-subheader>

          <v-list-item
            subtitle="Notify me about updates to apps or games that I downloaded"
            title="Notifications"
            @click="notifications = !notifications"
          >
            <template v-slot:prepend>
              <v-list-item-action start>
                <v-checkbox-btn v-model="notifications" color="primary"></v-checkbox-btn>
              </v-list-item-action>
            </template>
          </v-list-item>

          <v-list-item
            subtitle="Auto-update apps at any time. Data charges may apply"
            title="Sound"
            @click="sound = !sound"
          >
            <template v-slot:prepend>
              <v-list-item-action start>
                <v-checkbox-btn v-model="sound" color="primary"></v-checkbox-btn>
              </v-list-item-action>
            </template>
          </v-list-item>

          <v-list-item
            subtitle="Automatically add home screen widgets"
            title="Auto-add widgets"
            @click="widgets = !widgets"
          >
            <template v-slot:prepend>
              <v-list-item-action start>
                <v-checkbox-btn v-model="widgets" color="primary"></v-checkbox-btn>
              </v-list-item-action>
            </template>
          </v-list-item>
        </v-list>
      </v-card>
    </v-dialog>
  </div>
</template>
<script>
  export default {
    data () {
      return {
        dialog: false,
        notifications: false,
        sound: true,
        widgets: false,
      }
    },
  }
</script>
