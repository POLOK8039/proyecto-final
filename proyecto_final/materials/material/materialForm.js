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
    

    function validateMaterialName(field) {
        if (field.value.trim() === "") return false;
        if (field.value.length > 50) {
            alert("The material name must not exceed 50 characters.");
            field.focus();
            return false;
        }
        return true;
    }

    function validateDescription(field) {
        if (field.value.trim() === "") return false;
        if (field.value.length > 255) {
            alert("The description must not exceed 255 characters.");
            field.focus();
            return false;
        }
        return true;
    }

    function validateQuantity(field) {
        const value = field.value.trim();
        if (value === "") return false;
        if (isNaN(value) || value < 0) {
            alert("The quantity must be a valid number and cannot be less than 0.");
            field.focus();
            return false;
        }
        return true;
    }

    function validateUnitOfMeasure(field) {
        if (field.value.trim() === "") return false;
        return true; 
    }

    form.addEventListener("submit", (event) => {
        // Validate code
        const code = document.getElementById("code");
        if (!validateCode(code)) {
            event.preventDefault();
            return;
        }

        // Validate material name
        const materialName = document.getElementById("material_name");
        if (!validateMaterialName(materialName)) {
            event.preventDefault();
            return;
        }

        // Validate description
        const description = document.getElementById("description");
        if (!validateDescription(description)) {
            event.preventDefault();
            return;
        }

        // Validate available quantity
        const availableQuantity = document.getElementById("available_quantity");
        if (!validateQuantity(availableQuantity)) {
            event.preventDefault();
            return;
        }

        // Validate unit of measure
        const unitOfMeasure = document.getElementById("unit_of_measure");
        if (!validateUnitOfMeasure(unitOfMeasure)) {
            event.preventDefault();
            return;
        }
    });
});
