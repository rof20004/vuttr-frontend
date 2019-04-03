<template>
  <v-layout row justify-center v-if="tool">
    <v-dialog :value="open" @input="updateStatus" max-width="600px">
      <v-card>
        <v-card-title>
          <v-icon>clear</v-icon> <span class="headline">Remove tool</span>
        </v-card-title>
        <v-card-text>
          Are you sure you want to remove <b>{{ tool.title }}</b>?
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" flat @click="$emit('close')">Cancel</v-btn>
          <v-btn color="red darken-1" flat @click="remove">Yes, remove</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-layout>
</template>

<script>
export default {
  props: {
    open: {
      type: Boolean,
      required: true,
      default: false
    },

    tool: {
      type: Object,
      required: false
    }
  },

  methods: {
    remove () {
      fetch(`${process.env.VUE_APP_API_URL}/tools/${this.tool.id}`, {
        method: 'DELETE'
      }).then(response => response.json())
        .then(() => {
          this.$emit('update')
          this.updateStatus()
        })
    },

    updateStatus () {
      this.$emit('close')
    }
  }
}
</script>
