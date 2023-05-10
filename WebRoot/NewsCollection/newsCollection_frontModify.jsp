<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.NewsCollection" %>
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
    NewsCollection newsCollection = (NewsCollection)request.getAttribute("newsCollection");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改新闻收藏信息</TITLE>
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
  		<li class="active">新闻收藏信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="newsCollectionEditForm" id="newsCollectionEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="newsCollection_collectionId_edit" class="col-md-3 text-right">收藏id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="newsCollection_collectionId_edit" name="newsCollection.collectionId" class="form-control" placeholder="请输入收藏id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="newsCollection_newsObj_newsId_edit" class="col-md-3 text-right">被收藏新闻:</label>
		  	 <div class="col-md-9">
			    <select id="newsCollection_newsObj_newsId_edit" name="newsCollection.newsObj.newsId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="newsCollection_userObj_user_name_edit" class="col-md-3 text-right">收藏人:</label>
		  	 <div class="col-md-9">
			    <select id="newsCollection_userObj_user_name_edit" name="newsCollection.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="newsCollection_collectTime_edit" class="col-md-3 text-right">收藏时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="newsCollection_collectTime_edit" name="newsCollection.collectTime" class="form-control" placeholder="请输入收藏时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxNewsCollectionModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#newsCollectionEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改新闻收藏界面并初始化数据*/
function newsCollectionEdit(collectionId) {
	$.ajax({
		url :  basePath + "NewsCollection/" + collectionId + "/update",
		type : "get",
		dataType: "json",
		success : function (newsCollection, response, status) {
			if (newsCollection) {
				$("#newsCollection_collectionId_edit").val(newsCollection.collectionId);
				$.ajax({
					url: basePath + "News/listAll",
					type: "get",
					success: function(newss,response,status) { 
						$("#newsCollection_newsObj_newsId_edit").empty();
						var html="";
		        		$(newss).each(function(i,news){
		        			html += "<option value='" + news.newsId + "'>" + news.newsTitle + "</option>";
		        		});
		        		$("#newsCollection_newsObj_newsId_edit").html(html);
		        		$("#newsCollection_newsObj_newsId_edit").val(newsCollection.newsObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#newsCollection_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#newsCollection_userObj_user_name_edit").html(html);
		        		$("#newsCollection_userObj_user_name_edit").val(newsCollection.userObjPri);
					}
				});
				$("#newsCollection_collectTime_edit").val(newsCollection.collectTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交新闻收藏信息表单给服务器端修改*/
function ajaxNewsCollectionModify() {
	$.ajax({
		url :  basePath + "NewsCollection/" + $("#newsCollection_collectionId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#newsCollectionEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#newsCollectionQueryForm").submit();
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
    newsCollectionEdit("<%=request.getParameter("collectionId")%>");
 })
 </script> 
</body>
</html>

