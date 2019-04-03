<template>
  <v-layout row justify-center>
    <v-dialog :value="open" @input="updateStatus" max-width="600px">
      <v-card>
        <v-card-title>
          <v-icon>add</v-icon> <span class="headline">Add new tool</span>
        </v-card-title>
        <v-card-text>
          <v-container grid-list-md>
            <v-layout row>
              <v-flex xs12>
                <v-text-field label="Tool name" required box v-model="tool.title"></v-text-field>
              </v-flex>
            </v-layout>

            <v-layout row>
              <v-flex xs12>
                <v-text-field label="Tool link" required box v-model="tool.link"></v-text-field>
              </v-flex>
            </v-layout>

            <v-layout row>
              <v-flex xs12>
                <v-textarea label="Tool description" required box v-model="tool.description"></v-textarea>
              </v-flex>
            </v-layout>

            <v-layout wrap>
              <v-flex xs12>
                <v-combobox multiple
                          v-model="tool.tags" 
                          label="Tags" 
                          append-icon
                          chips
                          deletable-chips
                          box
                          class="tag-input">
                </v-combobox>
              </v-flex>
            </v-layout>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" flat @click="save">Add tool</v-btn>
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
    }
  },

  data () {
    return {
      tool: {
        title: '',
        link: '',
        description: '',
        tags: []
      }
    }
  },

  methods: {
    save () {
      fetch('http://localhost:3000/tools', {
        method: 'POST',
        body: JSON.stringify(this.tool),
        headers: {
          'Content-Type': 'application/json'
        }
      }).then(response => response.json())
        .then(data => {
          this.$emit('update')
          this.updateStatus()
        })
    },

    updateStatus() {
      this.tool.title = ''
      this.tool.link = ''
      this.tool.description = ''
      this.tool.tags = []
      this.$emit('close')
    }
  }
}
</script>
