<template>

    <div>

    <button type="submit" class="v-button v-button--green margin-top-1" @click="patch" v-show="editing">Save</button>
    <button type="submit" class="v-button v-button--red margin-top-1" @click="cancelEditing" v-show="editing">Cancel</button>

        <div v-if="full">

            <h1 class="submission-title" v-if="submission.title && !editing">
                <i class="v-icon v-shocked go-red" aria-hidden="true" v-if="submission.nsfw" data-toggle="tooltip" data-placement="bottom" title="NSFW"></i>{{ submission.title }}
            </h1>
            <textarea class="form-control v-input-big" rows="2" id="title" placeholder="Title.." v-show="editing" v-model="editedTitle"></textarea>


            <div class="form-group" v-show="editing" >
                <form action="/upload-photo" class="dropzone" method="post" id="addPhotosForm">
                    <input type="hidden" name="_token" v-bind:value="csrf">
                    <div class="fallback">
                        <input name="photo" type="file" multiple />
                    </div>
                </form>
                <small class="text-muted go-red" v-for="e in errors.photos">{{ e }}</small>
            </div>

        </div>



        <div v-if="!isAlbum && submission.thumbnail">
            <img v-bind:src="submission.thumbnail" v-bind:alt="submission.title" @click="$emit('zoom')" class="big-thumbnail"/>
        </div>
        <div v-if="isAlbum">
            <img v-bind:src="value.thumbnail" v-for="(value, index) in photos" @click="$emit('zoom', index)" v-bind:alt="submission.title" class="big-thumbnail" />
        </div>

    	<div class="link-list-info">

            <span class="submission-img-title">
                <!-- <a class="submisison-small-thumbnail" v-if="submission.thumbnail && !full">
                    <div v-if="showSmallThumbnail" class="small-thumbnail zoom-in" v-bind:style="thumbnail" @click="$emit('zoom')"></div>
                </a> -->

                <div class="flex1">


                        <!-- submission page -->
                        <div v-if="full">

                            <markdown :text="submission.body" v-if="submission.body && !editing"></markdown>

                            <textarea class="form-control v-input-big" rows="8" id="text" placeholder="Text(optional)..." v-show="editing" v-model="editedBody"></textarea>

                            <h3>Se busca</h3>

                            <ul class="menu-list">
                                <li v-for="item in submission.wants_for">

                                    <span class="v-channels-text"><strong>{{ item.title }}</strong> {{ item.pivot.description }}</span>

                                </li>
                            </ul>


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







    </div>
</template>

<script>
    import Markdown from '../../components/Markdown.vue';
	import SubmissionFooter from '../../components/SubmissionFooter.vue';
    import MoonLoader from '../../components/MoonLoader.vue'

    window.Dropzone = require('../../libs/dropzone')
    Dropzone.autoDiscover = false

    export default {
        data() {

            // console.log(this.submission.data);

            return {
                editing: false,
               // body: this.submission.data.text,
                editedBody: this.submission.body,
                editedTitle: this.submission.title,
                csrf: window.Laravel.csrfToken,
                loading: false,
                photo: '',
                errors: [],
                customError: '',
                auth,
                photos: [],
                Store,
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
                    backgroundImage: 'url(' + this.submission.thumbnail + ')'
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

            this.vm.$on('edit-submission', this.editSubmission);

            if(this.full){
                this.getPhotos()
            }

            console.log(this.submission);

            this.dropzone()

        },

		mounted () {
			this.$nextTick(function () {
	        	this.$root.loadSemanticTooltip();
	        	this.$root.autoResize();
                this.loadDropzone();
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
					text: this.editedBody,
                    title: this.editedTitle,
                    photos: this.photos
				})
				.then((response) => {

                    console.log(response.data);


					this.submission.body = this.editedBody;
                    this.submission.title = this.editedTitle;

                    this.photos = response.data;

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
				this.editedBody = this.submission.body;
                this.editedTitle = this.submission.title;
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


            dropzone() {
                var that = this
                Dropzone.options.addPhotosForm  = {
                    paramName: 'photo',
                    maxFileSize: 10,
                    // addRemoveLinks: true,
                    acceptedFiles: '.jpg, .jpeg, .png, .gif',
                    success: function(file, data) {
                        that.photos.push(data)
                    }
                }
            },

            loadDropzone() {
                $(".dropzone").dropzone()
            },

		}
    }
</script>
