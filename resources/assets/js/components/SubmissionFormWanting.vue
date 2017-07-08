<template>
   <div>
        <multiselect  :value="row.profession" :options="suggestedProfessions" :custom-label="professionSelectCustomLabel" @input="updateSelected" @search-change="getSuggestedProfessions" :placeholder="'profession..'" label="title" track-by="slug"></multiselect>

        <textarea class="form-control v-input-big" v-model="row.description" rows="3" id="text" name="text" placeholder="description.." ></textarea>
         <!--   <select v-model="row.code">
               <option v-for="item in itemdata"  :value="item"> {{ item.code }} </option>
           </select> -->
           <!-- <input type="text" placeholder="Text" v-model="row.description" class="form-control v-input-big"> -->
           <input type="text" placeholder="value" v-model="row.unitprice" class="form-control v-input-big">
           <button type="button" class="v-button v-button--red pull-right" v-on:click= "remove"> X </button>
       </div>
</template>

<script>
    import Markdown from '../components/Markdown.vue'
    import Multiselect from 'vue-multiselect'
    import MoonLoader from '../components/MoonLoader.vue'

    export default {

       components: {
            Multiselect,
            MoonLoader,
            Markdown,
        },

        props: ['itemdata', 'row'],

        data () {
            return {
                selected: this.itemdata[0],

                // selectedProfession: null,
                suggestedProfessions :[],

            }
        },

        computed: {

        },

        created () {
            // this.setDefaultProfessions()
            this.submitApi()
        },

        mounted: function () {
            this.$emit("wanting-created", this.$data);

        },

        watch: {

        },

        methods: {


            remove() {
               this.$emit('remove');
            },

            submitApi() {
                if (this.$route.query.channel) {
                    this.row.type = this.$route.query.channel
                }
            },

           //  setDefaultProfessions(){
           //     let array = []

           //     Store.subscribedProfessions.forEach(function(element, index) {
           //         array.push(element.name)
           //     })

           //     this.suggestedProfessions = array
           // },

           updateSelected(newSelected) {
               this.row.profession = newSelected
           },

           getSuggestedProfessions: _.debounce(function (typed) {
               if(!typed) return

               axios.get( '/get-professions', {
                params: {
                    name: typed
                }
               }).then((response) => {

                    console.log(response.data)
                   this.suggestedProfessions = response.data
               })
           }, 600),


           professionSelectCustomLabel ({ slug, title }) {
            // return `${slug} — [${title}]`
            return `${title}`
          },

        },
    }
</script>

