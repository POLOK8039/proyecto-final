    <aside class="sidebar">
        <ul class="navegation">
            <li>
                <a class="nav-link" href="<?php echo URL . "#" ?>" tooltip="Home">
                    <img class="bi" src="<?php echo SVG . "home.svg" ?>">
                </a>
            </li>
            <li>
                <a class="nav-link" href="<?php echo URL . "boxes/" ?>" tooltip="Boxes">
                    <img class="bi" src="<?php echo SVG . "boxes.svg" ?>">
                </a>
            </li>
            <?php if(validateUser("ADMIN", "SUPER")): ?>
            <li>
                <a class="nav-link" href="<?php echo URL . "materials/" ?>" tooltip="Materials">
                    <img class="bi" src="<?php echo SVG . "materials.svg" ?>">
                </a>
            </li>
            <?php endif; ?>
            <li>
                <a class="nav-link" href="<?php echo URL . "process/" ?>" tooltip="Process">
                    <img class="bi" src="<?php echo SVG . "process.svg" ?>">
                </a>
            </li>
            <li>
                <a class="nav-link" href="<?php echo URL . "products/" ?>" tooltip="Products">
                    <img class="bi" src="<?php echo SVG . "products.svg" ?>">
                </a>
            </li>
            <li>
                <a class="nav-link" href="<?php echo URL . "protocols/" ?>" tooltip="Protocols">
                    <img class="bi" src="<?php echo SVG . "protocols.svg" ?>">
                </a>
            </li>
            <?php if(validateUser("ADMIN")): ?>
            <li>
                <a class="nav-link" href="<?php echo URL . "users/" ?>" tooltip="Users">
                    <img class="bi" src="<?php echo SVG . "users.svg" ?>">
                </a>
            </li>
            <?php endif; ?>
        </ul>
        <a href="#" class="link-body " id="profile-toggle">
            <img class="bi" src="<?php echo SVG . "user.svg" ?>">
        </a>
        <ul class="dropdown-menu" id="dropdown-menu">
            <li style="border-bottom: none">
                <a href="<?php echo URL . "?a=logout" ?>">Logout</a>
            </li>
        </ul>
    </aside>