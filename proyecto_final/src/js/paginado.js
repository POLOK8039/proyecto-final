
const SVG = "/src/svg/";

document.addEventListener('DOMContentLoaded', function () {
    const rowsPerPage = 10; 
    const table = document.querySelector('table'); 
    const rows = table.querySelectorAll('tbody tr');
    const footer = document.querySelector('.footer'); 
    const totalPages = Math.ceil(rows.length / rowsPerPage);

    let currentPage = 1;

    function renderTable() {
        
        rows.forEach((row) => {
            row.style.display = 'none';
        });

       
        const start = (currentPage - 1) * rowsPerPage;
        const end = start + rowsPerPage;

       
        rows.forEach((row, index) => {
            if (index >= start && index < end) {
                row.style.display = '';
            }
        });

      
        updateFooter();
    }

    function updateFooter() {
        footer.innerHTML = `
            <ul>
                <li>
                    <a href="#" class="prev ${currentPage === 1 ? 'disabled' : ''}">
                        <img class="bi" src="${SVG}chevron-left.svg" alt="Previous">
                    </a>
                </li>
                <li>
                    <span>${currentPage} of ${totalPages}</span>
                </li>
                <li>
                    <a href="#" class="next ${currentPage === totalPages ? 'disabled' : ''}">
                        <img class="bi" src="${SVG}chevron-right.svg" alt="Next">
                    </a>
                </li>
            </ul>
        `;

        attachPaginationEvents();
    }

    function attachPaginationEvents() {
        const prevButton = footer.querySelector('.prev');
        const nextButton = footer.querySelector('.next');

        if (prevButton) {
            prevButton.addEventListener('click', (e) => {
                e.preventDefault();
                if (currentPage > 1) {
                    currentPage--;
                    renderTable();
                }
            });
        }

        if (nextButton) {
            nextButton.addEventListener('click', (e) => {
                e.preventDefault();
                if (currentPage < totalPages) {
                    currentPage++;
                    renderTable();
                }
            });
        }
    }

    if (rows.length > 0) {
        renderTable();
    } else {
        footer.innerHTML = '<p>No data available</p>';
    }
});