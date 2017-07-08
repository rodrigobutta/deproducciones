<template>
    <section class="container margin-top-5 col-7 user-select" id="new-submission">
        <moon-loader :loading="loading" :size="'40px'" :color="'#38634f'" class="form-loader"></moon-loader>

        <div :class="loading ? 'opacity-fade' : ''">
            <h1 class="align-center">
                New Submission
            </h1>

            <div class="v-status v-status--error" v-if="customError">
                {{ customError }}
            </div>

            <form action="/submit" method="post">
                <div class="form-group relative">

                    <input type="text" class="form-control v-input-big" v-bind:class="{ 'btn-input-text': submissionType == 'link'}"
                    id="title" name="title" placeholder="Title ..." autocomplete="off" v-model="fTitle" :disabled="loading">

                  <!--   <button type="button" class="v-button v-button--primary btn-input" @click="getTitle(submitURL)"
                    v-if="submissionType == 'link' && submitURL && !loadingTitle"
                            data-toggle="tooltip" data-placement="bottom" title="Fetch title from entered URL" :disabled="loading"
                    >Suggest</button>
 -->
                    <!-- <moon-loader :loading="loadingTitle" :size="'30px'" :color="'#777'" class="btn-input"></moon-loader> -->

                    <small class="text-muted go-red" v-for="e in errors.title">{{ e }}</small>
                </div>

                <input type="hidden" name="type" v-bind:value="submissionType">

                <!-- <div v-show="submissionType == 'text'"> -->
                    <textarea class="form-control v-input-big" rows="3" id="text" name="text" placeholder="Text(optional)..."
                    v-model="fText" :disabled="loading"></textarea>

                    <div class="flex-space">
                        <a class="comment-form-guide text-muted" @click="vm.$emit('markdown-guide')">
        	            	Formatting Guide
        	            </a>

                        <a class="comment-form-guide text-muted" @click="preview = !preview" v-show="fText">
        	            	Preview
        	            </a>
                    </div>


                    <small class="text-muted go-red" v-for="e in errors.text">{{ e }}</small>
                <!-- </div> -->

                <div v-if="preview && fText" class="form-wrapper">
                    <markdown :text="fText"></markdown>
              	</div>


                <div class="form-group" >
                    <multiselect v-model="tags" tag-placeholder="Add this as new tag" placeholder="Search or add a tag" label="name" :options="suggestedTags" :multiple="true" :taggable="true" @tag="addTag"></multiselect>
                    <pre class="language-json"><code>{{ tags  }}</code></pre>
                </div>

                <div class="form-group" >
                    <form action="/upload-photo" class="dropzone" method="post" id="addPhotosForm">
                        <input type="hidden" name="_token" v-bind:value="csrf">
                        <div class="fallback">
                            <input name="photo" type="file" multiple />
                        </div>
                    </form>
                    <small class="text-muted go-red" v-for="e in errors.photos">{{ e }}</small>
                </div>

                <div class="form-group">
                    <multiselect :value="selectedCat" :options="suggestedCats" @input="updateSelected" @search-change="getSuggestedCats" :placeholder="'#channel...'"></multiselect>
                    <small class="text-muted go-red" v-for="e in errors.name">{{ e }}</small>
                </div>

                <hr class="dashed-hr">

                <div class="form-group">
                    <submission-form-wanting v-for="(row, index) in rows" :itemdata="itemList" :row="row" v-on:remove="removeRow(index)"></submission-form-wanting>
                    <pre class="language-json"><code>{{ rows  }}</code></pre>
                </div>


                <button type="button" class="v-button v-button--green pull-right" @click="addRow">Add</button>

                <hr class="dashed-hr">


                <div class="flex-space">

                    <button type="submit" class="v-button v-button--green pull-right" @click="submit" :disabled="!goodToGo">
                        Submit
                    </button>
                </div>

            </form>
        </div>
    </section>
</template>

<script>
    import Markdown from '../components/Markdown.vue'
    import Multiselect from 'vue-multiselect'
    import MoonLoader from '../components/MoonLoader.vue'
    import SubmissionFormWanting from '../components/SubmissionFormWanting.vue'

    window.Dropzone = require('../libs/dropzone')
    Dropzone.autoDiscover = false

    export default {

       components: {
            Multiselect,
            MoonLoader,
            Markdown,
            SubmissionFormWanting
        },

        data () {
            return {
                // loadingTitle: false,
                fTitle: '',
                preview: false,
                fText: '',
                tags: [],
                suggestedTags :[],
                // submitURL: '',
                photo: '',
                errors: [],
                customError: '',
                csrf: window.Laravel.csrfToken,
                loading: false,
                uploading: false,
                selectedCat: null,
                suggestedCats :[],
                submissionType: 'wanted',
                photos: [],
                Store,

                rows: [],
                itemList: [
                    { code: 'Select an Item', description: '', unitprice: ''},
                    { code: 'One', description: 'Item A', unitprice: '10'},
                    { code: 'Two', description: 'Item B', unitprice: '22'},
                    { code: 'Three', description: 'Item C', unitprice: '56'}
                ]


                // gifUploadFormData: new FormData()
            }
        },

        computed: {

        	goodToGo() {
                return (this.fTitle.trim().length > 7 && this.selectedCat && !this.loading && !this.uploading )
            },

        },

        created () {
            this.setDefaultCategories()
            this.submitApi()

            this.loadSuggestedTags()
        },

		mounted: function () {

			this.$nextTick(function () {

				this.$root.loadSemanticTooltip()
				this.loadDropzone()
				this.$root.autoResize()

                var that = this

                this.dropzone.on('addedfile', function (file) {
                    that.uploading = true
                })

                this.dropzone.on('complete', function (file) {
                    if (this.getUploadingFiles().length === 0 && this.getQueuedFiles().length === 0) {
                        that.uploading = false;
                    }
                })

			})
		},

        watch: {
            'Store.subscribedCategories': function () {
                this.setDefaultCategories()
            }
        },

        methods: {

           addRow(){
             this.rows.push({profession: '', description: '', unitprice: ''}); // what to push unto the rows array?
          },
          removeRow(index){
             this.rows.splice(index,1); // why is this removing only the last row?
          },


            /**
             * Used for setting the values using API. This will get extended in the future to support
             * voten sharing buttons! But for now we are just going to use it for setting the default
             * channel so when clicked on submit in the channels, users won't have to set channel.
             *
             * @return
             */
            submitApi() {
                if (this.$route.query.channel) {
                    this.selectedCat = this.$route.query.channel
                }
            },

            /**
             * Sets the default value for suggestCats (uses user's already subscriber channels)
             *
             * @return void
             */
            setDefaultCategories(){
                let array = []

                Store.subscribedCategories.forEach(function(element, index) {
                    array.push(element.name)
                })

                this.suggestedCats = array
            },



            addTag (newTag) {
                  const tag = {
                    name: newTag,
                    code: newTag.substring(0, 2) + Math.floor((Math.random() * 10000000))
                  }
                  this.suggestedTags.push(tag)
                  this.tags.push(tag)
            },

            loadSuggestedTags(){

                var options = [
                        { name: 'Vue.js', code: 'vu' },
                        { name: 'Javascript', code: 'js' },
                        { name: 'Monterail', code: 'pl' },
                        { name: 'Open Source', code: 'os' }
                      ]

                this.suggestedTags = options
            },

            // used for multi select
            updateSelected(newSelected) {
                this.selectedCat = newSelected
            },

        	loadDropzone() {

                var that = this
                this.dropzone = new Dropzone(".dropzone", {
                    paramName: 'photo',
                    maxFileSize: 10,
                    acceptedFiles: '.jpg, .jpeg, .png',
                    success: function(file, data) {
                        console.log('success');
                        that.photos.push(data)
                    }
                })


            },

        	submit(e) {
                e.preventDefault()

        		this.loading = true;

                // rest of the types
                axios.post( '/submit', {
                    title: this.fTitle,
                    // url: this.submitURL,
                    text: this.fText,
                    category_name: this.selectedCat,
                    type: this.submissionType,
                    photos: this.photos,
                }).then((response) => {
                    // success
                    this.errors = []

        			Store.submissionUpVotes.push(response.data.id)

                    this.$router.push('/c/' + this.selectedCat + '/' + response.data.slug)

					this.loading = false
                }, (error) => {
                    // error
                    if(error.response.status == 500){
                        this.customError = error.response.data
                        this.errors = []
                        this.loading = false
                        return
                    }

                    this.errors = error.response.data
                    this.loading = false
                })
            },

            // getTitle(typed){
            //     if(!typed) return

            //     this.loadingTitle = true

            //     axios.get('/fetch-url-title', {
            //     	params: {
            //     		url: typed
            //     	}
            //     }).then((response) => {
            //         this.fTitle = response.data;
            //         this.loadingTitle = false
            //         this.errors.url = []
            //     }).catch((error) => {
            //         if (error.response.status == 500) {
            //             this.customError = error.response.data
            //             this.errors = []
            //             this.loadingTitle = false
            //             return
            //         }

            //         this.errors = error.response.data
            //         this.loadingTitle = false
            //     });
            // },

            getSuggestedCats: _.debounce(function (typed) {
                if(!typed) return

                axios.get( '/get-categories', {
                	params: {
                		name: typed
                	}
                }).then((response) => {
                    this.suggestedCats = response.data
                })
            }, 600),

        },
    }
</script>

