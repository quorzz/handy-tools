#!/usr/bin/env php
<?php
// as there is lack of the command `tree` which I usually use in ubuntu ,
// I produce this small wheel.
// quorzz@gmail.com
// 2015年11月15日08:45:32

$args = $_SERVER['argv'];
$path = '.';
$deep = 0;

if (!empty($args[1])) {
    if (!is_dir($path = (string)$args[1])){
        echo "\e[33m sorry! $path is not a dir.";
        exit(1);
    }
}

if (!empty($args[2])) {
    $deep = (string)$args[2];
    $deep = (int)ltrim($deep, "-");
}

function getOutput($f, $n) {
    $output = "";
    $output .= str_repeat("| ", $n);
    $output .= '|___ ';
    $output .= $f;
    $output .= PHP_EOL;
    return $output;
}

function displayDir($f, $n) {
    $output = getOutput($f, $n);
    echo "\e[032m $output";
}

function displayFile($f, $n) {
    $output = getOutput($f, $n);
    echo "\e[033m $output";
}

function canStop($n) {
    global $deep;
    if ($deep === 0) {
        return false;
    }
    return $n >= $deep;
}

function tree($path, $n=0) {
    foreach (scandir($path) as $name) {
        if (canStop($n)) {
            return;
        }
        if ('.' === $name || '..' === $name) {
            continue;
        }
        $f = $path . DIRECTORY_SEPARATOR . $name;
        if (is_dir($f)) {
            displayDir($name, $n);
            tree($f,$n+1);
        } else {
            displayFile($name, $n);
        }
    }
}

tree($path);
