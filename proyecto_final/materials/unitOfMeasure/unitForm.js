document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector("form");

    function validateCode(field) {
        const value = field.value.trim();
        const regex = /^[A-Za-z0-9]{1,5}$/; 
        if (!regex.test(value)) {
            alert("The code must be between 1 and 5 alphanumeric characters.");
            field.focus();
            return false;
        }
        return true;
    }

    function validateDescription(field) {
        const value = field.value.trim();
        if (value.length > 50) {
            alert("Description must not exceed 50 characters.");
            field.focus();
            return false;
        }
        return true;
    }

    form.addEventListener("submit", (event) => {
        
        const code = document.getElementById("code");
        if (!validateCode(code)) {
            event.preventDefault();
            return;
        }

    
        const description = document.getElementById("description");
        if (!validateDescription(description)) {
            event.preventDefault();
            return;
        }
    });
});
