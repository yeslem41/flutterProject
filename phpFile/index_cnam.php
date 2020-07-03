<?php 

/*try{
$pdo = new PDO("mysql:host=localhost;dbname=id12941217_macnam","id12941217_weddou","lXn\>8Y-/O\~G5%$");
$pdo->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
}catch(PDOException $e){
	echo $e->getMessage();
	die("could not connected");
}*/
$array = array();
$mysqli = New mysqli("localhost","id12941217_weddou","lXn\>8Y-/O\~G5%$","id12941217_macnam");

   if(isset($_GET['NIN']) && $_GET['NIN']){
	     $sql = "SELECT `INAM` FROM `d_dossier` WHERE `numCin`='{$_GET['NIN']}' OR `INAM`='{$_GET['NIN']}'";
	    $result = $mysqli->query($sql);
	    $recunni = $result->fetch_assoc()['INAM'];
	    if($result->num_rows>0){
	     $sqlLogin = "SELECT `id` FROM `loginTable` WHERE `recunni`='$recunni'";
	     $res  = $mysqli->query($sqlLogin);
         if($res->num_rows>0){
        	         $sql = "UPDATE `loginTable` SET `loged`='true' WHERE `recunni`='$recunni'";
        	         $result = $mysqli->query($sql);
        	         if($result)
        	             	array_push($array,array("id"=>$recunni));
	     }else{
        	     $sqlogin = "INSERT INTO `loginTable`(`recunni`,`loged`) VALUES('$recunni','true')";
        	    $resulogin = $mysqli->query($sqlogin);
        	     if($resulogin)
        	       	array_push($array,array("id"=>$recunni)); 
	     }
	    }else
            array_push($array,array("noBody"=>"yes"));
		die(json_encode($array));
		}
		
		if(isset($_GET['logeout']) && $_GET['logeout'] && isset($_GET['recunni'])&&$_GET['recunni']){
		    $sqlLogin = "SELECT `id` FROM `loginTable` WHERE `recunni`='{$_GET['recunni']}'";
		    $resultlog = $mysqli->query($sqlLogin);
		    if($resultlog->num_rows>0){
	     $sql = "UPDATE `loginTable` SET `loged`='false' WHERE `recunni`='{$_GET['recunni']}'";
	    $result = $mysqli->query($sql);
		if($result){
			array_push($array,array("logeout"=>'true'));
          	}else{
          	array_push($array,array("logeout"=>'false'));
          	}
		    }else{
		   array_push($array,array("logeout"=>'false'));
		    }
        die(json_encode($array));
		}
		
        echo json_encode(["error"=>'error service']);

?>