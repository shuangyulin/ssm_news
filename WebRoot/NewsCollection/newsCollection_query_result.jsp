<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newsCollection.css" /> 

<div id="newsCollection_manage"></div>
<div id="newsCollection_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="newsCollection_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="newsCollection_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="newsCollection_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="newsCollection_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="newsCollection_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="newsCollectionQueryForm" method="post">
			被收藏新闻：<input class="textbox" type="text" id="newsObj_newsId_query" name="newsObj.newsId" style="width: auto"/>
			收藏人：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="newsCollection_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="newsCollectionEditDiv">
	<form id="newsCollectionEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">收藏id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsCollection_collectionId_edit" name="newsCollection.collectionId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">被收藏新闻:</span>
			<span class="inputControl">
				<input class="textbox"  id="newsCollection_newsObj_newsId_edit" name="newsCollection.newsObj.newsId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">收藏人:</span>
			<span class="inputControl">
				<input class="textbox"  id="newsCollection_userObj_user_name_edit" name="newsCollection.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">收藏时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsCollection_collectTime_edit" name="newsCollection.collectTime" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="NewsCollection/js/newsCollection_manage.js"></script> 
