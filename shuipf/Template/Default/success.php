<?php if (!defined('SHUIPF_VERSION')) exit(); ?>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>{$Config.sitename} - 提示信息</title>
<Admintemplate file="Admin/Common/Cssjs"/>
</head>
<body>
<div class="wrap">
  <div id="error_tips">
    <h2>{$msgTitle}</h2>
    <div class="error_cont">
      <ul>
        <li>{$message}</li>
      </ul>
      <div class="error_return"><a href="{$jumpUrl}" class="btn">返回</a></div>
    </div>
  </div>
</div>
<script src="{$config_siteurl}statics/js/common.js?v"></script>
<script language="javascript">
setTimeout(function(){
	location.href = '{$jumpUrl}';
},{$waitSecond});
</script>
</body>
</html>