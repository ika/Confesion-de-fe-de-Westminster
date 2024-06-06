#!/usr/bin/php
<?php

ini_set('register_argc_argv', 0);

if (!isset($argc) || is_null($argc)) {
    exit("Not in CLI mode\n");
}

//-----------------------------------------
// PHP settings
//-----------------------------------------
error_reporting(0);

define("DOCUMENT_ROOT", "{$_SERVER['DOCUMENT_ROOT']}");

//-----------------------------------------
// set variables
//-----------------------------------------
$filename = "conf_refs.csv";
$databasename = "conf.db";

$file = DOCUMENT_ROOT . "$filename";

define("DATABASENAME", "$databasename");
define("FILE", "$file");
define("TABLENAME", 'conf_refs'); // don't change this

class Config
{

    const PATH_TO_SQLITE_FILE = DATABASENAME;
}

class DBConnection
{

    protected static $db;

    public function __construct()
    {


        try {

            self::$db = new PDO('sqlite:' . Config::PATH_TO_SQLITE_FILE);
            self::$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            error_log('DBConnection EXCEPTION: ' . $e->getMessage());
        }
    }

    public static function instantiate()
    {

        if (!self::$db) {
            new DBConnection();
        }

        return self::$db;
    }
}

class Install
{

    private $db;
    private $table = TABLENAME;

    public function __construct()
    {

        $this->db = DBConnection::instantiate();
    }

    public function __destruct()
    {
        unset($this->db);
    }

    public function createTable()
    {

        $status = false;

        try {

            $sql = "CREATE TABLE IF NOT EXISTS $this->table (
                id integer primary key,
                c integer,
                v integer,
                t text
                )";

            $stmt = $this->db->prepare($sql);
            if ($stmt->execute()) {
                $status = true;
            }
        } catch (PDOException $e) {
            error_log('createTable EXCEPTION: ' . $e->getMessage());
        }
        return $status;
    }

    public function insertData($data = array())
    {

        $status = false;

        try {

            $sql = "INSERT INTO $this->table (c, v, t) VALUES (:c, :v, :t)";

            $stmt = $this->db->prepare($sql);

            $stmt->bindParam(':c', $data['c']); // chapter
            $stmt->bindParam(':v', $data['v']); // verse
            $stmt->bindParam(':t', $data['t']); // text

            if ($stmt->execute()) {
                $status = true;
            }
        } catch (PDOException $e) {
            error_log('insertData EXCEPTION: ' . $e->getMessage());
        }

        return $status;
    }
}

//-----------------------------------------
// main loop
//-----------------------------------------

$install = true;

if ($install) {

    // delete old db file
    //if (file_exists(DATABASENAME)) {
    //    unlink(DATABASENAME);
    //}

    $sqlite = new Install();
    $sqlite->createTable();
}

$data = array();

echo "---------------------------\n";
echo "Working ....\n";
echo "---------------------------\n";

//function countDigits( $str ) {
//    $c = 0;
//    if(preg_match_all("/[0-9]+/", $str, $matches)) {
//  	$c = count($matches[0]);
//    }
//    return $c;
//}

$file = file_get_contents($filename);

$array = explode(']', $file);

//$sub_count = 0;
//$digi_count = 0;

for ($x = 0; $x < count($array); $x++) {

    // three parts
    $parts = explode('|', $array[$x]);

    $data['c'] = trim($parts[0]); // chapter
    $data['v'] = trim($parts[1]); // verse
    $data['t'] = trim($parts[2]); // text
    
    //$digi_count = countDigits($data['t']); // count digits in text
    //if(!$install){
    //	print("\n\nDIGI COUNT " . $digi_count . "\n");
    //}
    
    //for ($w = 0; $w < $digi_count; $w++) {
    //	$sub_count++;

    // replace # + number
    //$data['t'] = preg_replace('/#\d+/', "", $data['t']);
    // replace multiple comma spaces with one comma space
    //$data['t'] = preg_replace('!,\s+!', ', ', $data['t']);
    //}
    

    (!$install)
        ? print_r($data)
        : $sqlite->insertData($data);
        
}

     //   if(!$install){
	//	print("SUB COUNT " . $sub_count . "\n");
	//}

?>
