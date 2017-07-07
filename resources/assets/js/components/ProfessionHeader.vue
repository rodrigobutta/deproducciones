<template>
<div>
	<div v-bind:style="{ background: coverBackground }" class="profile-cover">
	    <div class="container padding-top-3 user-select full-width">
	        <div class="cols-flex">
	            <div class="profession-header-left">
            	<!-- avatar -->

    				<router-link :to="'/p/' + Store.profession.name">
	                    <img v-bind:src="Store.profession.avatar" v-bind:alt="Store.profession.name" />
                	</router-link>

	                <!-- end avatar -->
	            </div>

	            <div class="profession-header-middle">

                    <h1 v-if="$route.name == 'profession'">
        				<router-link :to="'/p/' + Store.profession.slug" class="flex-center-inline">
	                        {{ Store.profession.title }}
	                	</router-link>
                    </h1>
                    <h2 v-else>
        				<router-link :to="'/p/' + Store.profession.slug" class="flex-center-inline">
	                        {{ Store.profession.title }}
	                	</router-link>
                    </h2>

	                <p>
	                    {{ Store.profession.description }}
	                </p>

					<span class="inline-block">
						<i class="v-icon v-submissions" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Submissions"></i>{{ Store.profession.stats.submissionsCount }}
					</span>
                    <span class="inline-block">
                        <i class="v-icon v-people" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Users"></i>{{ Store.profession.stats.usersCount }}
                    </span>

	            </div>

	        </div>
	    </div>
	</div>

	<nav class="nav has-shadow user-select">
	    <div class="container">
	        <div class="nav-left">
	        	<router-link :to="{ path: '/p/' + $route.params.name }" class="nav-item is-tab" :class="{ 'is-active': sort == 'hot' }">
					Hot
				</router-link>

				<router-link :to="{ path: '/p/' + $route.params.name + '?sort=new' }" class="nav-item is-tab" :class="{ 'is-active': sort == 'new' }">
					New
				</router-link>

				<router-link :to="{ path: '/p/' + $route.params.name + '?sort=relevant'  }" class="nav-item is-tab" :class="{ 'is-active': sort == 'relevant' }">
					Relevant
				</router-link>
	        </div>

	        <div class="channel-admin-btn">
	        	<i class="v-icon h-yellow pointer" :class="bookmarked ? 'go-yellow v-unbookmark' : 'v-bookmark'" @click="bookmark"
	        	data-toggle="tooltip" data-placement="bottom" title="Bookmark"></i>

				<div class="ui icon top right green pointing dropdown" data-toggle="tooltip" data-placement="bottom" title="More">
					<i class="v-icon v-more" aria-hidden="true"></i>

					<div class="menu">
						<button class="item" @click="emitModerators">
							Opcion 1
						</button>

						<button class="item" @click="emitRules">
							Opcion 2
						</button>
					</div>
				</div>



            	<button class="v-button desktop-only" @click="submitButton">
            		Submit
            	</button>

            	<subscribe v-if="!isGuest"></subscribe>
	        </div>
	    </div>
	</nav>
</div>
</template>

<script>
import Subscribe from '../components/ProfessionSubscribeButton.vue'
import Helpers from '../mixins/Helpers';

export default {
	mixins: [Helpers],

    components: {
    	Subscribe
    },

    data: function () {
        return {
    		fileUploadFormData: new FormData(),
        	Store,
        	bookmarked: false
        }
    },

    created () {
    	this.setBookmarked()
    },

	mounted () {
		this.$nextTick(function () {
        	this.$root.loadSemanticTooltip()
        	this.$root.loadSemanticDropdown()
		})
	},

    methods: {
    	submitButton() {
    	    if (this.isGuest) {
    	    	this.mustBeLogin();
    	    	return;
    	    }

    	    this.$router.push('/submit?channel=' + this.$route.params.name);
    	},

		emitRules(){
			this.vm.$emit('rules')
		},

		emitModerators() {
			this.vm.$emit('moderators')
		},


    	/**
		 * Passes the photo to the cropModal to take care of the rest
		 *
		 * @return void
		 */
		passToCropModal (e)
		{

            this.fileUploadFormData.append('photo', e.target.files[0]);

    		axios.post('/upload-temp-avatar', this.fileUploadFormData).then((response) => {
				this.vm.$emit('crop-photo-uploaded', response.data)
            });

    		this.vm.$emit('crop-profession-photo')
		},

    	/**
         *  Whether or not user has bookmarked the submission
         *
         *  @return Boolean
         */
        setBookmarked () { if ( Store.professionBookmarks.indexOf(Store.profession.id) != -1 ) this.bookmarked = true },

        /**
         *  Toggles the profession into bookmarks
         */
    	bookmark (profession) {
    		if (this.isGuest) {
        		this.mustBeLogin();
        		return;
        	}

    		this.bookmarked = !this.bookmarked

			axios.post('/bookmark-profession', {
				id: Store.profession.id
			}).then((response) => {
				if (Store.professionBookmarks.indexOf(Store.profession.id) != -1){
                	var index = Store.professionBookmarks.indexOf(Store.profession.id)
                	Store.professionBookmarks.splice(index, 1)

                	return
                }
				Store.professionBookmarks.push(Store.profession.id)
			})
    	},
    },

    computed: {
    	/**
    	 * the sort of the page
    	 *
    	 * @return mixed
    	 */
    	sort() {
    		if (this.$route.name != 'profession-submissions')
    			return null;

    	    if (this.$route.query.sort == 'new')
    	    	return 'new';

    	    if (this.$route.query.sort == 'relevant')
    	    	return 'relevant';

    	    return 'hot';
    	},

    	date () {
    		return moment(Store.profession.created_at).utc(moment().format("MMM Do")).format("MMM Do")
    	},

    	isModerator () {
    		return Store.moderatingAt.indexOf(Store.profession.id) != -1
    	},

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
    }
}
</script>
