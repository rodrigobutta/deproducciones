<template>
    <div class="photo-gallery-wrapper user-select">

        <div id="loading-wrapper" v-if="loading && isAlbum">
            <moon-loader :loading="loading && isAlbum" :size="'50px'" :color="'#777'" class="form-loader"></moon-loader>
        </div>

        <div class="photo-gallery" :columns="columns" v-if="!loading">
            <img v-bind:class="{ lazy: !value.isLazyLoaded }" v-bind:src="value.blurry_path" v-for="(value, index) in list" @click="showPhotoViewer(index)" :width="value.thumbnail_width" :height="value.thumbnail_height"/>
        </div>

        <photo-viewer v-if="photoViewer" @close="closeViwer" :list="list" :photoindex="photoViewerIndex"></photo-viewer>

    </div>
</template>

<script>

    import MoonLoader from '../components/MoonLoader.vue';
    import PhotoViewer from '../components/PhotoViewer.vue';

    import Helpers from '../mixins/Helpers'

    import inViewport from 'vue-in-viewport-mixin';


    export default {
        components: {
            MoonLoader,
            PhotoViewer
        },

        mixins: [
            Helpers,
            inViewport
        ],

        props: [
            'list'
        ],

        data: function () {
            return {
                loading: false,
                photos: [],
                photoViewerIndex: null,
                photoViewer: false,
                columns: 1,
                lazyLoaded: false
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

            for (var i = 0; i < this.list.length; i++) {
                this.list[i].isLazyLoaded = false
            };



            this.columns = 1;
            if(this.list.length>2){
                this.columns = 2;
            }
            if(this.list.length>5){
                this.columns = 3;
            }

            this.vm.$on('photo-viewer', this.showPhotoViewer)
            this.vm.$on('scape', this.closeViwer)

            this.vm.$on('in-viewport', this.inViewport)

            // console.log(this.list);
        },

        mounted: function() {

            this.$nextTick(function() {
                this.$root.loadSemanticTooltip()
            })


        },

        watch: {

            'inViewport.now': function(visible) {
                if(visible){
                    // this.vm.$emit('in-viewport')

                    if(!this.lazyLoaded){
                        this.lazyLoad();
                    }

                }
            }
        },


        methods: {

            lazyLoad(){
                console.log('lazyLoad');
                this.lazyLoaded = true;

                var ii = 0;
                for (var i = 0; i < this.list.length; i++) {

                    var img, that;
                    img = new Image();
                    that = this;

                    img.onload = function(nr){
                         that.list[ii].blurry_path = that.list[ii].thumbnail_path;
                         that.list[ii].isLazyLoaded = true;
                         ii++;
                    }
                    img.src = this.list[i].thumbnail_path;

                };

            },

            showPhotoViewer(index = null){

                if (index !== null) {
                    this.photoViewerIndex = index
                }
                this.photoViewer = true
            },

            closeViwer(){
                this.photoViewer = false
            },

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
