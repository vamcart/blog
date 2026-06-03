<?php
return [
    // the app name
    'name' => 'Блог',
    // the db config
    'database' => [
        'type' => 'mysql',
        'host' => 'database',
        'port' => '3306',
        'user' => 'docker',
        'password' => 'docker',
        'db' => 'docker',
    ],
    // use short_url (e.g http://domain.com/some-route will become /some-route)
    'short_url' => true
];
