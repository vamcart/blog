<?php

namespace App\Core;

class View
{
    /**
     * Template file name without extension
     */
    protected $file;

    /**
     * Data passed to the template
     */
    protected $data = [];

    /**
     * Smarty instance
     */
    protected $smarty;

    /**
     * Base path to view directory
     */
    protected $basePath;

    /**
     * Path to cache/compiled templates
     */
    protected $cachePath;

    public function __construct($file, $data = [])
    {
        $this->basePath = app()->getBasePath() . '/app/Views/';
        $this->cachePath = app()->getBasePath() . '/cache/';
        if (!is_dir($this->cachePath)) {
            mkdir($this->cachePath, 0775, true);
        }

        $this->file = $file;
        $this->data = $data;

        // init smarty
        $this->smarty = new \Smarty\Smarty();
        $this->smarty->setTemplateDir($this->basePath);
        $this->smarty->setCompileDir($this->cachePath);
        $this->smarty->setCacheDir($this->cachePath);

        // register helper function plugins used in templates
        $this->smarty->registerPlugin('function', 'config', function ($params, &$smarty) {
            return config($params['key']);
        });
        $this->smarty->registerPlugin('function', 'url', function ($params, &$smarty) {
            return url($params['path'] ?? '');
        });
        $this->smarty->registerPlugin('function', 'route', function ($params, &$smarty) {
            return route($params['name'] ?? '', $params);
        });

        // assign data to smarty
        if (is_array($data)) {
            foreach ($data as $k => $v) {
                $this->smarty->assign($k, $v);
            }
        }
        
        // expose session object
        $this->smarty->assign('session', session());
        // expose request object
        $this->smarty->assign('request', request());
        // expose isAdmin helper
        $this->smarty->assign('isAdmin', isAdmin());
    }

    public function render()
    {
        return $this->smarty->fetch($this->file . '.tpl');
    }
}
