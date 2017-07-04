<template>
	<div>
		<user-header v-if="loaded"></user-header>

		<router-view></router-view>
	</div>
</template>

<script>
import UserHeader from '../components/UserHeader.vue'

export default {
    components: {
    	UserHeader
    },

    data () {
    	return {
    		Store
    	}
    },

    created () {
    	this.updateUserStore()
    },

    watch: {
    	'$route': function () {
    		this.updateUserStore()
    	}
    },

    methods: {
    	/**
    	 * Checks if the Store.user is filled with right info, if it's not fetches the right ones
    	 *
    	 * @return void
    	 */
    	updateUserStore () {
        	this.$root.getUserStore()
    	}
    },

    computed: {
    	loaded () {
            console.log('loaded');
            console.log(Store.user.username);
            console.log(this.$route.params.username);


    		return Store.user.username == this.$route.params.username
    	}
    }
}
</script>
