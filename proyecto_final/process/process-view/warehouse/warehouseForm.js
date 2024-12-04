
document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector("form");

    // Validation functions
    function validateCode(field) {
        const value = field.value.trim();
        if (value === "") return false;
        const regex = /^[A-Za-z0-9]{5}$/;
        if (value.length !== 5 || !regex.test(value)) {
            alert("The code must be exactly 5 alphanumeric characters.");
            field.focus();
            return false;
        }
        return true;
    }

    function validateArea(field) {
        const value = field.value.trim();
        if (value === "") return false;
        if (value.length > 50) {
            alert("The area must not exceed 50 characters.");
            field.focus();
            return false;
        }
        return true;
    }

    function validateCapacity(field) {
        const value = field.value.trim();
        if (value === "" || isNaN(value) || value < 0) {
            alert("The capacity must be a valid number and cannot be less than 0.");
            field.focus();
            return false;
        }
        return true;
    }

    form.addEventListener("submit", (event) => {
        // Validate code
        const code = document.getElementById("code");
        if (!validateCode(code)) {
            event.preventDefault();
            return;
        }

        // Validate area
        const area = document.getElementById("area");
        if (!validateArea(area)) {
            event.preventDefault();
            return;
        }

        // Validate available capacity
        const availableCapacity = document.getElementById("description");
        if (!validateCapacity(availableCapacity)) {
            event.preventDefault();
            return;
        }

        // Validate total capacity
        const totalCapacity = document.getElementById("available_quantity");
        if (!validateCapacity(totalCapacity)) {
            event.preventDefault();
            return;
        }
    });
});