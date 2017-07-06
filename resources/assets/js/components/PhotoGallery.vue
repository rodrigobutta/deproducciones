<template>
    <div class="photo-gallery-wrapper user-select">

        <div id="loading-wrapper" v-if="loading && isAlbum">
            <moon-loader :loading="loading && isAlbum" :size="'50px'" :color="'#777'" class="form-loader"></moon-loader>
        </div>

        <div class="photo-wrapper" v-if="!isAlbum">
            <img :src="list.thumbnail_path">
        </div>

        <!-- <div class="photo-album-wrapper" v-if="isAlbum && !loading"> -->
        <div class="photo-album-wrapper" v-if="!loading">
            <img v-bind:src="value.thumbnail_path" v-for="(value, index) in list" @click="$emit('zoom', index)" class="big-thumbnail" />
        </div>


    </div>
</template>

<style media="screen">
    .photo-gallery-wrapper #loading-wrapper {
        position: relative;
        height: 100%;
    }

    .opacity-fade {
        opacity: 0.6;
    }

    .photo-gallery-wrapper .form-loader {
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
            'list'
        ],

        data: function () {
            return {
                loading: false,
                photos: []
            }
        },

        computed: {
            isAlbum(){
                return this.list.length > 1
            },

        },

        created () {
            // if (this.isAlbum) {
            //     this.getPhotos()
            // }

            console.log(this.list);
        },

        mounted: function() {
            this.$nextTick(function() {
                this.$root.loadSemanticTooltip()
            })
        },

        methods: {


         //    getPhotos: function () {
         //        this.loading = true

        	// 	axios.get('/submission-photos', {
        	// 		params: {
        	// 			id: this.list.id
        	// 		}
        	// 	} ).then((response) => {
         //            this.photos = response.data
         //            this.currentPhoto = this.photos[this.counter].path
         //            this.loading = false
         //        });
        	// },


        }
    };
</script>
