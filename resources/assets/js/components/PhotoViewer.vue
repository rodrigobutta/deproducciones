<template>
    <div class="photo-viewer-wrapper user-select">
        <div class="photo-viewer-header">
            <div class="flex-display">


                <!-- <div class="counter-wrapper" v-if="isAlbum">
                    {{ this.counter + 1 }} / {{ list.length }}
                </div> -->
            </div>

            <div>
                <i class="v-icon pointer v-cancel margin-right-1" aria-hidden="true" @click="$emit('close')"
                    data-toggle="tooltip" data-placement="bottom" title="Close (esc)"
                ></i>
            </div>
        </div>

        <div class="photo-wrapper" v-if="!isAlbum">
            <img :src="list[0].path"  @click="$emit('close')">
        </div>

        <div id="loading-wrapper" v-if="loading && isAlbum">
            <moon-loader :loading="loading && isAlbum" :size="'50px'" :color="'#777'" class="form-loader"></moon-loader>
        </div>

        <div class="photo-viewer" v-if="isAlbum && !loading">
            <i class="v-icon pointer v-previous gallery-button desktop-only" aria-hidden="true" @click="previous" :class="counter > 0 ? '' : 'display-hidden'"></i>

            <img :src="currentPhoto" @click="$emit('close')" v-if="!loading">

            <i class="v-icon pointer v-next gallery-button desktop-only" aria-hidden="true" @click="next" :class="counter < (list.length - 1) ? '' : 'display-hidden'"></i>
        </div>

        <div class="flex-space" v-if="!loading && isAlbum">
            <button class="v-button" :class="counter > 0 ? '' : 'display-hidden'" @click="previous">
                Previous
            </button>

            <button class="v-button" :class="counter < (list.length - 1) ? '' : 'display-hidden'" @click="next">
                Next
            </button>
        </div>
    </div>
</template>

<style media="screen">
    .photo-viewer-wrapper #loading-wrapper {
        position: relative;
        height: 100%;
    }

    .opacity-fade {
        opacity: 0.6;
    }

    .photo-viewer-wrapper .form-loader {
        position: absolute;
        top: 42%;
        left: 50%;
        z-index: 100;
    }

    .form-loader .v-moon1 {
        height: 60px !important;
        width: 60px !important;
    }

    .form-loader .v-moon2 {
        height: 5.28571px !important;
        width: 5.28571px !important;
        border-radius: 100% !important;
        top: 25.8571px !important;
        opacity: 1 !important;
        background-color: #333 !important;
    }

    .form-loader .v-moon3 {
        height: 60px !important;
        width: 60px !important;
        opacity: 0.2 !important;
        border: 5.71429px solid #000 !important;
    }
</style>


<script>

    import MoonLoader from '../components/MoonLoader.vue'

    import Helpers from '../mixins/Helpers'

    export default {
        components: {MoonLoader},

        mixins: [Helpers],

        props: [
            'list', 'photoindex'
        ],

        data: function () {
            return {
                loading: false,
                photos: [],
                currentPhoto: null,
                counter: 0
            }
        },

        computed: {
            isAlbum(){

                // console.log(this.list);

                // return this.list.data.album
                return this.list.length > 1
            },

            date () {
                return moment(this.list.created_at).utc(moment().format("Z")).fromNow()
            },
        },

        created () {

            // console.log(this.list);

            this.currentPhoto = this.list[this.photoindex].path

            this.setCounter()

            window.addEventListener('keyup', this.keyup)

        },

        mounted: function() {
            this.$nextTick(function() {
                this.$root.loadSemanticTooltip()
            })
        },

        methods: {
            setCounter(){
                if (this.photoindex) this.counter = this.photoindex
            },

            keyup(event){
                // right
                if (event.keyCode == 39) {
                    this.next()
                }

                // left
                if (event.keyCode == 37) {
                    this.previous()
                }

                // esc
                if (event.keyCode == 27) {
                    this.$emit('close')
                }
            },

            previous(){
                if (this.counter > 0) {
                    this.counter --
                    // this.currentPhoto = this.list[this.counter].path
                    this.loadPhoto(this.list[this.counter].path);
                }
            },

            next(){
                if (this.counter < (this.list.length - 1)) {
                    this.counter ++
                    this.loadPhoto(this.list[this.counter].path)
                    // this.currentPhoto = this.list[this.counter].path
                }
            },


            loadPhoto(photo){

                this.loading = true;

                var img, that;
               img = new Image();
               that = this;

               img.onload = function(){
                that.currentPhoto = photo
                    that.loading = false;
               }
               img.src = photo;


            }
        }
    };
</script>
