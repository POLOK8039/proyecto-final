document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector("form");

   
    function validateDate(field) {
        const value = field.value;
        const currentDate = new Date().toISOString().split('T')[0];
        if (value < currentDate) {
            alert("The date cannot be in the past.");
            field.focus();
            return false;
        }
        return true;
    }

    function validateTagType(field) {
        if (field.value.trim() == "") {
            alert("Please select a tag type.");
            field.focus();
            return false;
        }
        return true; 
    }

    function validateDestination(field) {
        const value = field.value.trim();
        if (value.length > 100) {
            alert("Destination must not exceed 100 characters.");
            field.focus();
            return false;
        }
        return true;
    }

    form.addEventListener("submit", (event) => {

        const date = document.getElementById("date");
        if (!validateDate(date)) {
            event.preventDefault();
            return;
        }


        const tagType = document.getElementById("tag_type");
        if (!validateTagType(tagType)) {
            event.preventDefault();
            return;
        }

        const destination = document.getElementById("destination");
        if (!validateDestination(destination)) {
            event.preventDefault();
            return;
        }
    });
});
