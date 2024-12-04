<?php
    if(!validateUser("ADMIN","SUPER")){
        header("Location: /reports/");//verificar desde donde es
        exit;
    }
    require "reportFun.php";

    $traceabilities = getTraceabilities();

    if ($_SERVER['REQUEST_METHOD']=='POST') {

        $start_date = $_POST['start_date'];
        $end_date = $_POST['end_date'];
        $report_date = $_POST['report_date'];
        $packed_products = $_POST['packed_products'];
        $observations = $_POST['observations'];
        $traceability = $_POST['traceability'];

        $result = addReport(
            start_date:$start_date, end_date:$end_date, report_date:$report_date, packed_products:$packed_products, observations:$observations, traceability:$traceability
        );

        if($result){
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
        header("Location: /process/reports/");
        exit();
    }
?>
<head>
    <script src="reportForm.js"></script>
</head>

<main class="forms">
    
    <div class="background">
        <form class="form" action="" method="post" autocomplete="off">
            <header class="header">
                <img src="<?php  echo SVG . "icon.svg" ?>">
                <h1>Add reports</h1>
            </header>
            <hr>
            <h2>Reports</h2>
            <div class="rows">

                <div class="row-md-5">
                    <h4 for="start_date">start_date</h4>
                    <div class="inputs">
                        <input name="start_date" id="start_date" type="date" placeholder="2024-11-20" required maxlength="50">
                    </div>
                </div>

                <div class="row-md-5">
                    <h4 for="end_date">End date</h4>
                    <div class="inputs">
                        <input name="end_date" id="end_date" type="date" placeholder="2024-11-25" required maxlength="50">
                    </div>
                </div>

                <div class="row-md-5">
                    <h4 for="report_date">Report date</h4>
                    <div class="inputs">
                        <input name="report_date" id="report_date" type="date" placeholder="2024-11-24" required maxlength="50">
                    </div>
                </div>

                <div class="row-md-5">
                    <h4 for="packed_product">Packed Product</h4>
                    <div class="inputs">
                        <input name="packed_products" id="packed_products" type="number" placeholder="17" required>
                    </div>
                </div>

                <div class="row-md-5">
                    <h4 for="observations">Observations</h4>
                    <div class="inputs">
                        <input name="observations" id="observations" type="text" placeholder="Your observations" required maxlength="50">
                    </div>
                </div>

                <div class="row-md-5">
                    <h4 for="traceability">Traceability packaging</h4>
                    <div class="inputs">
                        <select class="input" required name="traceability" id="traceability options">
                            <?php 
                                while ($traceability = mysqli_fetch_assoc($traceabilities)):   
                                    echo "<option value='{$traceability['num']}'>{$traceability['packaging']}</option>";
                                endwhile; 
                            ?>
                        </select>
                    </div>
                </div>

            </div>
            <hr>
            <footer class="footer">
                <button class="btn-primary" type="submit">Confirm</button>
            </footer>
        </form>
    </div>
</main>
<script>
        setTimeout(() => {
            const successMsg = document.getElementById('success-msg');
            const errorMsg = document.getElementById('error-msg');
            if (successMsg) successMsg.style.display = 'none';
            if (errorMsg) errorMsg.style.display = 'none';
        }, 3000);
</script>