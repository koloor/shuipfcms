<?php if (!defined('SHUIPF_VERSION')) exit(); ?>
<Admintemplate file="Common/Head"/>
<body>
<div class="wrap J_check_wrap">
  <Admintemplate file="Common/Nav"/>
  <div class="table_list">
  <form name="myform" action="{:U("Rbac/listorders")}" method="post">
    <table width="100%" cellspacing="0">
      <thead>
        <tr>
          <td width="20">ID</td>
          <td>角色名称</td>
          <td width="200" align='center'>角色描述</td>
          <td width="50"   align='center'>状态</td>
          <td width="250" align='center'>管理操作</td>
        </tr>
      </thead>
      <tbody>
        {$role}
      </tbody>
    </table>
  </form>
  </div>
</div>
<script src="{$config_siteurl}statics/js/common.js"></script>
</body>
</html>