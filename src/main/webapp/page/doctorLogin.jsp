<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" type="text/css" href="../css/login.css">
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script src="../js/login.js" type="text/javascript"></script>
</head>
<body>
<div class="title">
    <div class="tit">
        挂号系统医生登陆|
        <span class="tit_span">医院医生登录</span>
    </div>
</div><!--title结束-->
<div class="wrap">
    <div class="banner">
        <h2 class="banner_title  blue">医生登录</h2>
    </div>
    <div class="content" id="sAdminLogin">
        <form autocomplete="on" action="<%=path%>/doctors/login" method="post">
            <ul>
                <li>
                    <span class="shouji">账号:</span>
                    <div class="tips_div">
                        <input type="text" class="input_shouji" name="name" placeholder="请输入你的账号" required/>
                    </div>
                </li>
                <li>
                    <span class="shouji">密码:</span>
                    <div class="tips_div">
                        <input type="password" class="input_shouji" name="oid" placeholder="请输入密码" required=""/>
                    </div>
                </li>
                <li class="register_button">
                    <input type="submit" class="register_btn" value="登录"/>
                </li>
            </ul>
        </form>
        <div><span>${errorMsg.message}</span></div>
    </div>
</div>
</body>
</html>