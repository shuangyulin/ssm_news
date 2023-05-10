var newsClass_manage_tool = null; 
$(function () { 
	initNewsClassManageTool(); //建立NewsClass管理对象
	newsClass_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#newsClass_manage").datagrid({
		url : 'NewsClass/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "newsClassId",
		sortOrder : "desc",
		toolbar : "#newsClass_manage_tool",
		columns : [[
			{
				field : "newsClassId",
				title : "分类id",
				width : 70,
			},
			{
				field : "newsClassName",
				title : "分类名称",
				width : 140,
			},
		]],
	});

	$("#newsClassEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#newsClassEditForm").form("validate")) {
					//验证表单 
					if(!$("#newsClassEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#newsClassEditForm").form({
						    url:"NewsClass/" + $("#newsClass_newsClassId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#newsClassEditForm").form("validate"))  {
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
			                        $("#newsClassEditDiv").dialog("close");
			                        newsClass_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#newsClassEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#newsClassEditDiv").dialog("close");
				$("#newsClassEditForm").form("reset"); 
			},
		}],
	});
});

function initNewsClassManageTool() {
	newsClass_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#newsClass_manage").datagrid("reload");
		},
		redo : function () {
			$("#newsClass_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#newsClass_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#newsClassQueryForm").form({
			    url:"NewsClass/OutToExcel",
			});
			//提交表单
			$("#newsClassQueryForm").submit();
		},
		remove : function () {
			var rows = $("#newsClass_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var newsClassIds = [];
						for (var i = 0; i < rows.length; i ++) {
							newsClassIds.push(rows[i].newsClassId);
						}
						$.ajax({
							type : "POST",
							url : "NewsClass/deletes",
							data : {
								newsClassIds : newsClassIds.join(","),
							},
							beforeSend : function () {
								$("#newsClass_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#newsClass_manage").datagrid("loaded");
									$("#newsClass_manage").datagrid("load");
									$("#newsClass_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#newsClass_manage").datagrid("loaded");
									$("#newsClass_manage").datagrid("load");
									$("#newsClass_manage").datagrid("unselectAll");
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
			var rows = $("#newsClass_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "NewsClass/" + rows[0].newsClassId +  "/update",
					type : "get",
					data : {
						//newsClassId : rows[0].newsClassId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (newsClass, response, status) {
						$.messager.progress("close");
						if (newsClass) { 
							$("#newsClassEditDiv").dialog("open");
							$("#newsClass_newsClassId_edit").val(newsClass.newsClassId);
							$("#newsClass_newsClassId_edit").validatebox({
								required : true,
								missingMessage : "请输入分类id",
								editable: false
							});
							$("#newsClass_newsClassName_edit").val(newsClass.newsClassName);
							$("#newsClass_newsClassName_edit").validatebox({
								required : true,
								missingMessage : "请输入分类名称",
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
