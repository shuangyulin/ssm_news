<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.NewsTag" %>
<%@ page import="com.chengxusheji.po.News" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<NewsTag> newsTagList = (List<NewsTag>)request.getAttribute("newsTagList");
    //获取所有的newsObj信息
    List<News> newsList = (List<News>)request.getAttribute("newsList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    News newsObj = (News)request.getAttribute("newsObj");
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>新闻标记查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#newsTagListPanel" aria-controls="newsTagListPanel" role="tab" data-toggle="tab">新闻标记列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>NewsTag/newsTag_frontAdd.jsp" style="display:none;">添加新闻标记</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="newsTagListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>标记id</td><td>被标记新闻</td><td>标记的用户</td><td>新闻状态</td><td>标记时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<newsTagList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		NewsTag newsTag = newsTagList.get(i); //获取到新闻标记对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=newsTag.getTagId() %></td>
 											<td><%=newsTag.getNewsObj().getNewsTitle() %></td>
 											<td><%=newsTag.getUserObj().getName() %></td>
 											<td><%=newsTag.getNewsState() %></td>
 											<td><%=newsTag.getTagTime() %></td>
 											<td>
 												<a href="<%=basePath  %>NewsTag/<%=newsTag.getTagId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="newsTagEdit('<%=newsTag.getTagId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="newsTagDelete('<%=newsTag.getTagId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>新闻标记查询</h1>
		</div>
		<form name="newsTagQueryForm" id="newsTagQueryForm" action="<%=basePath %>NewsTag/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="newsObj_newsId">被标记新闻：</label>
                <select id="newsObj_newsId" name="newsObj.newsId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(News newsTemp:newsList) {
	 					String selected = "";
 					if(newsObj!=null && newsObj.getNewsId()!=null && newsObj.getNewsId().intValue()==newsTemp.getNewsId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=newsTemp.getNewsId() %>" <%=selected %>><%=newsTemp.getNewsTitle() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="userObj_user_name">标记的用户：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="newsTagEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;新闻标记信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#newsTagEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxNewsTagModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.newsTagQueryForm.currentPage.value = currentPage;
    document.newsTagQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.newsTagQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.newsTagQueryForm.currentPage.value = pageValue;
    documentnewsTagQueryForm.submit();
}

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
				$('#newsTagEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除新闻标记信息*/
function newsTagDelete(tagId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "NewsTag/deletes",
			data : {
				tagIds : tagId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#newsTagQueryForm").submit();
					//location.href= basePath + "NewsTag/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

