document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector(".form");

    function showError(message) {
        alert(message); 
    }

    function isValidDate(date) {

        return /^\d{4}-\d{2}-\d{2}$/.test(date);
    }

    function validatePositiveNumber(field) {
        const value = parseFloat(field.value.trim());
        if (isNaN(value) || value <= 0) {
            showError(`${field.name} must be a positive number.`);
            field.focus();
            return false;
        }
        return true;
    }

    form.addEventListener("submit", (event) => {
        const startDate = document.getElementById("start_date");
        const endDate = document.getElementById("end_date");
        const reportDate = document.getElementById("report_date");
        const packedProduct = document.getElementById("packed_products");
        const traceability = document.getElementById("traceability");


        if (!isValidDate(startDate.value)) {
            showError("Start Date must be in YYYY-MM-DD format.");
            event.preventDefault();
            return;
        }

        if (!isValidDate(endDate.value)) {
            showError("End Date must be in YYYY-MM-DD format.");
            event.preventDefault();
            return;
        }

        const start = new Date(startDate.value);
        const end = new Date(endDate.value);
        if (start > end) {
            showError("Start Date must be earlier or equal to End Date.");
            event.preventDefault();
            return;
        }


        if (!isValidDate(reportDate.value)) {
            showError("Report Date must be in YYYY-MM-DD format.");
            event.preventDefault();
            return;
        }


        const report = new Date(reportDate.value);
        if (report < start) {
            showError("Report Date must be on or after Start Date.");
            event.preventDefault();
            return;
        }


        if (!validatePositiveNumber(packedProduct)) {
            event.preventDefault();
            return;
        }

        if (!traceability.value) {
            showError("Please select a valid Traceability.");
            traceability.focus();
            event.preventDefault();
            return;
        }
    });
});
