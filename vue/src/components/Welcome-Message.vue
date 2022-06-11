<template>
    <div id="welcome">
        <h3>Welcome {{getUserName}}! Let's find you a cold one!</h3>
    </div>
</template>

<script>


export default({
    setup() {},
    computed: {
        getUserName() {
            return this.$store.state.user.username
        },
    },
})
</script>

<style scoped>
#welcome {
    display: flex;
    border: solid black 1px;
    border-top-right-radius: 25px;
    border-top-left-radius: 25px;
    padding: 5px;
    background-image: linear-gradient(to bottom right, rgb(247, 223, 195), rgb(255, 145, 0));
    align-items: center;
    justify-content: center;
    font-family: tangerine;
    font-style: italic;
}
</style>
