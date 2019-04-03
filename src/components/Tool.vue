<template>
  <div>
    <v-card hover style="cursor: default;">
      <v-card-title primary-title>
        <v-layout row>
          <v-flex xs12 md10>
            <h3 class="blue--text">
              <a :href="tool.link" target="_blank" v-if="tool.link" v-text="tool.title"></a>
              <label v-else v-text="tool.title"></label>
            </h3>
          </v-flex>

          <v-spacer></v-spacer>

          <v-flex xs12 md2>
            <v-btn block flat small color="red" @click="openRemoveDialog(tool)">
              <v-icon small>clear</v-icon>
              Remove
            </v-btn>
          </v-flex>
        </v-layout>
      </v-card-title>

      <v-card-text class="mt-0 pt-0">
        <v-layout row>
          <v-flex xs12>
            <div v-text="tool.description"></div>
          </v-flex>
        </v-layout>
      </v-card-text>

      <v-card-actions>
        <ul>
          <li v-for="(tag, index) in tool.tags" :key="index" v-text="`#${tag} `"></li>
        </ul>
      </v-card-actions>
    </v-card>
    <dialog-remove-tool :tool="selectedTool" :open="openDialogRemoveTool" @close="openDialogRemoveTool = false" @update="$emit('update')"></dialog-remove-tool>
  </div>
</template>

<script>
import DialogRemoveTool from '@/components/DialogRemoveTool'

export default {
  components: {
    DialogRemoveTool
  },

  props: {
    tool: {
      type: Object,
      required: true
    }
  },

  data () {
    return {
      selectedTool: null,
      openDialogRemoveTool: false
    }
  },

  methods: {
    openRemoveDialog (tool) {
      this.selectedTool = Object.assign({}, tool)
      this.openDialogRemoveTool = true
    }
  }
}
</script>
