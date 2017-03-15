<?php

// +----------------------------------------------------------------------
// | ShuipFCMS Controller
// +----------------------------------------------------------------------
// | Copyright (c) 2012-2014 http://www.shuipfcms.com, All rights reserved.
// +----------------------------------------------------------------------
// | Author: 水平凡 <admin@abc3210.com>
// +----------------------------------------------------------------------

namespace Common\Controller;

use Libs\System\Components;

class ShuipFCMS extends \Think\Controller {

    //缓存
    public static $Cache = array();
    //当前对象
    private static $_app;

    public function __get($name) {
        $parent = parent::__get($name);
        if (empty($parent)) {
            return Components::getInstance()->$name;
        }
        return $parent;
    }

    public function __construct() {
        parent::__construct();
        self::$_app = $this;
    }

    //初始化
    protected function _initialize() {
        $this->initSite();
        //默认跳转时间
        $this->assign("waitSecond", 3000);
    }

    /**
     * 获取ShuipFCMS 对象
     * @return type
     */
    public static function app() {
        return self::$_app;
    }

    /**
     * 初始化站点配置信息
     * @return Arry 配置数组
     */
    protected function initSite() {
        $Config = cache("Config");
        self::$Cache['Config'] = $Config;
        $config_siteurl = $Config['siteurl'];
        if (isModuleInstall('Domains')) {
            $parse_url = parse_url($config_siteurl);
            $config_siteurl = (is_ssl() ? 'https://' : 'http://') . "{$_SERVER['HTTP_HOST']}{$parse_url['path']}";
        }
        defined('CONFIG_SITEURL_MODEL') or define('CONFIG_SITEURL_MODEL', $config_siteurl);
        $this->assign("config_siteurl", $config_siteurl);
        $this->assign("Config", $Config);
    }

    /**
     * Ajax方式返回数据到客户端
     * @access protected
     * @param mixed $data 要返回的数据
     * @param String $type AJAX返回数据格式
     * @param int $json_option 传递给json_encode的option参数
     * @return void
     */
    protected function ajaxReturn($data,$type='',$json_option=0) {
        $data['state'] = $data['status'] ? "success" : "fail";
        if(empty($type)) $type  =   C('DEFAULT_AJAX_RETURN');
        switch (strtoupper($type)){
            case 'JSON' :
                // 返回JSON数据格式到客户端 包含状态信息
                header('Content-Type:text/html; charset=utf-8');
                exit(json_encode($data,$json_option));
            case 'XML'  :
                // 返回xml格式数据
                header('Content-Type:text/xml; charset=utf-8');
                exit(xml_encode($data));
            case 'JSONP':
                // 返回JSON数据格式到客户端 包含状态信息
                header('Content-Type:application/json; charset=utf-8');
                $handler  =   isset($_GET[C('VAR_JSONP_HANDLER')]) ? $_GET[C('VAR_JSONP_HANDLER')] : C('DEFAULT_JSONP_HANDLER');
                exit($handler.'('.json_encode($data,$json_option).');');  
            case 'EVAL' :
                // 返回可执行的js脚本
                header('Content-Type:text/html; charset=utf-8');
                exit($data);            
            default     :
                // 用于扩展其他返回格式数据
                tag('ajax_return', $data);
        }
    }

    /**
     * 分页输出
     * @param type $total 信息总数
     * @param type $size 每页数量
     * @param type $number 当前分页号（页码）
     * @param type $config 配置，会覆盖默认设置
     * @return type
     */
    protected function page($total, $size = 0, $number = 0, $config = array()) {
        return page($total, $size, $number, $config);
    }

    /**
     * 返回模型对象
     * @param type $model
     * @return type
     */
    protected function getModelObject($model) {
        if (is_string($model) && strpos($model, '/') == false) {
            $model = M(ucwords($model));
        } else if (strpos($model, '/') && is_string($model)) {
            $model = D($model);
        } else if (is_object($model)) {
            return $model;
        } else {
            $model = M();
        }
        return $model;
    }

    /**
     * 基本信息分页列表方法
     * @param type $model 可以是模型对象，或者表名，自定义模型请传递完整（例如：Content/Model）
     * @param type $where 条件表达式
     * @param type $order 排序
     * @param type $limit 每次显示多少
     */
    protected function basePage($model, $where = '', $order = '', $limit = 20) {
        $model = $this->getModelObject($model);
        $count = $model->where($where)->count();
        $page = $this->page($count, $limit);
        $data = $model->where($where)->order($order)->limit($page->firstRow . ',' . $page->listRows)->select();
        $this->assign('Page', $page->show());
        $this->assign('data', $data);
        $this->assign('count', $count);
        $this->display();
    }

    /**
     * 基本信息添加
     * @param type $model 可以是模型对象，或者表名，自定义模型请传递完整（例如：Content/Model）
     * @param type $u 添加成功后的跳转地址
     * @param type $data 需要添加的数据
     */
    protected function baseAdd($model, $u = 'index', $data = '') {
        $model = $this->getModelObject($model);
        if (IS_POST) {
            if (empty($data)) {
                $data = I('post.', '', '');
            }
            if ($model->create($data) && $model->add()) {
                $this->success('添加成功！', $u ? U($u) : '');
            } else {
                $error = $model->getError();
                $this->error($error? : '添加失败！');
            }
        } else {
            $this->display();
        }
    }

    /**
     * 基础修改信息方法
     * @param type $model 可以是模型对象，或者表名，自定义模型请传递完整（例如：Content/Model）
     * @param type $u 修改成功后的跳转地址
     * @param type $data 需要修改的数据
     */
    protected function baseEdit($model, $u = 'index', $data = '') {
        $model = $this->getModelObject($model);
        $fidePk = $model->getPk();
        $pk = I('request.' . $fidePk, '', '');
        if (empty($pk)) {
            $this->error('请指定需要修改的信息！');
        }
        $where = array($fidePk => $pk);
        if (IS_POST) {
            if (empty($data)) {
                $data = I('post.', '', '');
            }
            if ($model->create($data) && $model->where($where)->save() !== false) {
                $this->success('修改成功！', $u ? U($u) : '');
            } else {
                $error = $model->getError();
                $this->error($error? : '修改失败！');
            }
        } else {
            $data = $model->where($where)->find();
            if (empty($data)) {
                $this->error('该信息不存在！');
            }
            $this->assign('data', $data);
            $this->display();
        }
    }

    /**
     * 基础信息单条记录删除，根据主键
     * @param type $model 可以是模型对象，或者表名，自定义模型请传递完整（例如：Content/Model）
     * @param type $u 删除成功后跳转地址
     */
    protected function baseDelete($model, $u = 'index') {
        $model = $this->getModelObject($model);
        $pk = I('request.' . $model->getPk());
        if (empty($pk)) {
            $this->error('请指定需要修改的信息！');
        }
        $where = array($model->getPk() => $pk);
        $data = $model->where($where)->find();
        if (empty($data)) {
            $this->error('该信息不存在！');
        }
        if ($model->delete() !== false) {
            $this->success('删除成功！', $u ? U($u) : '');
        } else {
            $error = $model->getError();
            $this->error($error? : '删除失败！');
        }
    }

    /**
     * 验证码验证
     * @param type $verify 验证码
     * @param type $type 验证码类型
     * @return boolean
     */
    static public function verify($verify, $type = "verify") {
        return A('Api/Checkcode')->validate($type, $verify);
    }

    static public function logo() {
        return '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';
    }

    //空操作
    public function _empty() {
        $this->error('该页面不存在！');
    }

}
