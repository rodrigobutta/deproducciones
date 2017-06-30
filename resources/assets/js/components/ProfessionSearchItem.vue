<template>
	<li class="go-black">
	    <router-link :to="'/p/' + list.slug">

		    <div class="v-contact">
		        <h3>#{{ list.title }}</h3>
		    </div>
	    </router-link>
	</li>
</template>

<script>
	export default {
		props: ['list'],
	}
</script>
