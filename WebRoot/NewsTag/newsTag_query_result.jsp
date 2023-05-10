<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newsTag.css" /> 

<div id="newsTag_manage"></div>
<div id="newsTag_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="newsTag_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="newsTag_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="newsTag_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="newsTag_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="newsTag_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="newsTagQueryForm" method="post">
			被标记新闻：<input class="textbox" type="text" id="newsObj_newsId_query" name="newsObj.newsId" style="width: auto"/>
			标记的用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="newsTag_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="newsTagEditDiv">
	<form id="newsTagEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">标记id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsTag_tagId_edit" name="newsTag.tagId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">被标记新闻:</span>
			<span class="inputControl">
				<input class="textbox"  id="newsTag_newsObj_newsId_edit" name="newsTag.newsObj.newsId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">标记的用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="newsTag_userObj_user_name_edit" name="newsTag.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">新闻状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsTag_newsState_edit" name="newsTag.newsState" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">标记时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsTag_tagTime_edit" name="newsTag.tagTime" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="NewsTag/js/newsTag_manage.js"></script> 
