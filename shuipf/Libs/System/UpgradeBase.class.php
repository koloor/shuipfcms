<?php

// +----------------------------------------------------------------------
// | ShuipFCMS 模块升级脚本抽象类
// +----------------------------------------------------------------------
// | Copyright (c) 2012-2014 http://www.shuipfcms.com, All rights reserved.
// +----------------------------------------------------------------------
// | Author: 水平凡 <admin@abc3210.com>
// +----------------------------------------------------------------------

namespace Libs\System;

abstract class UpgradeBase {

    //错误信息
    protected $error = '';

    /**
     * 卸载开始执行
     * @return boolean
     */
    public function run() {
        return true;
    }

    /**
     * 卸载完回调
     * @return boolean
     */
    public function end() {
        return true;
    }

    /**
     * 获取错误
     * @return string
     */
    public function getError() {
        return $this->error;
    }

}
