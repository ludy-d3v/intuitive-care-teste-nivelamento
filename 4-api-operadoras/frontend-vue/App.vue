<template>
  <div id="app">
    <BuscaOperadoras />
  </div>
</template>

<script>
import BuscaOperadoras from './components/BuscaOperadoras.vue';

export default {
  name: 'App',
  components: {
    BuscaOperadoras,
  },
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
