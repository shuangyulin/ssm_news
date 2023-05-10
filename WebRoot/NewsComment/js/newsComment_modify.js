$(function () {
	$.ajax({
		url : "NewsComment/" + $("#newsComment_commentId_edit").val() + "/update",
		type : "get",
		data : {
			//commentId : $("#newsComment_commentId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (newsComment, response, status) {
			$.messager.progress("close");
			if (newsComment) { 
				$("#newsComment_commentId_edit").val(newsComment.commentId);
				$("#newsComment_commentId_edit").validatebox({
					required : true,
					missingMessage : "请输入评论id",
					editable: false
				});
				$("#newsComment_newsObj_newsId_edit").combobox({
					url:"News/listAll",
					valueField:"newsId",
					textField:"newsTitle",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#newsComment_newsObj_newsId_edit").combobox("select", newsComment.newsObjPri);
						//var data = $("#newsComment_newsObj_newsId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#newsComment_newsObj_newsId_edit").combobox("select", data[0].newsId);
						//}
					}
				});
				$("#newsComment_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#newsComment_userObj_user_name_edit").combobox("select", newsComment.userObjPri);
						//var data = $("#newsComment_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#newsComment_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#newsComment_content_edit").val(newsComment.content);
				$("#newsComment_content_edit").validatebox({
					required : true,
					missingMessage : "请输入评论内容",
				});
				$("#newsComment_commentTime_edit").val(newsComment.commentTime);
				$("#newsComment_commentTime_edit").validatebox({
					required : true,
					missingMessage : "请输入评论时间",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#newsCommentModifyButton").click(function(){ 
		if ($("#newsCommentEditForm").form("validate")) {
			$("#newsCommentEditForm").form({
			    url:"NewsComment/" +  $("#newsComment_commentId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#newsCommentEditForm").form("validate"))  {
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
			$("#newsCommentEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
