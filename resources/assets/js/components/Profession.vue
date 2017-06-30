<template>
	<section>
		<profession-header v-if="loaded"></profession-header>

		<nsfw-warning v-if="nsfw"
			:text="'This channel contains NSFW content which can not be displayed according to your personal settings.'">
		</nsfw-warning>

		<router-view v-else></router-view>
	</section>
</template>

<script>

import ProfessionHeader from '../components/ProfessionHeader.vue';
import NsfwWarning from '../components/NsfwWarning.vue';
import ProfessionSubmissions from '../components/ProfessionSubmissions.vue';
import Helpers from '../mixins/Helpers';

export default {
	mixins: [Helpers],

    components: {
        ProfessionSubmissions,
        ProfessionHeader,
		NsfwWarning
    },

    data () {
        return {
        	Store,
			auth
        }
    },

   	created () {
   		this.updateProfessionStore();
   		this.setPageTitle('#' + this.$route.params.slug);
   	},

    watch: {
		'$route': function () {
			this.updateProfessionStore();
		}
	},

   	computed: {
		nsfw(){
			return Store.profession.nsfw && !auth.nsfw;
		},

   		/**
		 * Are we good to go (Dsiplay header)
   		 *
   		 * @return Boolean
   		 */
        loaded () {
            return Store.profession.slug == this.$route.params.slug;
        }
    },

    methods: {
    	/**
    	 * Checks wheather or not the professionStore needs to be filled or updated, and if yes simply does it
    	 *
    	 * @return void
    	 */
    	updateProfessionStore () {

    		if (Store.profession.slug == undefined || Store.profession.slug != this.$route.params.slug) {
	    		this.$root.getProfessionStore(this.$route.params.slug);
    		}

    	},
    }
}
</script>
