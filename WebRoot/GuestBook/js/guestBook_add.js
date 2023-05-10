$(function () {
	$("#guestBook_title").validatebox({
		required : true, 
		missingMessage : '请输入留言标题',
	});

	$("#guestBook_content").validatebox({
		required : true, 
		missingMessage : '请输入留言内容',
	});

	$("#guestBook_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "realName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#guestBook_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#guestBook_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#guestBook_addTime").validatebox({
		required : true, 
		missingMessage : '请输入留言时间',
	});

	//单击添加按钮
	$("#guestBookAddButton").click(function () {
		//验证表单 
		if(!$("#guestBookAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#guestBookAddForm").form({
			    url:"GuestBook/add",
			    onSubmit: function(){
					if($("#guestBookAddForm").form("validate"))  { 
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
                        $("#guestBookAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#guestBookAddForm").submit();
		}
	});

	//单击清空按钮
	$("#guestBookClearButton").click(function () { 
		$("#guestBookAddForm").form("clear"); 
	});
});
