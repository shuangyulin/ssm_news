<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newsComment.css" /> 

<div id="newsComment_manage"></div>
<div id="newsComment_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="newsComment_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="newsComment_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="newsComment_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="newsComment_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="newsComment_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="newsCommentQueryForm" method="post">
			被评新闻：<input class="textbox" type="text" id="newsObj_newsId_query" name="newsObj.newsId" style="width: auto"/>
			评论人：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="newsComment_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="newsCommentEditDiv">
	<form id="newsCommentEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">评论id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsComment_commentId_edit" name="newsComment.commentId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">被评新闻:</span>
			<span class="inputControl">
				<input class="textbox"  id="newsComment_newsObj_newsId_edit" name="newsComment.newsObj.newsId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">评论人:</span>
			<span class="inputControl">
				<input class="textbox"  id="newsComment_userObj_user_name_edit" name="newsComment.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">评论内容:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsComment_content_edit" name="newsComment.content" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">评论时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsComment_commentTime_edit" name="newsComment.commentTime" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="NewsComment/js/newsComment_manage.js"></script> 
