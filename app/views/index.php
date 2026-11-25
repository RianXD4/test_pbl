<?php
$basePath = rtrim(str_replace('\\', '/', dirname($_SERVER['SCRIPT_NAME'] ?? '')), '/');
if ($basePath === '.' || $basePath === '/') {
    $basePath = '';
}

header('Location: ' . $basePath . '/ditemukan.php', true, 302);
exit;
??SDWASDw