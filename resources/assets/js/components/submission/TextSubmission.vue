<template>

    <div>

        <h1 class="submission-title"><i class="v-icon v-shocked go-red" aria-hidden="true" v-if="submission.nsfw" data-toggle="tooltip" data-placement="bottom" title="NSFW"></i>{{ submission.title }}</h1>

        <div v-if="!isAlbum && showBigThumbnail">
            <img v-bind:src="submission.data.thumbnail_path" v-bind:alt="submission.title" @click="$emit('zoom')" class="big-thumbnail"/>
        </div>

        <div v-if="isAlbum && showBigThumbnail">
            <img v-bind:src="value.thumbnail_path" v-for="(value, index) in photos"
            @click="$emit('zoom', index)" v-bind:alt="submission.title" class="margin-bottom-1" />
        </div>

    	<div class="link-list-info">

            <span class="submission-img-title">
                <a class="submisison-small-thumbnail" v-if="submission.data.thumbnail_path && !full">
                    <!-- img -->
                    <div v-if="showSmallThumbnail" class="small-thumbnail zoom-in" v-bind:style="thumbnail" @click="$emit('zoom')"></div>
                </a>

                <div class="flex1">


                        <!-- submission page -->
                        <div v-if="full">

                               <markdown :text="body" v-if="body && !editing"></markdown>
                            <textarea class="form-control v-input-big" rows="3" id="text" placeholder="Text(optional)..." v-show="editing" v-model="editedBody"></textarea>
                               <button type="submit" class="v-button v-button--green margin-top-1" @click="patch" v-show="editing">Edit</button>
                               <button type="submit" class="v-button v-button--red margin-top-1" @click="cancelEditing" v-show="editing">
                                   Cancel
                               </button>
                        </div>
                        <!-- submission indexing pages -->
                        <div v-else>
                            <router-link :to="'/c/' + submission.category.name + '/' + submission.slug" class="flex-space v-ultra-bold">{{ submission.title }}</router-link>
                            <submission-footer :url="url" :comments="comments" :bookmarked="bookmarked" :submission="submission"
                            @bookmark="$emit('bookmark')" @report="$emit('report')" @hide="$emit('hide')" @nsfw="$emit('nsfw')" @sfw="$emit('sfw')" @destroy="$emit('destroy')" @approve="$emit('approve')" @disapprove="$emit('disapprove')" @removethumbnail="$emit('removethumbnail')" :upvoted="upvoted" :downvoted="downvoted" :points="points"
                            @upvote="$emit('upvote')" @downvote="$emit('downvote')"
                            ></submission-footer>
                        </div>


                </div>
            </span>



    	</div>


        <h3>aasdsadasda</h3>


        <ul class="menu-list">
            <li v-for="item in submission.wants_for">

                    <span class="v-channels-text">{{ item.title }}</span>

            </li>
        </ul>



    </div>
</template>

<script>
    import Markdown from '../../components/Markdown.vue';
	import SubmissionFooter from '../../components/SubmissionFooter.vue';

    export default {
        data() {
            return {
                editing: false,
                body: this.submission.data.text,
                editedBody: this.submission.data.text,
                auth,
                photos: [],
            }
        },

        props: {
        	nsfw: {},
        	submission: {},
        	url: {},
        	comments: {},
        	bookmarked: {},
        	upvoted: {},
        	downvoted: {},
        	points: {},
            full: {
                type: Boolean,
                default: false,
            },
        },

        computed: {
            thumbnail() {
                return {
                    backgroundImage: 'url(' + this.submission.data.thumbnail_path + ')'
                };
            },

            isAlbum(){
                return this.photos.length > 1
            },

            showBigThumbnail(){
                if (this.full) return true

                if (this.nsfw) return false

                return ! auth.submission_small_thumbnail
            },

            showSmallThumbnail(){
                return ! this.showBigThumbnail && !this.nsfw
            }
        },

        components: {
            Markdown,
            SubmissionFooter
        },

        created() {

            this.$eventHub.$on('edit-submission', this.editSubmission);

            if(this.full){
                this.getPhotos()
            }

            console.log(this.submission);

        },

		mounted () {
			this.$nextTick(function () {
	        	this.$root.loadSemanticTooltip();
	        	this.$root.autoResize();
			})
		},

		methods: {
			/**
			 * opens the edit form
			 *
			 * @return void
			 */
			editSubmission() {
			    this.editing = !this.editing;
			},

			/**
			 * patches the TextSubmission
			 *
			 * @return void
			 */
			patch() {
				axios.post('/patch-text-submission', {
					id: this.submission.id,
					text: this.editedBody
				})
				.then((response) => {
					this.body = this.editedBody;
					this.editing = false;
				}).catch((error) => {
					this.editing = true;
				});
			},

			/**
			 * cancels editing the TextSubmission
			 *
			 * @return void
			 */
			cancelEditing() {
				this.editedBody = this.body;
			    this.editing = false;
			},

            getPhotos: function () {
                axios.get('/submission-photos', {
                    params: {
                        id: this.submission.id
                    }
                }).then((response) => {
                    this.photos = response.data
                });
            },

		}
    }
</script>
