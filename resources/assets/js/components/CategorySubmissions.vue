<template>
	<div class="col-7 padding-bottom-10">
		<submission :list="submission" v-for="submission in uniqueList" v-bind:key="submission.id" :in-viewport-once="true" :in-viewport-offset="0"></submission>

		<no-content v-if="nothingFound" :text="'Oooops, I hate to say it but there are no submissions to show you here'"></no-content>

		<loading v-if="loading"></loading>

		<no-more-items :text="'No more items to load'" v-if="NoMoreItems && !nothingFound && !loading"></no-more-items>
	</div>
</template>

<script>
import Submission from '../components/Submission.vue';
import Loading from '../components/Loading.vue';
import NoContent from '../components/NoContent.vue';
import NoMoreItems from '../components/NoMoreItems.vue';
import Helpers from '../mixins/Helpers';



export default {
	mixins: [
        Helpers
    ],

    components: {
        Submission,
        Loading,
        NoContent,
		NoMoreItems
    },

    data: function () {
        return {
			NoMoreItems: false,
			nothingFound: false,
        	Store,
        	preload,
            submissions: [],
            loading: true,
			page: 0,

            // lazyImages
        }
    },

   	created () {
		this.clear()
        // this.vm.$on('scrolled', this.scroll)
		this.vm.$on('scrolled-to-bottom', this.loadMore)
		this.vm.$on('refresh-category-submissions', this.clear)
   	},

    watch: {
		'$route': function () {
			this.clear()
		},


	},

	computed: {
		/**
    	 * the sort of the page
    	 *
    	 * @return string
    	 */
    	sort() {
    	    if (this.$route.query.sort == 'new')
    	    	return 'new';

    	    if (this.$route.query.sort == 'relevant')
    	    	return 'relevant';

    	    return 'hot';
    	},

		/**
		 * Due to the issue with duplicate notifiactions (cuz the present ones have diffrent
		 * timestamps) we need a different approch to make sure the list is always unique.
		 * This ugly coded methods does it! Maybe move this to the Helpers.js mixin?!
		 *
		 * @return array
		 */
		uniqueList() {
			let unique = []
			let temp = []

			this.submissions.forEach(function(element, index, self) {
				if (temp.indexOf(element.id) === -1) {
					unique.push(element)
					temp.push(element.id)
				}
			})

			return unique
		}
	},


    methods: {

        // scroll () {

        //     console.log('scrolling')
        // },

        // processLazy(){
        //     console.log("processLazy");

        //     this.lazyImages = Array.prototype.slice.call(document.getElementsByClassName("lazy"));

        //     console.log(this.lazyImages);
        // },


		loadMore () {
            console.log('loadMore')
			if (Store.contentRouter == 'content' && !this.loading && !this.NoMoreItems) {
				this.getSubmissions();
			}
		},

        /**
    	 * Sets the data to the default, also runs the basic methods.
    	 * ( use case: When we are going to use both created() and watch() )
    	 *
    	 * @return void
    	 */
    	clear () {

            this.submissions = []
            this.loading = true
            this.nothingFound = false
            this.NoMoreItems = false
			this.page = 0


    		this.updateCategoryStore()
	        this.getSubmissions()
    	},

    	/**
    	 * Checks wheather or not the categoryStore needs to be filled or updated, and if yes simply does it
    	 *
    	 * @return void
    	 */
    	updateCategoryStore () {


            // console.log(Store.category);

            // this.$root.getCategoryStore(this.$route.params.name)


            console.log(Store.category);

    		if (Store.category.name == undefined || Store.category.name != this.$route.params.name) {
	    		this.$root.getCategoryStore(this.$route.params.name)
    		}
    	},

    	getSubmissions () {
			this.page ++
            this.loading = true

            // if landed on a category page
        	if (preload.submissions && this.page == 1) {
        		this.submissions = preload.submissions.data;

				if (!this.submissions.length) {
					this.nothingFound = true
				}

				if (preload.submissions.next_page_url == null) {
					this.NoMoreItems = true
				}

				this.loading = false;

                // this.processLazy();

				// clear the preload
				delete preload.submissions;

				return;
        	}


            axios.get(this.authUrl('category-submissions'), {
            	params: {
			    	sort: this.sort,
	                page: this.page,
	                category: this.$route.params.name,
                    // category_id: Store.category.id
			    }
            }).then((response) => {
				this.submissions = [...this.submissions, ...response.data.data]

				if (!this.submissions.length) {
					this.nothingFound = true
				}

				if (response.data.next_page_url == null) {
					this.NoMoreItems = true
				}

				this.loading = false

                // this.processLazy();

            });
        }
    }
};
</script>
