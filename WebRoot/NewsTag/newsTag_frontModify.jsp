<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.NewsTag" %>
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
    NewsTag newsTag = (NewsTag)request.getAttribute("newsTag");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改新闻标记信息</TITLE>
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
  		<li class="active">新闻标记信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="newsTagEditForm" id="newsTagEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="newsTag_tagId_edit" class="col-md-3 text-right">标记id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="newsTag_tagId_edit" name="newsTag.tagId" class="form-control" placeholder="请输入标记id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="newsTag_newsObj_newsId_edit" class="col-md-3 text-right">被标记新闻:</label>
		  	 <div class="col-md-9">
			    <select id="newsTag_newsObj_newsId_edit" name="newsTag.newsObj.newsId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="newsTag_userObj_user_name_edit" class="col-md-3 text-right">标记的用户:</label>
		  	 <div class="col-md-9">
			    <select id="newsTag_userObj_user_name_edit" name="newsTag.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="newsTag_newsState_edit" class="col-md-3 text-right">新闻状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="newsTag_newsState_edit" name="newsTag.newsState" class="form-control" placeholder="请输入新闻状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="newsTag_tagTime_edit" class="col-md-3 text-right">标记时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="newsTag_tagTime_edit" name="newsTag.tagTime" class="form-control" placeholder="请输入标记时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxNewsTagModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#newsTagEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改新闻标记界面并初始化数据*/
function newsTagEdit(tagId) {
	$.ajax({
		url :  basePath + "NewsTag/" + tagId + "/update",
		type : "get",
		dataType: "json",
		success : function (newsTag, response, status) {
			if (newsTag) {
				$("#newsTag_tagId_edit").val(newsTag.tagId);
				$.ajax({
					url: basePath + "News/listAll",
					type: "get",
					success: function(newss,response,status) { 
						$("#newsTag_newsObj_newsId_edit").empty();
						var html="";
		        		$(newss).each(function(i,news){
		        			html += "<option value='" + news.newsId + "'>" + news.newsTitle + "</option>";
		        		});
		        		$("#newsTag_newsObj_newsId_edit").html(html);
		        		$("#newsTag_newsObj_newsId_edit").val(newsTag.newsObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#newsTag_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#newsTag_userObj_user_name_edit").html(html);
		        		$("#newsTag_userObj_user_name_edit").val(newsTag.userObjPri);
					}
				});
				$("#newsTag_newsState_edit").val(newsTag.newsState);
				$("#newsTag_tagTime_edit").val(newsTag.tagTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交新闻标记信息表单给服务器端修改*/
function ajaxNewsTagModify() {
	$.ajax({
		url :  basePath + "NewsTag/" + $("#newsTag_tagId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#newsTagEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#newsTagQueryForm").submit();
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
    newsTagEdit("<%=request.getParameter("tagId")%>");
 })
 </script> 
</body>
</html>

