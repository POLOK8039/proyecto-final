    <main class="home">
        <ul class="navegation">
            <li>
                <a class="nav-link" href="<?php echo URL . "boxes/" ?>">
                    <img class="bi" src="<?php echo SVG . "boxes.svg" ?>">
                    <h2>Boxes</h2>
                </a>
            </li>
            <?php if(validateUser("ADMIN", "SUPER")): ?>
            <li>
                <a class="nav-link" href="<?php echo URL . "materials/" ?>">
                    <img class="bi" src="<?php echo SVG . "materials.svg" ?>">
                    <h2>Materials</h2>
                </a>
            </li>
            <?php endif; ?>
            <li>
                <a class="nav-link" href="<?php echo URL . "process/" ?>">
                    <img class="bi" src="<?php echo SVG . "process.svg" ?>">
                    <h2>Process</h2>
                </a>
            </li>
        </ul>
        <ul class="navegation">
            <li>
                <a class="nav-link" href="<?php echo URL . "products/" ?>">
                    <img class="bi" src="<?php echo SVG . "products.svg" ?>">
                    <h2>Products</h2>
                </a>
            </li>
            <li>
                <a class="nav-link" href="<?php echo URL . "protocols/" ?>">
                    <img class="bi" src="<?php echo SVG . "protocols.svg" ?>">
                    <h2>Protocols</h2>
                </a>
            </li>
            <?php if(validateUser("ADMIN","SUPER")): ?>
            <li>
                <a class="nav-link" href="<?php echo URL . "users/" ?>">
                    <img class="bi" src="<?php echo SVG . "users.svg" ?>">
                    <h2>Users</h2>
                </a>
            </li>
            <?php endif; ?>
        </ul>
    </main>