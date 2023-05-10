$(function () {
	$.ajax({
		url : "NewsClass/" + $("#newsClass_newsClassId_edit").val() + "/update",
		type : "get",
		data : {
			//newsClassId : $("#newsClass_newsClassId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (newsClass, response, status) {
			$.messager.progress("close");
			if (newsClass) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#newsClassModifyButton").click(function(){ 
		if ($("#newsClassEditForm").form("validate")) {
			$("#newsClassEditForm").form({
			    url:"NewsClass/" +  $("#newsClass_newsClassId_edit").val() + "/update",
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
			$("#newsClassEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
