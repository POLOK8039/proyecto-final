<?php
    require "reportFun.php";
    $incidents = getIncident();
?>

<main class="tables">
<div class="background">
<?php 
    $link="?a=add";
    include HEADER;
?>
    <h1>Incidents</h1>
    <table class="table">
        <thead>
            <tr>
                <th>
                    <span>Num</span>
                    <span class="column-order"></span>
                </th>
                <th>
                    <span>Date</span>
                    <span class="column-order"></span>
                </th>
                <th>
                    <span>Description</span>
                    <span class="column-order"></span>
                </th>
                <th>
                    <span>Traceability</span>
                    <span class="column-order"></span>
                </th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($incidents as $incident): ?>
            <tr>
                <td><?php echo $incident['num']; ?></td>
                <td><?php echo $incident['date']; ?></td>
                <td><?php echo $incident['description']; ?></td>
                <td><?php echo $incident['traceability']?></td>
                <?php if(validateUser("ADMIN", "SUPER")): ?>
                <td>
                    <a class="btn" href="?a=edit&num=<?php echo $incident['num']; ?>">Edit</a>
                </td>
                <?php endif; ?>
            </tr>
            <?php endforeach; ?>
        </tbody>
        <tfoot>
            <tr>
                <th>
                    <span>Num</span>
                </th>
                <th>
                    <span>Date</span>
                </th>
                <th>
                    <span>Description</span>
                </th>
                <th>
                    <span>Traceability</span>
                </th>
            </tr>
        </tfoot>
    </table>
