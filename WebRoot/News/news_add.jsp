<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/news.css" />
<div id="newsAddDiv">
	<form id="newsAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">新闻类别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="news_newsClassObj_newsClassId" name="news.newsClassObj.newsClassId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">新闻标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="news_newsTitle" name="news.newsTitle" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">新闻图片:</span>
			<span class="inputControl">
				<input id="newsPhotoFile" name="newsPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">新闻内容:</span>
			<span class="inputControl">
				<script name="news.content" id="news_content" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">新闻来源:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="news_comFrom" name="news.comFrom" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">浏览次数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="news_hitNum" name="news.hitNum" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">添加时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="news_addTime" name="news.addTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="newsAddButton" class="easyui-linkbutton">添加</a>
			<a id="newsClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/News/js/news_add.js"></script> 
