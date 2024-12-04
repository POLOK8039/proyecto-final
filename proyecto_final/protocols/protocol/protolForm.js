document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector(".form");


    function validateText(field, maxLength) {
        if (field.value.trim() === "" || field.value.trim().length > maxLength) {
            alert(`${field.name.charAt(0).toUpperCase() + field.name.slice(1)} must not be empty and must be less than ${maxLength} characters.`);
            field.focus();
            return false;
        }
        return true;
    }


    function validateFile(field) {
        if (!field.files || field.files.length === 0) {
            alert("Please upload a PDF file.");
            field.focus();
            return false;
        }

        const file = field.files[0];
        const allowedExtensions = /(\.pdf)$/i;
        if (!allowedExtensions.test(file.name)) {
            alert("Only PDF files are allowed.");
            field.focus();
            return false;
        }
        return true;
    }

    form.addEventListener("submit", (event) => {
        const nameField = document.getElementById("name");
        const pdfField = document.getElementById("pdf");

        if (!validateText(nameField, 50) || !validateFile(pdfField)) {
            event.preventDefault(); 
        }
    });
});
