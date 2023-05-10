<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/zambia.css" />
<div id="zambia_editDiv">
	<form id="zambiaEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">赞id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zambia_zambiaId_edit" name="zambia.zambiaId" value="<%=request.getParameter("zambiaId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="zambiaModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Zambia/js/zambia_modify.js"></script> 
