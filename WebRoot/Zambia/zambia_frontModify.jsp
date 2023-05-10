<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Zambia" %>
<%@ page import="com.chengxusheji.po.News" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的newsObj信息
    List<News> newsList = (List<News>)request.getAttribute("newsList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Zambia zambia = (Zambia)request.getAttribute("zambia");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改新闻赞信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">新闻赞信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="zambiaEditForm" id="zambiaEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="zambia_zambiaId_edit" class="col-md-3 text-right">赞id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="zambia_zambiaId_edit" name="zambia.zambiaId" class="form-control" placeholder="请输入赞id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="zambia_newsObj_newsId_edit" class="col-md-3 text-right">被赞新闻:</label>
		  	 <div class="col-md-9">
			    <select id="zambia_newsObj_newsId_edit" name="zambia.newsObj.newsId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="zambia_userObj_user_name_edit" class="col-md-3 text-right">用户:</label>
		  	 <div class="col-md-9">
			    <select id="zambia_userObj_user_name_edit" name="zambia.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="zambia_zambiaTime_edit" class="col-md-3 text-right">被赞时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="zambia_zambiaTime_edit" name="zambia.zambiaTime" class="form-control" placeholder="请输入被赞时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxZambiaModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#zambiaEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改新闻赞界面并初始化数据*/
function zambiaEdit(zambiaId) {
	$.ajax({
		url :  basePath + "Zambia/" + zambiaId + "/update",
		type : "get",
		dataType: "json",
		success : function (zambia, response, status) {
			if (zambia) {
				$("#zambia_zambiaId_edit").val(zambia.zambiaId);
				$.ajax({
					url: basePath + "News/listAll",
					type: "get",
					success: function(newss,response,status) { 
						$("#zambia_newsObj_newsId_edit").empty();
						var html="";
		        		$(newss).each(function(i,news){
		        			html += "<option value='" + news.newsId + "'>" + news.newsTitle + "</option>";
		        		});
		        		$("#zambia_newsObj_newsId_edit").html(html);
		        		$("#zambia_newsObj_newsId_edit").val(zambia.newsObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#zambia_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#zambia_userObj_user_name_edit").html(html);
		        		$("#zambia_userObj_user_name_edit").val(zambia.userObjPri);
					}
				});
				$("#zambia_zambiaTime_edit").val(zambia.zambiaTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交新闻赞信息表单给服务器端修改*/
function ajaxZambiaModify() {
	$.ajax({
		url :  basePath + "Zambia/" + $("#zambia_zambiaId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#zambiaEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#zambiaQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    zambiaEdit("<%=request.getParameter("zambiaId")%>");
 })
 </script> 
</body>
</html>

