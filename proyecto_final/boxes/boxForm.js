document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector("form");

    
    function validatePositiveNumber(field) {
        const value = parseFloat(field.value.trim());
        if (isNaN(value) || value <= 0) {
            alert(`${field.name.charAt(0).toUpperCase() + field.name.slice(1)} must be a positive number.`);
            field.focus();
            return false;
        }
        return true;
    }

    form.addEventListener("submit", (event) => {

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
    });
});

