const App = Vue.createApp({
    data() {
        return {
            list: [],
            playerName: ""
        }
    },
    methods: {
        close() {
            fetch(`https://${GetParentResourceName()}/exit`);
        },
        handleKeyDown(event) {
            if (event.key === "Escape") {
                this.close();
            }
        },
        selectJob(job) {
            fetch(`https://${GetParentResourceName()}/setJob`, {
                method: "POST",
                body: JSON.stringify({
                    job: job
                })
            });
        },

    },
    mounted() {

        var _this = this;
        window.addEventListener('message', function (event) {
            if (event.data.type == "show") {
                if (event.data.enable) {
                    document.body.style.display = "block";
                    document.getElementById('app').style.animation = "hopin 0.6s";
                }
                else {
                    document.getElementById('app').style.animation = "hopout 0.6s";
                    setTimeout(() => {
                        document.body.style.display = "none";
                    }, 600);
                }
            } else if (event.data.type == "set") {
                _this.list = event.data.list;
                _this.playerName = event.data.playerName;

            }
        });
        window.addEventListener('keydown', this.handleKeyDown);

    }
}).mount('#app');