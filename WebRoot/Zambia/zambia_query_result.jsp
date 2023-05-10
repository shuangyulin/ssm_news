<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/zambia.css" /> 

<div id="zambia_manage"></div>
<div id="zambia_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="zambia_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="zambia_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="zambia_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="zambia_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="zambia_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="zambiaQueryForm" method="post">
			被赞新闻：<input class="textbox" type="text" id="newsObj_newsId_query" name="newsObj.newsId" style="width: auto"/>
			用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="zambia_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="zambiaEditDiv">
	<form id="zambiaEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">赞id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zambia_zambiaId_edit" name="zambia.zambiaId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">被赞新闻:</span>
			<span class="inputControl">
				<input class="textbox"  id="zambia_newsObj_newsId_edit" name="zambia.newsObj.newsId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="zambia_userObj_user_name_edit" name="zambia.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">被赞时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zambia_zambiaTime_edit" name="zambia.zambiaTime" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Zambia/js/zambia_manage.js"></script> 
