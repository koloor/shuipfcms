<?php

// +----------------------------------------------------------------------
// | ShuipFCMS 模块
// +----------------------------------------------------------------------
// | Copyright (c) 2012-2014 http://www.shuipfcms.com, All rights reserved.
// +----------------------------------------------------------------------
// | Author: 水平凡 <admin@abc3210.com>
// +----------------------------------------------------------------------

namespace Libs\System;

class Module {

    //应用模块目录
    public $appPath = APP_PATH;
    //模板目录
    public $templatePath;
    //静态资源目录
    public $extresPath = NULL;
    //错误信息
    public $error = NULL;
    //插件配置
    private $config = array();
    //当前模块名称
    private $moduleName = NULL;

    /**
     * 构造方法
     */
    public function __construct() {
        $this->extresPath = SITE_PATH . 'statics/extres/';
        $this->templatePath = TEMPLATE_PATH . 'Default/';
    }

    /**
     * 连接
     * @access public
     * @return void
     */
    static public function getInstance() {
        return \Think\Think::instance('\\Libs\\System\\Module');
    }

    /**
     * 获取错误信息
     * @return string
     */
    public function getError() {
        return $this->error;
    }

    /**
     * 设置当前模块名称
     * @param type $name 模块名
     * @return \Libs\System\Module
     */
    public function setName($name) {
        $this->moduleName = $name;
        return $this;
    }

    /**
     * 获取模块基本配置信息
     * @param type $moduleName 模块名(目录名)
     * @return boolean
     */
    public function config($moduleName = '') {
        if (!empty($this->config) && empty($moduleName)) {
            return $this->config;
        }
        if (empty($moduleName)) {
            if ($this->moduleName) {
                $moduleName = $this->moduleName;
            } else {
                $this->error = '模块名称不能为空！';
                return false;
            }
        }
        $moduleName = ucwords($moduleName);
        $config = array(
            //模块目录
            'module' => $moduleName,
            //模块名称
            'modulename' => $moduleName,
            //图标地址，远程地址
            'icon' => '',
            //模块介绍地址
            'address' => '',
            //模块简介
            'introduce' => '',
            //模块作者
            'author' => '',
            //作者地址
            'authorsite' => '',
            //作者邮箱
            'authoremail' => '',
            //版本号，请不要带除数字外的其他字符
            'version' => '',
            //适配最低ShuipFCMS版本，
            'adaptation' => '',
            //签名
            'sign' => '',
            //依赖模块
            'depend' => array(),
            //行为
            'tags' => array(),
            //缓存
            'cache' => array(),
        );
        //加载安装配置文件
        if (file_exists($this->appPath . $moduleName . '/Config.inc.php')) {
            //加载
            try {
                $moduleConfig = include $this->appPath . $moduleName . '/Config.inc.php';
                $config = array_merge($config, $moduleConfig);
            } catch (Exception $exc) {
                
            }
        }
        //检查是否安装，如果安装了，加载模块安装后的相关配置信息
        if ($this->isInstall($moduleName)) {
            $moduleList = cache('Module');
            $config = array_merge($moduleList[$moduleName], $config);
        }
        $this->config = $config;
        return $config;
    }

    /**
     * 是否已经安装
     * @param type $moduleName 模块名(目录名)
     * @return boolean
     */
    public function isInstall($moduleName = '') {
        if (empty($moduleName)) {
            if ($this->moduleName) {
                $moduleName = $this->moduleName;
            } else {
                $this->error = '模块名称不能为空！';
                return false;
            }
        }
        if ('Content' == $moduleName) {
            return true;
        }
        $moduleList = cache('Module');
        return (isset($moduleList[$moduleName]) && $moduleList[$moduleName]) ? true : false;
    }

    /**
     * 执行模块安装
     * @param type $moduleName 模块名(目录名)
     * @return boolean
     */
    public function install($moduleName = '') {
        defined('INSTALL') or define("INSTALL", true);
        if (empty($moduleName)) {
            if ($this->moduleName) {
                $moduleName = $this->moduleName;
            } else {
                $this->error = '请选择需要安装的模块！';
                return false;
            }
        }
        //已安装模块列表
        $moduleList = cache('Module');
        //设置脚本最大执行时间
        set_time_limit(0);
        if ($this->competence($moduleName) !== true) {
            return false;
        }
        //加载模块基本配置
        $config = $this->config($moduleName);
        //版本检查
        if ($config['adaptation']) {
            if (version_compare(SHUIPF_VERSION, $config['adaptation'], '>=') == false) {
                $this->error = '该模块要求系统最低版本为：' . $config['adaptation'] . '！';
                return false;
            }
        }
        //依赖模块检测
        if (!empty($config['depend']) && is_array($config['depend'])) {
            foreach ($config['depend'] as $mod) {
                if ('Content' == $mod) {
                    continue;
                }
                if (!isset($moduleList[$mod])) {
                    $this->error = "安装该模块，需要安装依赖模块 {$mod} !";
                    return false;
                }
            }
        }
        //检查模块是否已经安装
        if ($this->isInstall($moduleName)) {
            $this->error = '该模块已经安装，无法重复安装！';
            return false;
        }
        $model = D('Common/Module');
        C('TOKEN_ON',false);
        if (!$model->create($config, 1)) {
            $this->error = $model->getError()? : '安装初始化失败！';
            return false;
        }
        if ($model->add() == false) {
            $this->error = '安装失败！';
            return false;
        }
        //执行安装脚本
        if (!$this->runInstallScript($moduleName)) {
            $this->installRollback($moduleName);
            return false;
        }
        //执行数据库脚本安装
        $this->runSQL($moduleName);
        //执行菜单项安装
        if ($this->installMenu($moduleName) !== true) {
            $this->installRollback($moduleName);
            return false;
        }
        //缓存注册
        if (!empty($config['cache'])) {
            if (D('Common/Cache')->installModuleCache($config['cache'], $config) !== true) {
                $this->error = D('Common/Cache')->getError();
                $this->installRollback($moduleName);
                return false;
            }
        }
        $Dir = new \Dir();
        //前台模板
        if (file_exists($this->appPath . "{$moduleName}/Install/Template/")) {
            //拷贝模板到前台模板目录中去
            $Dir->copyDir($this->appPath . "{$moduleName}/Install/Template/", $this->templatePath);
        }
        //静态资源文件
        if (file_exists($this->appPath . "{$moduleName}/Install/Extres/")) {
            //拷贝模板到前台模板目录中去
            $Dir->copyDir($this->appPath . "{$moduleName}/Install/Extres/", $this->extresPath . strtolower($moduleName) . '/');
        }
        //安装行为
        if (!empty($config['tags'])) {
            D('Common/Behavior')->moduleBehaviorInstallation($moduleName, $config['tags']);
        }
        //安装结束，最后调用安装脚本完成
        $this->runInstallScriptEnd($moduleName);
        //更新缓存
        cache('Module', NULL);
        return true;
    }

    /**
     * 模块卸载
     * @param type $moduleName 模块名(目录名)
     * @return boolean
     */
    public function uninstall($moduleName = '') {
        defined('UNINSTALL') or define("UNINSTALL", true);
        if (empty($moduleName)) {
            if ($this->moduleName) {
                $moduleName = $this->moduleName;
            } else {
                $this->error = '请选择需要卸载的模块！';
                return false;
            }
        }
        //设置脚本最大执行时间
        set_time_limit(0);
        if ($this->competence($moduleName) !== true) {
            return false;
        }
        $model = D('Common/Module');
        //取得该模块数据库中记录的安装信息
        $info = $model->where(array('module' => $moduleName))->find();
        if (empty($info)) {
            $this->error = '该模块未安装，无需卸载！';
            return false;
        }
        if ($info['iscore']) {
            $this->error = '内置模块，不能卸载！';
            return false;
        }
        //删除
        if ($model->where(array('module' => $moduleName))->delete() == false) {
            $this->error = '卸载失败！';
            return false;
        }
        //删除权限
        M("Access")->where(array("app" => $moduleName))->delete();
        //移除菜单项和权限项
        M("Menu")->where(array("app" => $moduleName))->delete();
        //去除对应行为规则
        D('Common/Behavior')->moduleBehaviorUninstall($moduleName);
        //注销缓存
        D('Common/Cache')->deleteCacheModule($moduleName);
        //删除菜单项
        $this->uninstallMenu($moduleName);
        //执行卸载脚本
        if (!$this->runInstallScript($moduleName, 'Uninstall')) {
            $this->installRollback($moduleName);
            return false;
        }
        //执行数据库脚本安装
        $this->runSQL($moduleName, 'Uninstall');
        $Dir = new \Dir();
        //删除模块前台模板
        $Dir->delDir($this->templatePath . $moduleName . DIRECTORY_SEPARATOR);
        //静态资源移除
        $Dir->delDir($this->extresPath . strtolower($moduleName) . DIRECTORY_SEPARATOR);
        //卸载结束，最后调用卸载脚本完成
        $this->runInstallScriptEnd($moduleName, 'Uninstall');
        //更新缓存
        cache('Module', NULL);
        //移除目录
        $Dir->delDir(APP_PATH . $moduleName . DIRECTORY_SEPARATOR);
        return true;
    }

    /**
     * 模块升级
     * @param type $moduleName 模块名(目录名)
     * @return boolean
     */
    public function upgrade($moduleName = '') {
        if (empty($moduleName)) {
            if ($this->moduleName) {
                $moduleName = $this->moduleName;
            } else {
                $this->error = '请选择需要升级的模块！';
                return false;
            }
        }
        //设置脚本最大执行时间
        set_time_limit(0);
        if ($this->competence($moduleName) !== true) {
            return false;
        }
        $model = D('Common/Module');
        //取得该模块数据库中记录的安装信息
        $info = $model->where(array('module' => $moduleName))->find();
        if (empty($info)) {
            $this->error = '该模块未安装，无需升级！';
            return false;
        }
        //执行数据库升级脚本
        $this->runSQL($moduleName, 'Upgrade');
        //执行卸载脚本
        if (!$this->runInstallScript($moduleName, 'Upgrade')) {
            $this->installRollback($moduleName);
            return false;
        }
        //加载配置
        $config = $this->config($moduleName);
        if (!empty($config)) {
            //更新版本号
            $model->where(array('module' => $moduleName))->save(array('version' => $config['version'], 'updatetime' => time()));
        }
        //卸载结束，最后调用卸载脚本完成
        $this->runInstallScriptEnd($moduleName, 'Upgrade');
        //更新缓存
        cache('Module', NULL);
        return true;
    }

    /**
     * 目录权限检查
     * @param type $moduleName 模块名称
     * @return boolean
     */
    public function competence($moduleName = '') {
        //模板目录权限检测
        if ($this->chechmod($this->templatePath) == false) {
            $this->error = '目录 ' . $this->templatePath . ' 没有可写权限！';
            return false;
        }
        if ($moduleName && file_exists($this->extresPath . $moduleName)) {
            if ($this->chechmod($this->extresPath . $moduleName) == false) {
                $this->error = '目录 ' . $this->extresPath . $moduleName . ' 没有可写权限！';
                return false;
            }
        }
        //静态资源目录权限检测
        if (!file_exists($this->extresPath)) {
            //创建目录
            if (mkdir($this->extresPath, 0777, true) == false) {
                $this->error = '目录 ' . $this->extresPath . ' 创建失败，请检查是否有可写权限！';
                return false;
            }
        }
        //权限检测
        if ($this->chechmod($this->extresPath) == false) {
            $this->error = '目录 ' . $this->extresPath . ' 没有可写权限！';
            return false;
        }
        return true;
    }

    /**
     * 检查对应目录是否有相应的权限
     * @param type $path 目录地址
     * @return boolean
     */
    protected function chechmod($path) {
        //检查模板文件夹是否有可写权限 TEMPLATE_PATH
        $tfile = "_test.txt";
        $fp = @fopen($path . $tfile, "w");
        if (!$fp) {
            return false;
        }
        fclose($fp);
        $rs = @unlink($path . $tfile);
        if (!$rs) {
            return false;
        }
        return true;
    }

    /**
     * 卸载菜单项项
     * @param type $moduleName
     * @return boolean
     */
    private function uninstallMenu($moduleName = '') {
        if (empty($moduleName)) {
            if ($this->moduleName) {
                $moduleName = $this->moduleName;
            } else {
                $this->error = '模块名称不能为空！';
                return false;
            }
        }
        M('Menu')->where(array('app' => $moduleName))->delete();
        return true;
    }

    /**
     * 安装菜单项
     * @param type $moduleName 模块名称
     * @param type $file 文件
     * @return boolean
     */
    private function installMenu($moduleName = '', $file = 'Menu') {
        if (empty($moduleName)) {
            if ($this->moduleName) {
                $moduleName = $this->moduleName;
            } else {
                $this->error = '模块名称不能为空！';
                return false;
            }
        }
        $path = $this->appPath . "{$moduleName}/Install/{$file}.php";
        //检查是否有安装脚本
        if (!file_exists($path)) {
            return true;
        }
        $menu = include $path;
        if (empty($menu)) {
            return true;
        }
        $status = D('Admin/Menu')->installModuleMenu($menu, $this->config($moduleName));
        if ($status === true) {
            return true;
        } else {
            $this->error = D('Admin/Menu')->getError()? : '安装菜单项出现错误！';
            return false;
        }
    }

    /**
     * 执行安装脚本
     * @param type $moduleName 模块名(目录名)
     * @return boolean
     */
    private function runInstallScript($moduleName = '', $Dir = 'Install') {
        if (empty($moduleName)) {
            if ($this->moduleName) {
                $moduleName = $this->moduleName;
            } else {
                $this->error = '模块名称不能为空！';
                return false;
            }
        }
        //检查是否有安装脚本
        if (require_cache($this->appPath . "{$moduleName}/{$Dir}/{$Dir}.class.php") !== true) {
            return true;
        }
        $className = "\\{$moduleName}\\{$Dir}\\{$Dir}";
        $installObj = \Think\Think::instance($className);
        //执行安装
        if (false == $installObj->run()) {
            $this->error = $installObj->getError();
            return false;
        }
        return true;
    }

    /**
     * 执行安装脚本
     * @param type $moduleName 模块名(目录名)
     * @return boolean
     */
    private function runInstallScriptEnd($moduleName = '', $Dir = 'Install') {
        if (empty($moduleName)) {
            if ($this->moduleName) {
                $moduleName = $this->moduleName;
            } else {
                $this->error = '模块名称不能为空！';
                return false;
            }
        }
        //检查是否有安装脚本
        if (require_cache($this->appPath . "{$moduleName}/{$Dir}/{$Dir}.class.php") !== true) {
            return true;
        }
        $className = "\\{$moduleName}\\{$Dir}\\{$Dir}";
        $installObj = \Think\Think::instance($className);
        //执行安装
        if (false == $installObj->end()) {
            $this->error = $installObj->getError();
            return false;
        }
        return true;
    }

    /**
     * 执行安装数据库脚本
     * @param type $moduleName 模块名(目录名)
     * @return boolean
     */
    private function runSQL($moduleName = '', $Dir = 'Install') {
        if (empty($moduleName)) {
            if ($this->moduleName) {
                $moduleName = $this->moduleName;
            } else {
                $this->error = '模块名称不能为空！';
                return false;
            }
        }
        $path = $this->appPath . "{$moduleName}/{$Dir}/{$moduleName}.sql";
        if (!file_exists($path)) {
            return true;
        }
        $sql = file_get_contents($path);
        $sql = $this->resolveSQL($sql, C("DB_PREFIX"));
        if (!empty($sql) && is_array($sql)) {
            foreach ($sql as $sql_split) {
                M()->execute($sql_split);
            }
        }
        return true;
    }

    /**
     * 安装回滚
     * @param type $moduleName 模块名(目录名)
     */
    private function installRollback($moduleName = '') {
        if (empty($moduleName)) {
            if ($this->moduleName) {
                $moduleName = $this->moduleName;
            } else {
                $this->error = '模块名称不能为空！';
                return false;
            }
        }
        //删除安装状态
        M('Module')->where(array('module' => $moduleName))->delete();
        //更新缓存
        cache('Module', NULL);
    }

    /**
     * 分析处理sql语句，执行替换前缀都功能。
     * @param string $sql 原始的sql
     * @param string $tablepre 表前缀
     */
    private function resolveSQL($sql, $tablepre) {
        if ($tablepre != "shuipfcms_")
            $sql = str_replace("shuipfcms_", $tablepre, $sql);
        $sql = preg_replace("/TYPE=(InnoDB|MyISAM|MEMORY)( DEFAULT CHARSET=[^; ]+)?/", "ENGINE=\\1 DEFAULT CHARSET=utf8", $sql);
        if ($r_tablepre != $s_tablepre)
            $sql = str_replace($s_tablepre, $r_tablepre, $sql);
        $sql = str_replace("\r", "\n", $sql);
        $ret = array();
        $num = 0;
        $queriesarray = explode(";\n", trim($sql));
        unset($sql);
        foreach ($queriesarray as $query) {
            $ret[$num] = '';
            $queries = explode("\n", trim($query));
            $queries = array_filter($queries);
            foreach ($queries as $query) {
                $str1 = substr($query, 0, 1);
                if ($str1 != '#' && $str1 != '-')
                    $ret[$num] .= $query;
            }
            $num++;
        }
        return $ret;
    }

}
