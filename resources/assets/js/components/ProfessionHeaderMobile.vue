<template>
	<div class="profession-header-mobile" v-bind:style="{ background: coverBackground }">
		<router-link :to="'/c/' + Store.profession.name">
			<img :src="Store.profession.avatar" :alt="Store.profession.name">

			<h2>
				{{ '#' + Store.profession.name }}
			</h2>
		</router-link>
	</div>
</template>

<style>
	.profession-header-mobile {
		margin-bottom: 1em;
		width: 100%;
		border-bottom: 2px solid;
    	border-color: rgba(117, 148, 127, 0.24);
    	padding: 1em .5em;
    	color: #f8f8f8;
    	text-align: center;
	}

	.profession-header-mobile a {
		color: #f8f8f8;
		display: flex;
		align-items: center;
		justify-content: center;
	}

	.profession-header-mobile h2 {
		margin: 0;
	}

	.profession-header-mobile img {
	    width: 40px;
	    height: 40px;
    	border-radius: 2px;
    	margin-right: .5em;
	}
</style>

<script>
    export default {
        data () {
            return {
                Store
            }
        },

        computed: {
			coverBackground () {
	        	if (Store.profession.color == 'Red') {
	        		return '#9a4e4e'
	        	} else if (Store.profession.color == 'Blue') {
	        		return '#5487d4'
	        	} else if (Store.profession.color == 'Dark Blue') {
	        		return '#2f3b49'
	        	} else if (Store.profession.color == 'Dark Green') {
	        		return '#507e75'
	        	} else if (Store.profession.color == 'Bright Green') {
	        		return 'rgb(117, 148, 127)'
	        	} else if (Store.profession.color == 'Purple') {
	        		return '#4d4261'
	        	} else if (Store.profession.color == 'Orange') {
	        		return '#ffaf40'
	        	} else if (Store.profession.color == 'Pink') {
	        		return '#ec7daa'
	        	} else { // userStore.color == 'Black'
	        		return '#333'
	        	}
	        }
        },
    };
</script>
