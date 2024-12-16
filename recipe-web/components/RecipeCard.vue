
<template>
  <div class="card recipe-card">
    <img :src="recipe.picture" class="card-img-top" >
    <div class="card-body">
      <h5 class="card-title">{{ recipe.name }}</h5>
      <p class="card-text">
        <strong>Ingredients:</strong> {{ recipe.ingredients }}
      </p>
      <div class="action-buttons">
        <nuxt-link :to="`/recipes/${recipe.id}/`" class="btn btn-sm btn-success"> Ver </nuxt-link>
        <nuxt-link :to="`/recipes/${recipe.id}/edit/`" class="btn btn-sm btn-primary"> Editar </nuxt-link>
        <button @click="onDelete(recipe.id)"  class="btn btn-sm btn-danger">Deletar</button>
      </div>
    </div>
  </div>
</template>
<script>
export default {
    props: ["recipe", "onDelete"]
};
</script>
<style>
.recipe-card {
    box-shadow: 0 1rem 1.5rem rgba(0,0,0,.6);
}
</style>
