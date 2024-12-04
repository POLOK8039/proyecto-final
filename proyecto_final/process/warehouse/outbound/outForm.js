document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector(".form");

    function showError(message) {
        alert(message);
    }

    function isValidDate(date) {
        return /^\d{4}-\d{2}-\d{2}$/.test(date);
    }

    function validateDate(field) {
        const dateValue = field.value;
        if (!dateValue) {
            showError(`${field.name} is required.`);
            field.focus();
            return false;
        }

        if (!isValidDate(dateValue)) {
            showError(`${field.name} must be in YYYY-MM-DD format.`);
            field.focus();
            return false;
        }

        const selectedDate = new Date(dateValue).getTime(); 
        const today = new Date();
        today.setHours(0, 0, 0, 0); 
        const todayTime = today.getTime();

        if (selectedDate < todayTime) {
            showError(`${field.name} cannot be in the past.`);
            field.focus();
            return false;
        }

        return true;
    }

    function validatePositiveNumber(input) {
        const value = parseInt(input.value, 10);
        if (isNaN(value) || value <= 0) {
            alert("Por favor ingresa un número positivo.");
            input.value = "";
            return false;
        }
        return true;
    }
    

    const quantityField = document.getElementById("exit_quantity");
    quantityField.addEventListener("input", () => {
        const value = parseFloat(quantityField.value);
        if (value < 0) {
            quantityField.value = ""; 
            showError("Quantity cannot be negative.");
        }
    });

    form.addEventListener("submit", (event) => {
        const dateField = document.getElementById("date");

    
        if (!validateDate(dateField)) {
            event.preventDefault();
            return;
        }

        
        if (!validatePositiveNumber(quantityField)) {
            event.preventDefault();
            return;
        }
    });
});