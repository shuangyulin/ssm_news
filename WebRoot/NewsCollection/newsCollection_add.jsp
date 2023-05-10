<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newsCollection.css" />
<div id="newsCollectionAddDiv">
	<form id="newsCollectionAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">被收藏新闻:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsCollection_newsObj_newsId" name="newsCollection.newsObj.newsId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">收藏人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsCollection_userObj_user_name" name="newsCollection.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">收藏时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsCollection_collectTime" name="newsCollection.collectTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="newsCollectionAddButton" class="easyui-linkbutton">添加</a>
			<a id="newsCollectionClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/NewsCollection/js/newsCollection_add.js"></script> 
