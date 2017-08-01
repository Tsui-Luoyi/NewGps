<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!--头部  -->
 <!-- 标题 -->
              <header class="container-fluid" style="padding:0">
                     <div class="navbar navbar-default bg-blue navPos" role="navigation">
                      <div class="navbar-header">
                          <!-- 小屏幕三个横线 -->
                          <button type="button" class="navbar-toggle in" data-toggle="collapse"
                          data-target="#navMenu">
                          <span class="sr-only">切换导航</span>
                          <span class="icon-bar"></span>
                          <span class="icon-bar"></span>
                          <span class="icon-bar"></span>
                   </button> 
                   <!-- logo -->
                   <a class="navbar-brand logo" href="#"><img src="imgs/jsd_50.png" class="img-responsive"  alt="logo"></a> 
            </div> 
              <div class="pull-left" id="comName">
                     <h1 class="hidden-sm hidden-xs ">金圣达电气信息技术有限公司</h1>
              </div>

            <!-- 登录用户管理 -->
            <div class="btn-group loginOut">
               <button class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                   <i class="glyphicon glyphicon-user"><strong class="hidden-sm hidden-xs">登录用户:</strong></i>
                   <span> admin24242424242</span>
                   <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                   <li><a href="#">修改资料</a></li>
                   <li class="divider"></li>
                   <li><a href="login.jsp">退出</a></li>
            </ul>
     </div>

     <!-- <div class=" pull-right hidden-xs" id="time">时间：2017.6.20 15:59:05</div> -->
     <!-- 导航内容 -->
     <div class="collapse navbar-collapse pull-right" id="navMenu">
        <ul class="nav nav-pills">
            <li class="active"><a href="#">管理中心</a></li>
            <li><a href="#">监控管理</a></li>
            <li><a href="#">统计报表</a></li>
            <li><a href="#">系统管理</a></li>
     </ul>
</div>
</div>   
</header>