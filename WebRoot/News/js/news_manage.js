var news_manage_tool = null; 
$(function () { 
	initNewsManageTool(); //建立News管理对象
	news_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#news_manage").datagrid({
		url : 'News/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "newsId",
		sortOrder : "desc",
		toolbar : "#news_manage_tool",
		columns : [[
			{
				field : "newsId",
				title : "新闻id",
				width : 70,
			},
			{
				field : "newsClassObj",
				title : "新闻类别",
				width : 140,
			},
			{
				field : "newsTitle",
				title : "新闻标题",
				width : 140,
			},
			{
				field : "newsPhoto",
				title : "新闻图片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "comFrom",
				title : "新闻来源",
				width : 140,
			},
			{
				field : "hitNum",
				title : "浏览次数",
				width : 70,
			},
			{
				field : "addTime",
				title : "添加时间",
				width : 140,
			},
		]],
	});

	$("#newsEditDiv").dialog({
		title : "修改管理",
		top: "10px",
		width : 1000,
		height : 600,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#newsEditForm").form("validate")) {
					//验证表单 
					if(!$("#newsEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#newsEditForm").form({
						    url:"News/" + $("#news_newsId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#newsEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#newsEditDiv").dialog("close");
			                        news_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#newsEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#newsEditDiv").dialog("close");
				$("#newsEditForm").form("reset"); 
			},
		}],
	});
});

function initNewsManageTool() {
	news_manage_tool = {
		init: function() {
			$.ajax({
				url : "NewsClass/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#newsClassObj_newsClassId_query").combobox({ 
					    valueField:"newsClassId",
					    textField:"newsClassName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{newsClassId:0,newsClassName:"不限制"});
					$("#newsClassObj_newsClassId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#news_manage").datagrid("reload");
		},
		redo : function () {
			$("#news_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#news_manage").datagrid("options").queryParams;
			queryParams["newsClassObj.newsClassId"] = $("#newsClassObj_newsClassId_query").combobox("getValue");
			queryParams["newsTitle"] = $("#newsTitle").val();
			queryParams["comFrom"] = $("#comFrom").val();
			queryParams["addTime"] = $("#addTime").val();
			$("#news_manage").datagrid("options").queryParams=queryParams; 
			$("#news_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#newsQueryForm").form({
			    url:"News/OutToExcel",
			});
			//提交表单
			$("#newsQueryForm").submit();
		},
		remove : function () {
			var rows = $("#news_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var newsIds = [];
						for (var i = 0; i < rows.length; i ++) {
							newsIds.push(rows[i].newsId);
						}
						$.ajax({
							type : "POST",
							url : "News/deletes",
							data : {
								newsIds : newsIds.join(","),
							},
							beforeSend : function () {
								$("#news_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#news_manage").datagrid("loaded");
									$("#news_manage").datagrid("load");
									$("#news_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#news_manage").datagrid("loaded");
									$("#news_manage").datagrid("load");
									$("#news_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#news_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "News/" + rows[0].newsId +  "/update",
					type : "get",
					data : {
						//newsId : rows[0].newsId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (news, response, status) {
						$.messager.progress("close");
						if (news) { 
							$("#newsEditDiv").dialog("open");
							$("#news_newsId_edit").val(news.newsId);
							$("#news_newsId_edit").validatebox({
								required : true,
								missingMessage : "请输入新闻id",
								editable: false
							});
							$("#news_newsClassObj_newsClassId_edit").combobox({
								url:"NewsClass/listAll",
							    valueField:"newsClassId",
							    textField:"newsClassName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#news_newsClassObj_newsClassId_edit").combobox("select", news.newsClassObjPri);
									//var data = $("#news_newsClassObj_newsClassId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#news_newsClassObj_newsClassId_edit").combobox("select", data[0].newsClassId);
						            //}
								}
							});
							$("#news_newsTitle_edit").val(news.newsTitle);
							$("#news_newsTitle_edit").validatebox({
								required : true,
								missingMessage : "请输入新闻标题",
							});
							$("#news_newsPhoto").val(news.newsPhoto);
							$("#news_newsPhotoImg").attr("src", news.newsPhoto);
							news_content_editor.setContent(news.content, false);
							$("#news_comFrom_edit").val(news.comFrom);
							$("#news_comFrom_edit").validatebox({
								required : true,
								missingMessage : "请输入新闻来源",
							});
							$("#news_hitNum_edit").val(news.hitNum);
							$("#news_hitNum_edit").validatebox({
								required : true,
								validType : "integer",
								missingMessage : "请输入浏览次数",
								invalidMessage : "浏览次数输入不对",
							});
							$("#news_addTime_edit").val(news.addTime);
							$("#news_addTime_edit").validatebox({
								required : true,
								missingMessage : "请输入添加时间",
							});
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
