        <header class="header">
            <div class="search-container">
            <!-- <form action="" autocomplete="off"> -->
                    <input type="search" class="search" placeholder="Search: Press Ente" autocomplete="off">
                <!-- </form> -->
            </div>
            <?php if(validateUser("ADMIN", "SUPER") || strtok($_SERVER["REQUEST_URI"], '?') == "/process/process-view/"):?>
            <ul>
                <a class="btn" href="?a=add">
                    <p>Add</p>
                </a>
            </ul>
            <?php endif;?>
        </header>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const searchInput = document.querySelector('.search');
        const tables = document.querySelectorAll('.tables'); // Selecciona todos los contenedores de tablas

        searchInput.addEventListener('input', () => {
            const filterText = searchInput.value.toLowerCase();
            tables.forEach(table => {
                const tableBody = table.querySelector('table tbody'); // Encuentra el tbody de la tabla
                if (tableBody) {
                    Array.from(tableBody.getElementsByTagName('tr')).forEach(row => {
                        const cells = row.getElementsByTagName('td');
                        const match = Array.from(cells).some(cell => 
                            cell.textContent.toLowerCase().includes(filterText)
                        );
                        row.style.display = match ? '' : 'none'; // Muestra/oculta la fila
                    });
                }
            });
        });
    });
</script>