<?php

// +----------------------------------------------------------------------
// | ShuipFCMS
// +----------------------------------------------------------------------
// | Copyright (c) 2012-2014 http://www.shuipfcms.com, All rights reserved.
// +----------------------------------------------------------------------
// | Author: 水平凡 <admin@abc3210.com>
// +----------------------------------------------------------------------

/**
 * ShuipFCMS专属模式
 */
return array(
    // 配置文件
    'config' => array(
        THINK_PATH . 'Conf/convention.php', // 系统惯例配置
        CONF_PATH . 'config' . CONF_EXT, // 应用公共配置
        CONF_PATH . 'dataconfig' . CONF_EXT, //数据库配置
        CONF_PATH . 'addition' . CONF_EXT, //用户扩展配置
        CONF_PATH . 'version' . CONF_EXT, //系统版本配置
    ),
    // 别名定义
    'alias' => array(
        'Think\Log' => CORE_PATH . 'Log' . EXT,
        'Think\Log\Driver\File' => CORE_PATH . 'Log/Driver/File' . EXT,
        'Think\Exception' => CORE_PATH . 'Exception' . EXT,
        'Think\Model' => CORE_PATH . 'Model' . EXT,
        'Think\Db' => CORE_PATH . 'Db' . EXT,
        'Think\Template' => CORE_PATH . 'Template' . EXT,
        'Think\Cache' => CORE_PATH . 'Cache' . EXT,
        'Think\Cache\Driver\File' => CORE_PATH . 'Cache/Driver/File' . EXT,
        'Think\Storage' => CORE_PATH . 'Storage' . EXT,
    ),
    // 函数和类文件
    'core' => array(
        COMMON_PATH . 'Common/corefun.php',
        COMMON_PATH . 'Common/common.php',
        PROJECT_PATH . 'Libs/System/Hook' . EXT,
        CORE_PATH . 'App' . EXT,
        CORE_PATH . 'Dispatcher' . EXT,
        CORE_PATH . 'Log'.EXT,
        CORE_PATH . 'Route' . EXT,
        CORE_PATH . 'Controller' . EXT,
        CORE_PATH . 'View' . EXT,
        BEHAVIOR_PATH . 'BuildLiteBehavior' . EXT,
        BEHAVIOR_PATH . 'ParseTemplateBehavior' . EXT,
        BEHAVIOR_PATH . 'ContentReplaceBehavior' . EXT,
    ),
    // 行为扩展定义
    'tags' => array(
//        'app_init' => array(
//            'Behavior\BuildLiteBehavior', // 生成运行Lite文件
//        ),
//        'app_begin' => array(
//            'Behavior\ReadHtmlCacheBehavior', // 读取静态缓存
//        ),
//        'app_end' => array(
//            'Behavior\ShowPageTraceBehavior', // 页面Trace显示
//        ),
//        'view_parse' => array(
//            'Behavior\ParseTemplateBehavior', // 模板解析 支持PHP、内置模板引擎和第三方模板引擎
//        ),
//        'template_filter' => array(
//            'Behavior\ContentReplaceBehavior', // 模板输出替换
//        ),
//        'view_filter' => array(
//            'Behavior\WriteHtmlCacheBehavior', // 写入静态缓存
//        ),
    ),
);
