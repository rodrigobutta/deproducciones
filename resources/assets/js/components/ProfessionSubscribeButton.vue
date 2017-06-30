<template>
    <button :class="activeClass" @click="subscribe" v-html="content" v-if="loaded"></button>
</template>

<script>
export default {

    data: function () {
        return {
            subscribed: false,
            loaded: false,
            Store
        }
    },

    created: function () {
        axios.get('/profession-is-subscribed', {
        	params: {
        		profession_id: Store.profession.id
        	}
        }).then((response) => {
            this.subscribed = response.data;

            this.loaded = true;
        });
    },

    computed: {
    	activeClass () {
    		if (this.subscribed) {
    			return 'v-button v-button--red'
    		}

    		if (!this.subscribed) {
    			return 'v-button v-button--green'
    		}
    	},

    	content () {
    		if ( ! this.subscribed ) {
    			return 'Join'
    		}

    		return 'Leave'
    	}
    },

    methods: {
        subscribe: function () {
            this.subscribed = ! this.subscribed

            if ( this.subscribed ) {
            	Store.subscribedProfessions.push(Store.profession)

            	Store.profession.stats.usersCount ++
            } else {
            	Store.profession.stats.usersCount --

            	let removeItem = Store.profession.id
				Store.subscribedProfessions = Store.subscribedProfessions.filter(function (profession) {
				  	return profession.id != removeItem
				})
            }

            axios.post('/profession-subscribe', {
            	profession_id: Store.profession.id
            })
        }
    }
}
</script>
