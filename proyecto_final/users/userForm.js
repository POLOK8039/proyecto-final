document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector("form");

    function validateName(field) {
        if (field.value.trim() === "") return true;
        const regex = /^[A-Za-zÀ-ÿ\s]+$/;
        if (!regex.test(field.value.trim())) {
            alert("The name must contain only letters, including accented characters.");
            field.focus();
            return false;
        }
        return true;
    }

    function validateDate(field) {
        if (field.value.trim() === "") return true;
        const date = new Date(field.value);
        const today = new Date();
        const eighteenYearsAgo = new Date(today.getFullYear() - 18, today.getMonth(), today.getDate());
        const fiftyYearsAgo = new Date(today.getFullYear() - 100, today.getMonth(), today.getDate());

        if (isNaN(date.getTime()) || date > eighteenYearsAgo || date < fiftyYearsAgo) {
            alert("The date of birth must be valid, between 18 and 50 years old.");
            field.focus();
            return false;
        }
        return true;
    }

    function validateEmail(field) {
        if (field.value.trim() === "") return true;
        const regex = /^[^\s@]+@[^\s@]+\.(com|edu|org|net|gov|int|mil|co)$/;
        if (!regex.test(field.value.trim())) {
            alert("Please enter a valid email address with a valid extension (e.g., .com, .edu, .org).");
            field.focus();
            return false;
        }
        return true;
    }

    function validatePhone(field) {
        if (field.value.trim() === "") return true;
        const value = field.value.trim();
        const regexFormat = /^(\d{3}[-\s]?\d{3}[-\s]?\d{4})$/;
        const digitsOnly = value.replace(/[-\s]/g, "");
        if (digitsOnly.length !== 10) {
            alert("The phone number must contain exactly 10 digits.");
            field.focus();
            return false;
        }
        if (!regexFormat.test(value)) {
            alert("Please enter a valid phone number (e.g., 664-121-1212, 664 121 1212, or 6641211212).");
            field.focus();
            return false;
        }
        return true;
    }

    function validatePassword(field) {
        if (field.value.trim() === "") return true;
        const regex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
        if (!regex.test(field.value.trim())) {
            alert("The password must have at least 8 characters, including letters and numbers.");
            field.focus();
            return false;
        }
        return true;
    }

    function validatePostalCode(field) {
        if (field.value.trim() === "") return true;
        const regex = /^\d{5}$/;
        if (!regex.test(field.value.trim())) {
            alert("The postal code must contain exactly 5 numeric characters.");
            field.focus();
            return false;
        }
        return true;
    }

    form.addEventListener("submit", (event) => {
        const name = document.getElementById("name");
        if (!validateName(name)) {
            event.preventDefault();
            return;
        }

        const firstSurname = document.getElementById("first_surname");
        if (!validateName(firstSurname)) {
            event.preventDefault();
            return;
        }

        const secondSurname = document.getElementById("second_surname");
        if (secondSurname.value.trim() !== "" && !validateName(secondSurname)) {
            event.preventDefault();
            return;
        }

        const date = document.getElementById("date");
        if (!validateDate(date)) {
            event.preventDefault();
            return;
        }

        const email = document.getElementById("email");
        if (!validateEmail(email)) {
            event.preventDefault();
            return;
        }

        const phone = document.getElementById("phone");
        if (!validatePhone(phone)) {
            event.preventDefault();
            return;
        }

        const password = document.getElementById("password");
        if (!validatePassword(password)) {
            event.preventDefault();
            return;
        }

        const postalCode = document.getElementById("postal-code");
        if (!validatePostalCode(postalCode)) {
            event.preventDefault();
            return;
        }
    });
});