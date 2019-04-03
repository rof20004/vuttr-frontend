<template>
  <v-container>

    <v-layout row justify-center align-content-center mt-5>
      <v-flex md8>
      
        <v-layout row wrap>
          <v-flex xs12>
            <h1 class="display-2 font-weight-bold mb-3">
              VUTTR
            </h1>
            <p class="subheading font-weight-regular">
              Very Useful Tools to Remember
            </p>
          </v-flex>
        </v-layout>

        <v-layout row wrap>
          <v-flex xs12 md5>
            <v-text-field v-model="searchText" prepend-inner-icon="search" label="Search" box></v-text-field>
          </v-flex>
          
          <v-flex xs12 md5>
            <v-checkbox v-model="searchTagsOnly" label="search in tags only"></v-checkbox>
          </v-flex>

          <v-flex xs12 md2>
            <v-btn block color="green" class="white--text" @click="openDialogCreateTool = true">
              <v-icon left>add</v-icon>
              Add
            </v-btn>
          </v-flex>
        </v-layout>

        <v-layout row v-if="tools.length > 0">
          <v-flex xs12>
            <tool v-for="(tool, index) in filteredTools" :key="index" :tool="tool" class="mb-4" @update="fetchTools"></tool>
          </v-flex>
        </v-layout>

      </v-flex>
    </v-layout>

    <dialog-create-tool :open="openDialogCreateTool" @close="openDialogCreateTool = false" @update="fetchTools"></dialog-create-tool>
  </v-container>
</template>

<script>
import Tool from '@/components/Tool'
import DialogCreateTool from '@/components/DialogCreateTool'

export default {
  components: {
    Tool,
    DialogCreateTool
  },

  data () {
    return {
      tools: [],
      searchText: '',
      searchTagsOnly: false,
      openDialogCreateTool: false
    }
  },

  computed: {
    filteredTools () {
      if (this.searchTagsOnly) {
        return this.tools.filter(tool => tool.tags.some(tag => tag.toUpperCase().indexOf(this.searchText.toUpperCase()) !== -1))
      } else {
        return this.tools.filter(tool => tool.title.toUpperCase().indexOf(this.searchText.toUpperCase()) !== -1 || tool.description.toUpperCase().indexOf(this.searchText.toUpperCase()) !== -1 || tool.tags.some(tag => tag.toUpperCase().indexOf(this.searchText.toUpperCase()) !== -1))
      }
    }
  },

  methods: {
    fetchTools () {
      fetch(process.env.VUE_APP_API_URL + '/tools')
        .then(response => response.json())
        .then(data => this.tools = data)
    }
  },

  created () {
    this.fetchTools()
  }
}
</script>

<style>
ul {
  padding-left: 10px;
}

ul li {
  display: inline;
}
</style>
