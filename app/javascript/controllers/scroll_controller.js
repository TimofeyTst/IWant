import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    /* On connect */
    connect () {
        console.log("Connected");
        const messages = document.getElementById("messages")
        messages.addEventListener("DOMNodeInserted", this.resetScroll);
        this.resetScroll(messages);
    }
    
    /* On disconnect */
    disconnect () {
        console.log("Disonnected");
    }

    resetScroll() {
        messages.scrollTop = messages.scrollHeight - messages.clientHeight;
    }
} 