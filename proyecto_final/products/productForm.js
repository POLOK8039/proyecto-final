document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector(".form");

 
    function validateText(field, maxLength) {
        if (field.value.trim() === "" || field.value.trim().length > maxLength) {
            alert(`${field.name.charAt(0).toUpperCase() + field.name.slice(1)} must not be empty and less than ${maxLength} characters.`);
            field.focus();
            return false;
        }
        return true;
    }

    function validatePositiveNumber(field) {
        const value = parseFloat(field.value.trim());
        if (isNaN(value) || value <= 0) {
            alert(`${field.name.charAt(0).toUpperCase() + field.name.slice(1)} must be a positive number.`);
            field.focus();
            return false;
        }
        return true;
    }

    function validateSelect(field) {
        if (field.value.trim() === "") {
            alert(`Please select a valid ${field.name.charAt(0).toUpperCase() + field.name.slice(1)}.`);
            field.focus();
            return false;
        }
        return true;
    }

    
    form.addEventListener("submit", (event) => {
        
        const code = document.getElementById("code");
        if (!validateText(code, 5)) {
            event.preventDefault();
            return;
        }

        
        const name = document.getElementById("name");
        if (!validateText(name, 50)) {
            event.preventDefault();
            return;
        }

        
        const description = document.getElementById("description");
        if (!validateText(description, 255)) {
            event.preventDefault();
            return;
        }

    
        const height = document.getElementById("height");
        if (!validatePositiveNumber(height)) {
            event.preventDefault();
            return;
        }

        
        const width = document.getElementById("width");
        if (!validatePositiveNumber(width)) {
            event.preventDefault();
            return;
        }

        
        const length = document.getElementById("length");
        if (!validatePositiveNumber(length)) {
            event.preventDefault();
            return;
        }

        
        const weight = document.getElementById("weight");
        if (!validatePositiveNumber(weight)) {
            event.preventDefault();
            return;
        }


        const packagingProtocol = document.getElementById("packaging_protocol options");
        if (!validateSelect(packagingProtocol)) {
            event.preventDefault();
            return;
        }
    });
});
