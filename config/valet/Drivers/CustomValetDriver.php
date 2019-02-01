<?php

class CustomValetDriver extends ValetDriver
{
    /**
     * Custom driver holder.
     * 
     * @var Object
     */
    private $driver;

    /**
     * Determine if the driver serves the request.
     *
     * @param  string  $sitePath
     * @param  string  $siteName
     * @param  string  $uri
     * @return bool
     */
    public function serves($sitePath, $siteName, $uri)
    {
        if (!file_exists("$sitePath/valet.php")) {
            return false;
        }

        $this->driver = require "$sitePath/valet.php";
        
        return true;
    }

    /**
     * Determine if the incoming request is for a static file.
     *
     * @param  string  $sitePath
     * @param  string  $siteName
     * @param  string  $uri
     * @return string|false
     */
    public function isStaticFile ($sitePath, $siteName, $uri)
    {
        if (method_exists('isStaticFile', $this->driver)) {
            return $this->driver->isStaticFile($sitePath, $siteName, $uri);
        }

        return false;
    }

    /**
     * Get the fully resolved path to the application's front controller.
     *
     * @param  string  $sitePath
     * @param  string  $siteName
     * @param  string  $uri
     * @return string
     */
    public function frontControllerPath($sitePath, $siteName, $uri)
    {
        return $this->driver->frontControllerPath($sitePath, $siteName, $uri);
    }
}
