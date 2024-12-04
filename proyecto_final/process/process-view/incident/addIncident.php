<?php
    require "reportFun.php";
    session_start();
    if ($_SERVER['REQUEST_METHOD']=='POST'){
        $date = $_POST['date'];
        $description = $_POST['description'];
        $traceability = $_POST['traceability'];

        $result = addIncident(date: $date, description: $description, traceability: $traceability);
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
        header("Location: index.php");
        exit();
    }
?>

    <main class="forms">
        <div class="background">
            <form class="form" action="?a=add" method="post" autocomplete="off">
                <header class="header">
                    <img src="<?php  echo SVG . "icon.svg" ?>">
                    <h1>Add Report</h1>
                </header>
                <hr>
                <h2>Incident</h2>
                <div class="rows">
                    <div class="row-md-5">
                        <h4>Date</h4>
                        <div class="inputs">
                            <input type="date" required placeholder="">
                        </div>
                    </div>
                    <div class="row-md-5">
                        <h4>Trazability</h4>
                        <div class="inputs">
                            <input type="text" value="<?php echo $_SESSION['trac']?>" required readonly>
                        </div>
                    </div>
                    <div class="row-lg-12">
                        <h4>Description</h4>
                        <div class="inputs">
                            <textarea type="text" required placeholder="" ></textarea>
                        </div>
                    </div>
                </div>
                <hr>
                <footer class="footer">
                    <button class="btn-primary" type="submit">Confirm Registration</button>
                </footer>
            </form>
        </div>
    </main>
    <?php include FOOT ?>