<?php

// +----------------------------------------------------------------------
// | ShuipFCMS
// +----------------------------------------------------------------------
// | Copyright (c) 2012-2014 http://www.shuipfcms.com, All rights reserved.
// +----------------------------------------------------------------------
// | Author: 水平凡 <admin@abc3210.com>
// +----------------------------------------------------------------------

namespace Install\Controller;

use Think\Controller;

class IndexController extends Controller {

    //初始化
    public function _initialize() {
        header('Content-Type:text/html;charset=utf-8;');
        if (!defined('INSTALL')) {
            exit('请不要直接访问本模块。');
        }
        //检查是否已经安装过
        if (is_file(MODULE_PATH . 'install.lock')) {
            exit('你已经安装过该系统，如果想重新安装，请先删除站点' . MODULE_PATH . '目录下的 install.lock 文件，然后再安装。');
        }
        $this->assign('Title', C('SHUIPF_APPNAME'))
                ->assign('Powered', 'Powered by abc3210.com');
    }

    //安装首页
    public function index() {
        $this->display();
    }

    //第二步
    public function step_2() {
        //错误
        $err = 0;
        //mysql检测
        if (function_exists('mysql_connect')) {
            $mysql = '<span class="correct_span">&radic;</span> 已安装';
        } else {
            $mysql = '<span class="correct_span error_span">&radic;</span> 出现错误';
            $err++;
        }
        //上传检测
        if (ini_get('file_uploads')) {
            $uploadSize = '<span class="correct_span">&radic;</span> ' . ini_get('upload_max_filesize');
        } else {
            $uploadSize = '<span class="correct_span error_span">&radic;</span>禁止上传';
            $err++;
        }
        //session检测
        if (function_exists('session_start')) {
            $session = '<span class="correct_span">&radic;</span> 支持';
        } else {
            $session = '<span class="correct_span error_span">&radic;</span> 不支持';
            $err++;
        }
        //目录权限检测
        $folder = array(
            '/',
            '/d/',
            '/shuipf/Application/Install/',
            '/shuipf/Common/Conf/',
            '/shuipf/Common/Conf/addition.php',
        );
        $dir = new \Dir();
        $folderInfo = array();
        foreach ($folder as $dir) {
            $result = array(
                'dir' => $dir,
            );
            $path = SITE_PATH . $dir;
            //是否可读
            if (is_readable($path)) {
                $result['is_readable'] = '<span class="correct_span">&radic;</span>可读';
            } else {
                $result['is_readable'] = '<span class="correct_span error_span">&radic;</span>不可读';
                $err++;
            }
            //是否可写
            if (is_writable($path)) {
                $result['is_writable'] = '<span class="correct_span">&radic;</span>可写';
            } else {
                $result['is_writable'] = '<span class="correct_span error_span">&radic;</span>不可写';
                $err++;
            }
            $folderInfo[] = $result;
        }

        //PHP内置函数检测
        $function = array(
            'mb_strlen' => function_exists('mb_strlen'),
            'curl_init' => function_exists('curl_init'),
        );
        foreach ($function as $rs) {
            if ($rs == false) {
                $err++;
            }
        }

        $this->assign('os', PHP_OS)
                ->assign('function', $function)
                ->assign('err', $err)
                ->assign('phpv', @phpversion())
                ->assign('mysql', $mysql)
                ->assign('uploadSize', $uploadSize)
                ->assign('session', $session)
                ->assign('folderInfo', $folderInfo);
        $this->display();
    }

    //第三步
    public function step_3() {
        //地址
        $scriptName = !empty($_SERVER["REQUEST_URI"]) ? $scriptName = $_SERVER["REQUEST_URI"] : $scriptName = $_SERVER["PHP_SELF"];
        $rootpath = @preg_replace("/\/(I|i)nstall\/index\.php(.*)$/", "/", $scriptName);
        $sys_protocal = isset($_SERVER['SERVER_PORT']) && $_SERVER['SERVER_PORT'] == '443' ? 'https://' : 'http://';
        $domain = empty($_SERVER['HTTP_HOST']) ? $_SERVER['HTTP_HOST'] : $_SERVER['SERVER_NAME'];
        if ((int) $_SERVER['SERVER_PORT'] != 80) {
            $domain .= ":" . $_SERVER['SERVER_PORT'];
        }
        $domain = $sys_protocal . $domain . $rootpath;
        $parse_url = parse_url($domain);
        $parse_url['path'] = str_replace('install.php', '', $parse_url['path']);
        $this->assign('parse_url', $parse_url);
        $this->display();
    }

    //数据库安装
    public function step_4() {
        $this->assign('data', json_encode($_POST));
        $this->display();
    }

    //安装完成
    public function step_5() {
        @unlink(RUNTIME_PATH . APP_MODE . '~runtime.php');
        @touch(MODULE_PATH . 'install.lock');
        $this->display();
    }

    //数据库安装
    public function mysql() {
        $n = intval($_GET['n']);

        $arr = array();

        $dbHost = trim($_POST['dbhost']);
        $dbPort = trim($_POST['dbport']);
        $dbName = trim($_POST['dbname']);
        $dbHost = empty($dbPort) || $dbPort == 3306 ? $dbHost : $dbHost . ':' . $dbPort;
        $dbUser = trim($_POST['dbuser']);
        $dbPwd = trim($_POST['dbpw']);
        $dbPrefix = empty($_POST['dbprefix']) ? 'think_' : trim($_POST['dbprefix']);

        $username = trim($_POST['manager']);
        $password = trim($_POST['manager_pwd']);
        //网站名称
        $site_name = addslashes(trim($_POST['sitename']));
        //网站域名
        $site_url = trim($_POST['siteurl']);
        $_site_url = parse_url($site_url);
        //附件地址
        $sitefileurl = $_site_url['path'] . "d/file/";
        //描述
        $seo_description = trim($_POST['siteinfo']);
        //关键词
        $seo_keywords = trim($_POST['sitekeywords']);
        //测试数据
        $testdata = (int) $_POST['testdata'];
        //邮箱地址
        $siteemail = trim($_POST['manager_email']);

        $conn = @ mysql_connect($dbHost, $dbUser, $dbPwd);
        if (!$conn) {
            $arr['msg'] = "连接数据库失败!";
            echo json_encode($arr);
            exit;
        }
        mysql_query("SET NAMES 'utf8'"); //,character_set_client=binary,sql_mode='';
        $version = mysql_get_server_info($conn);
        if ($version < 5.0) {
            $arr['msg'] = '数据库版本太低!';
            echo json_encode($arr);
            exit;
        }

        if (!mysql_select_db($dbName, $conn)) {
            //创建数据时同时设置编码
            if (!mysql_query("CREATE DATABASE IF NOT EXISTS `" . $dbName . "` DEFAULT CHARACTER SET utf8;", $conn)) {
                $arr['msg'] = '数据库 ' . $dbName . ' 不存在，也没权限创建新的数据库！';
                echo json_encode($arr);
                exit;
            }
            if (empty($n)) {
                $arr['n'] = 1;
                $arr['msg'] = "成功创建数据库:{$dbName}<br>";
                echo json_encode($arr);
                exit;
            }
            mysql_select_db($dbName, $conn);
        }

        //读取数据文件
        $sqldata = file_get_contents(MODULE_PATH . 'Data/shuipfblog.sql');
        //读取测试数据
        if ($testdata) {
            $sqldataDemo = file_get_contents(MODULE_PATH . 'Data/shuipfblog_demo.sql');
            $sqldata = $sqldata . "\r\n" . $sqldataDemo;
        } else {
            //不加测试数据的时候，删除d目录的文件
            try {
                $Dir = new \Dir();
                $Dir->delDir(SITE_PATH . 'd/file/contents/');
            } catch (Exception $exc) {

            }
        }
        $sqlFormat = sql_split($sqldata, $dbPrefix);


        /**
          执行SQL语句
         */
        $counts = count($sqlFormat);

        for ($i = $n; $i < $counts; $i++) {
            $sql = trim($sqlFormat[$i]);

            if (strstr($sql, 'CREATE TABLE')) {
                preg_match('/CREATE TABLE `([^ ]*)`/', $sql, $matches);
                mysql_query("DROP TABLE IF EXISTS `$matches[1]");
                $ret = mysql_query($sql);
                if ($ret) {
                    $message = '<li><span class="correct_span">&radic;</span>创建数据表' . $matches[1] . '，完成</li> ';
                } else {
                    $message = '<li><span class="correct_span error_span">&radic;</span>创建数据表' . $matches[1] . '，失败</li>';
                }
                $i++;
                $arr = array('n' => $i, 'msg' => $message);
                echo json_encode($arr);
                exit;
            } else {
                $ret = mysql_query($sql);
                $message = '';
                $arr = array('n' => $i, 'msg' => $message);
                //echo json_encode($arr); exit;
            }
        }

        if ($i == 999999)
            exit;
        //更新配置信息
        mysql_query("UPDATE `{$dbPrefix}config` SET  `value` = '$site_name' WHERE varname='sitename'");
        mysql_query("UPDATE `{$dbPrefix}config` SET  `value` = '$site_url' WHERE varname='siteurl' ");
        mysql_query("UPDATE `{$dbPrefix}config` SET  `value` = '$sitefileurl' WHERE varname='sitefileurl' ");
        mysql_query("UPDATE `{$dbPrefix}config` SET  `value` = '$seo_description' WHERE varname='siteinfo'");
        mysql_query("UPDATE `{$dbPrefix}config` SET  `value` = '$seo_keywords' WHERE varname='sitekeywords'");
        mysql_query("UPDATE `{$dbPrefix}config` SET  `value` = '$siteemail' WHERE varname='siteemail'");

        //读取配置文件，并替换真实配置数据
        $strConfig = file_get_contents(MODULE_PATH . 'Data/config.php');
        $strConfig = str_replace('#DB_HOST#', $dbHost, $strConfig);
        $strConfig = str_replace('#DB_NAME#', $dbName, $strConfig);
        $strConfig = str_replace('#DB_USER#', $dbUser, $strConfig);
        $strConfig = str_replace('#DB_PWD#', $dbPwd, $strConfig);
        $strConfig = str_replace('#DB_PORT#', $dbPort, $strConfig);
        $strConfig = str_replace('#DB_PREFIX#', $dbPrefix, $strConfig);
        $strConfig = str_replace('#AUTHCODE#', genRandomString(18), $strConfig);
        $strConfig = str_replace('#COOKIE_PREFIX#', genRandomString(3) . "_", $strConfig);
        $strConfig = str_replace('#DATA_CACHE_PREFIX#', genRandomString(3) . "_", $strConfig);
        @file_put_contents(CONF_PATH . 'dataconfig.php', $strConfig);

        //插入管理员
        //生成随机认证码
        $verify = genRandomString(6);
        $time = time();
        $ip = get_client_ip();
        $password = md5($password . md5($verify));
        $query = "INSERT INTO `{$dbPrefix}user` VALUES ('1', '{$username}', '未知', '{$password}', '', '{$time}', '0.0.0.0', '{$verify}', 'admin@abc3210.com', '备注信息', '{$time}', '{$time}', '1', '1', '');";
        mysql_query($query);

        $message = '成功添加管理员<br />成功写入配置文件<br>安装完成．';
        $arr = array('n' => 999999, 'msg' => $message);
        echo json_encode($arr);
        exit;
    }

    //测试数据库
    public function testdbpwd() {
        $dbHost = $_POST['dbHost'] . ':' . $_POST['dbPort'];
        $conn = @mysql_connect($dbHost, $_POST['dbUser'], $_POST['dbPwd']);
        if ($conn) {
            exit("1");
        } else {
            exit("");
        }
    }

}
