import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    toggle_display(event){
        event.preventDefault();
        event.stopPropagation();
        console.log("toggled");
        document.getElementById("avatar_form").classList.toggle("d-none");
        document.getElementById("public_form").classList.toggle("d-none");
    }
} 