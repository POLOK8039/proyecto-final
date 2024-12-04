<?php
    require_once("../../../config.php");
    require "outFun.php";
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
    if (isset($_GET['num'])) {
        $num = $_GET['num'];
        $out = getOutboundByNum($num);
        $dateOutbound = getOutboundDateByNum($num);
    
        if (!$out) {
            echo "Out not found";
            exit;
        }
    } else {
        echo "Outbound number not specified.";
        exit;
    }

    if ($_SERVER['REQUEST_METHOD']=='POST') {
        $num = $_POST['num'];
        $date = $_POST['date'];
        $selected_packaging = $_POST['packaging'] ?? [];
        $active = 1;

        $today = date('Y-m-d');
        if ($date < $today) {
            $_SESSION['message'] = [
                'text' => 'Date cannot be in the past.',
                'type' => 'error'
            ];
            header("Location: /process/warehouse/outbound");
            exit();
        }
    
        if ($result = updateOutbound(num: $num, date: $date, packaging: $selected_packaging)) {
            updatePackagingStatus($selected_packaging, $num);
        
            $_SESSION['message'] = [
                'text' => 'Successful registration',
                'type' => 'success'
            ];
        } else {
            $_SESSION['message'] = [
                'text' => 'Error',
                'type' => 'error'
            ];
        }
        header("Location: /process/warehouse/outbound");
    }
?>

<main class="forms">
    <div class="background">
        <form class="form" action="" method="post" autocomplete="off">
            <header class="header">
                <img src="<?php echo SVG . "icon.svg" ?>">
                <h1>Edit Outbound</h1>
            </header>
            <hr>
            <h2>Outbound</h2>
            <div class="rows">
                <div class="row-sm-3">
                    <h4 for="num">Num</h4>
                    <div class="inputs">
                        <input name="num" id="num" type="number" required value="<?php echo $num; ?>" readonly>
                    </div>
                </div>
                <div class="row-sm-3">
                    <h4 for="date">Date</h4>
                    <div class="inputs">
                        <input name="date" id="date" type="date" required value="<?php echo $dateOutbound; ?>">
                    </div>
                </div>
            </div>

            <div class="rows">
                <h4>Edit Packaging by Zone</h4>
                <?php
                $zones = getZones();
                if (!empty($zones)) {
                    foreach ($zones as $zone) {
                        echo "<div class='zone'>";
                        echo "<h5>Zone: " . htmlspecialchars($zone) . " <button type='button' class='select-all' data-zone='" . htmlspecialchars($zone) . "'>Select All</button></h5>";
                        $packaging = getEditablePackagingByZoneAndOutbound($zone, $num);
                        if (!empty($packaging)) {
                            echo "<div class='packaging-list' id='zone-" . htmlspecialchars($zone) . "'>";
                            foreach ($packaging as $pkg) {
                                $isSelected = $pkg['outbound'] == $num ? 'checked' : '';
                                echo "<label>
                                        <input type='checkbox' name='packaging[]' value='" . htmlspecialchars($pkg['num']) . "' class='zone-" . htmlspecialchars($zone) . "' $isSelected>
                                        Packaging Quantity: " . htmlspecialchars($pkg['package_quantity']) . "
                                    </label><br>";
                            }
                    
                            echo "</div>";
                        } else {
                            echo "<p>No packaging available in this zone.</p>";
                        }
                    
                        echo "</div>";
                    }
                }
                ?>
            </div>

            <script>
                document.querySelectorAll('.select-all').forEach(button => {
                    button.addEventListener('click', function() {
                        const zone = this.getAttribute('data-zone');
                        const checkboxes = document.querySelectorAll('.zone-' + zone);
                        
                        const allChecked = Array.from(checkboxes).every(checkbox => checkbox.checked);
                        
                        if (allChecked) {
                            checkboxes.forEach(checkbox => {
                                checkbox.checked = false;
                            });
                            this.textContent = 'Select All';
                        } else {
                            checkboxes.forEach(checkbox => {
                                checkbox.checked = true;
                            });
                            this.textContent = 'Deselect All';
                        }
                    });
                });
            </script>

            <hr>
            <footer class="footer">
                <button class="btn-primary" type="submit">Update</button>
            </footer>
        </form>
    </div>
</main>