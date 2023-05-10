$(function () {
	$.ajax({
		url : "GuestBook/" + $("#guestBook_guestBookId_edit").val() + "/update",
		type : "get",
		data : {
			//guestBookId : $("#guestBook_guestBookId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (guestBook, response, status) {
			$.messager.progress("close");
			if (guestBook) { 
				$("#guestBook_guestBookId_edit").val(guestBook.guestBookId);
				$("#guestBook_guestBookId_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#guestBook_title_edit").val(guestBook.title);
				$("#guestBook_title_edit").validatebox({
					required : true,
					missingMessage : "请输入留言标题",
				});
				$("#guestBook_content_edit").val(guestBook.content);
				$("#guestBook_content_edit").validatebox({
					required : true,
					missingMessage : "请输入留言内容",
				});
				$("#guestBook_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"realName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#guestBook_userObj_user_name_edit").combobox("select", guestBook.userObjPri);
						//var data = $("#guestBook_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#guestBook_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#guestBook_addTime_edit").val(guestBook.addTime);
				$("#guestBook_addTime_edit").validatebox({
					required : true,
					missingMessage : "请输入留言时间",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#guestBookModifyButton").click(function(){ 
		if ($("#guestBookEditForm").form("validate")) {
			$("#guestBookEditForm").form({
			    url:"GuestBook/" +  $("#guestBook_guestBookId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#guestBookEditForm").form("validate"))  {
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
			$("#guestBookEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
