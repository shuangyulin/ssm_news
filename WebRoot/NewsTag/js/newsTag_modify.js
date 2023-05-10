$(function () {
	$.ajax({
		url : "NewsTag/" + $("#newsTag_tagId_edit").val() + "/update",
		type : "get",
		data : {
			//tagId : $("#newsTag_tagId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (newsTag, response, status) {
			$.messager.progress("close");
			if (newsTag) { 
				$("#newsTag_tagId_edit").val(newsTag.tagId);
				$("#newsTag_tagId_edit").validatebox({
					required : true,
					missingMessage : "请输入标记id",
					editable: false
				});
				$("#newsTag_newsObj_newsId_edit").combobox({
					url:"News/listAll",
					valueField:"newsId",
					textField:"newsTitle",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#newsTag_newsObj_newsId_edit").combobox("select", newsTag.newsObjPri);
						//var data = $("#newsTag_newsObj_newsId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#newsTag_newsObj_newsId_edit").combobox("select", data[0].newsId);
						//}
					}
				});
				$("#newsTag_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#newsTag_userObj_user_name_edit").combobox("select", newsTag.userObjPri);
						//var data = $("#newsTag_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#newsTag_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#newsTag_newsState_edit").val(newsTag.newsState);
				$("#newsTag_newsState_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入新闻状态",
					invalidMessage : "新闻状态输入不对",
				});
				$("#newsTag_tagTime_edit").val(newsTag.tagTime);
				$("#newsTag_tagTime_edit").validatebox({
					required : true,
					missingMessage : "请输入标记时间",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#newsTagModifyButton").click(function(){ 
		if ($("#newsTagEditForm").form("validate")) {
			$("#newsTagEditForm").form({
			    url:"NewsTag/" +  $("#newsTag_tagId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#newsTagEditForm").form("validate"))  {
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#newsTagEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
