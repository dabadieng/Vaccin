<?php
require "../_include/inc_config.php";

?>
<!DOCTYPE html>
<html>

<head>
    <?php require "../_include/inc_head.php" ?>
</head>

<body>
    <header>
        <?php require "../_include/inc_entete.php" ?>
    </header>
    <nav>
        <?php require "../_include/inc_menu.php"; ?>
    </nav>
    <div id="contenu">
        <pre>
        <?php
        //liste des tables simples
        $table=["enfants"=>1000,"centre"=>3,"specialite"=>20,"ecole"=>5,"vaccin"=>3];
        foreach($table as $t=>$nbt) {
            $data=[];
            $sql = "insert into $t values ";
            for ($i=1; $i<=$nbt; $i++) {
                $nom="$t $i";
                $data[]="(null,'$nom')";
            }
            $link->query($sql . implode(",",$data));      
            echo "<h3>Génération des données de $t</h3>";
        } 
        
		$data=[];
        $sql = "insert into medecin values ";
        for($i=1;$i<=10; $i++) {
            $centre=rand(1,$table["centre"]);
            $data[]="(null,'medecin $i',$centre)";
        }
        $link->query($sql . implode(",",$data));      
        echo "<h3>Génération des médecin</h3>";


        //pour chaque médecin entre 0 et 3 spécialités
        echo "<h3>Génération des possede</h3>";
        $spe=range(1,$table["specialite"]);
        $data=[];
        $sql = "insert into possede values ";
        for($i=1;$i<=10; $i++) {
            $nbspe=rand(0,3);           
            shuffle($spe);
            for($j=1; $j<=$nbspe; $j++) {
                $data[]="(null,$i,$spe[$j])";
            }            
        }       
        $link->query($sql . implode(",",$data));      
        
        //pour chaque ecole, pour chaque année,  entre 0 et 2 médecins
        echo "<h3>Génération des affecter</h3>";
        $med=range(1,10);
        $data=[];
        $sql = "insert into affecter values ";
        for($i=1;$i<=$table["ecole"]; $i++) {
            for($annee=2016;$annee<=2019; $annee++) {               
                $nbmed=rand(0,2);                  
                shuffle($med);
                for($j=1; $j<=$nbmed; $j++) {
                    $data[]="(null,$med[$j],$i,$annee)";
                }     
            }       
        }
        $link->query($sql . implode(",",$data));   

        //tout au hasard : date de 2016 à 2019=>3 ans, 1000 enfants, ===> 3000 vaccinations
        echo "<h3>Génération des vaccination</h3>";
        $data=[];
        $sql = "insert into traiter values ";
        for($i=0;$i<3000; $i++) {
            $tra_vaccin=rand(1,$table["vaccin"]);
	        $tra_date=date("Y-m-d",mktime(0,0,0,rand(1,12),rand(1,30),rand(2016,2019)));
	        $tra_medecin=rand(1,10);
	        $tra_enfant=rand(1,$table["enfants"]);
			$data[]="(null,$tra_vaccin,'$tra_date',$tra_medecin,$tra_enfant)";
        }
        $link->query($sql . implode(",",$data));   

        ?>
        </pre>
    </div>
    <hr>
    <footer>
        <?php require "../_include/inc_pied.php"; ?>
    </footer>
</body>

</html>