document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector(".form");

    form.addEventListener("submit", (event) => {
        // Obtener valores de los campos
        const code = document.getElementById("code").value.trim();
        const height = parseFloat(document.getElementById("height").value);
        const width = parseFloat(document.getElementById("width").value);
        const length = parseFloat(document.getElementById("length").value);
        const weight = parseFloat(document.getElementById("weight").value);
        const packageQuantity = parseInt(document.getElementById("package_quantity").value);
        const zone = document.getElementById("zone").value;
        const tag = document.getElementById("tag options").value;

        let isValid = true;
        let errors = [];

        // Validar campo "Code"
        if (code === "" || code.length > 5) {
            isValid = false;
            errors.push("Code is required and must not exceed 5 characters.");
        }

        // Validar campos de medidas
        if (isNaN(height) || height <= 0) {
            isValid = false;
            errors.push("Height must be a positive number.");
        }

        if (isNaN(width) || width <= 0) {
            isValid = false;
            errors.push("Width must be a positive number.");
        }

        if (isNaN(length) || length <= 0) {
            isValid = false;
            errors.push("Length must be a positive number.");
        }

        if (isNaN(weight) || weight <= 0) {
            isValid = false;
            errors.push("Weight must be a positive number.");
        }

        // Validar campo "Package Quantity"
        if (isNaN(packageQuantity) || packageQuantity <= 0) {
            isValid = false;
            errors.push("Package quantity must be a positive integer.");
        }

        // Validar "Zone" y "Tag"
        if (zone === "") {
            isValid = false;
            errors.push("Please select a valid zone.");
        }

        if (tag === "") {
            isValid = false;
            errors.push("Please select a valid tag.");
        }

        // Mostrar errores si hay alguno
        if (!isValid) {
            event.preventDefault(); // Evita que se envíe el formulario
            alert("Validation Errors:\n" + errors.join("\n"));
        }
    });
});
