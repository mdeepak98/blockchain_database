<template>
  <div id="app">
    <v-app elevation='0'>
      <!-- <p>{{ message }}</p> -->
      <user/>
    </v-app>
  </div>
</template>

<script>
import user from "./packs/components/xclusiveLedger.vue";
export default {
  data: function() {
    return {
      message: "Hello Vue!"
    };
  },
  components: {
    user: user
  }
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>