<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newsClass.css" />
<div id="newsClass_editDiv">
	<form id="newsClassEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">分类id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsClass_newsClassId_edit" name="newsClass.newsClassId" value="<%=request.getParameter("newsClassId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">分类名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsClass_newsClassName_edit" name="newsClass.newsClassName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="newsClassModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/NewsClass/js/newsClass_modify.js"></script> 
