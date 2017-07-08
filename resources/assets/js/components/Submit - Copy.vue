<template>
   aaaaaaaaaaaaaaaaaaaaaaaaaa11111111111111111111111111
</template>

<script>
    import Markdown from '../components/Markdown.vue'
    import Multiselect from 'vue-multiselect'
    import MoonLoader from '../components/MoonLoader.vue'


    export default {

       components: {
            Multiselect,
            MoonLoader,
            Markdown
        },

        data () {
            return {

                Store,

            }
        },

        computed: {

        	goodToGo() {
                return true;// (this.fTitle.trim().length > 7 && this.selectedCat && !this.loading && !this.uploading )
            },

        },

        created () {
            // this.setDefaultCategories()
            // this.submitApi()
        },

		mounted: function () {

		},

        watch: {

        },

        methods: {


        },
    }
</script>

