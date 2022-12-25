import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect () {
        const imgInp = document.getElementById("imgInp");
        imgInp.onchange = evt => {
        const [file] = imgInp.files
        if (file) {
            preview.src = URL.createObjectURL(file)
        }
        }
    }
} 