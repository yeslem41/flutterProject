<?php

$mysqli = New mysqli("localhost","id12941217_weddou","lXn\>8Y-/O\~G5%$","id12941217_macnam");
     $array = array();
if(isset($_POST['body']) && $_POST['body'] && isset($_POST['recu']) && $_POST['recu']){
    $body = $_POST['body'];
    $recu = $_POST['recu'];
    $time = time();
    $query = "INSERT INTO `inquiry`(`body`,`recu`,`time`) VALUES('$body','$recu','$time')";
    $result = $mysqli->query($query);
    if($result)
         array_push($array,array('success'=>'true','desc'=>'we hope you receive response very sonn'));
    else
         array_push($array,array('success'=>'false','desc'=>'error of service try again'));
        
}else
   array_push($array,array('success'=>'false','desc'=>'infos not completed'));

   echo json_encode($array);
?>