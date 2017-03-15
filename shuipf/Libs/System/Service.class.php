<?php

// +----------------------------------------------------------------------
// | ShuipFCMS 服务
// +----------------------------------------------------------------------
// | Copyright (c) 2012-2014 http://www.shuipfcms.com, All rights reserved.
// +----------------------------------------------------------------------
// | Author: 水平凡 <admin@abc3210.com>
// +----------------------------------------------------------------------

namespace Libs\System;

class Service {

    /**
     * 取得Service 服务
     * @static
     * @access public
     * @return mixed
     */
    static function getInstance($type = '', $options = array()) {
        static $_instance = array();
        $guid = $type . to_guid_string($options);
        if (!isset($_instance[$guid])) {
            $class = strpos($type, '\\') ? $type : 'Libs\\Service\\' . ucwords(strtolower($type));
            if (class_exists($class)) {
                $connect = new $class($options);
                $_instance[$guid] = $connect->connect($type, $options);
            } else {
                E('Service 服务类不存在！');
            }
        }
        return $_instance[$guid];
    }

}
