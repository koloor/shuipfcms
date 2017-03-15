<?php

// +----------------------------------------------------------------------
// | ShuipFCMS 缓存处理
// +----------------------------------------------------------------------
// | Copyright (c) 2012-2014 http://www.shuipfcms.com, All rights reserved.
// +----------------------------------------------------------------------
// | Author: 水平凡 <admin@abc3210.com>
// +----------------------------------------------------------------------

namespace Libs\System;

class Cache {

    /**
     * 连接缓存系统
     * @access public
     * @param string $type 缓存类型
     * @param array $options  配置数组
     * @return void
     */
    static public function getInstance($type = 'S', $options = array()) {
        static $systemHandier;
        if (empty($systemHandier)) {
            $systemHandier = new Cache();
        }
        return $systemHandier;
    }

    /**
     * 获取缓存
     * @param type $name 缓存名称
     * @return null
     */
    public function get($name) {
        $cache = S($name);
        if (!empty($cache)) {
            return $cache;
        } else {
            //尝试生成缓存
            return $this->runUpdate($name);
        }
        return null;
    }

    /**
     * 写入缓存
     * @param string $name 缓存变量名
     * @param type $value 存储数据
     * @param type $expire 有效时间（秒）
     * @return boolean
     */
    public function set($name, $value, $expire = null) {
        return S($name, $value, $expire);
    }

    /**
     * 删除缓存
     * @param string $name 缓存变量名
     * @return boolean
     */
    public function remove($name) {
        return S($name, NULL);
    }

    /**
     * 更新缓存
     * @param type $name 缓存key
     * @return boolean
     */
    public function runUpdate($name) {
        //安装状态下不执行
        if (!C('DB_HOST')) {
            return false;
        }
        if (empty($name)) {
            return false;
        }
        $cacheModel = D('Common/Cache');
        //查询缓存key
        $cacheList = $cacheModel->where(array('key' => $name))->order(array('id' => 'DESC'))->select();
        if (empty($cacheList)) {
            return false;
        }
        foreach ($cacheList as $cache) {
            $cacheModel->runUpdate($cache);
        }
        //再次加载
        return S($name);
    }

}
