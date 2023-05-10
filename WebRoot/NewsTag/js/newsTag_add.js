$(function () {
	$("#newsTag_newsObj_newsId").combobox({
	    url:'News/listAll',
	    valueField: "newsId",
	    textField: "newsTitle",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#newsTag_newsObj_newsId").combobox("getData"); 
            if (data.length > 0) {
                $("#newsTag_newsObj_newsId").combobox("select", data[0].newsId);
            }
        }
	});
	$("#newsTag_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#newsTag_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#newsTag_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#newsTag_newsState").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入新闻状态',
		invalidMessage : '新闻状态输入不对',
	});

	$("#newsTag_tagTime").validatebox({
		required : true, 
		missingMessage : '请输入标记时间',
	});

	//单击添加按钮
	$("#newsTagAddButton").click(function () {
		//验证表单 
		if(!$("#newsTagAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#newsTagAddForm").form({
			    url:"NewsTag/add",
			    onSubmit: function(){
					if($("#newsTagAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#newsTagAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#newsTagAddForm").submit();
		}
	});

	//单击清空按钮
	$("#newsTagClearButton").click(function () { 
		$("#newsTagAddForm").form("clear"); 
	});
});
