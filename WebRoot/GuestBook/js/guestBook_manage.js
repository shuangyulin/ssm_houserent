var guestBook_manage_tool = null; 
$(function () { 
	initGuestBookManageTool(); //建立GuestBook管理对象
	guestBook_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#guestBook_manage").datagrid({
		url : 'GuestBook/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "guestBookId",
		sortOrder : "desc",
		toolbar : "#guestBook_manage_tool",
		columns : [[
			{
				field : "title",
				title : "留言标题",
				width : 140,
			},
			{
				field : "content",
				title : "留言内容",
				width : 140,
			},
			{
				field : "userObj",
				title : "留言人",
				width : 140,
			},
			{
				field : "addTime",
				title : "留言时间",
				width : 140,
			},
		]],
	});

	$("#guestBookEditDiv").dialog({
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
				if ($("#guestBookEditForm").form("validate")) {
					//验证表单 
					if(!$("#guestBookEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#guestBookEditForm").form({
						    url:"GuestBook/" + $("#guestBook_guestBookId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#guestBookEditDiv").dialog("close");
			                        guestBook_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#guestBookEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#guestBookEditDiv").dialog("close");
				$("#guestBookEditForm").form("reset"); 
			},
		}],
	});
});

function initGuestBookManageTool() {
	guestBook_manage_tool = {
		init: function() {
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"realName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",realName:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#guestBook_manage").datagrid("reload");
		},
		redo : function () {
			$("#guestBook_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#guestBook_manage").datagrid("options").queryParams;
			queryParams["title"] = $("#title").val();
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			$("#guestBook_manage").datagrid("options").queryParams=queryParams; 
			$("#guestBook_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#guestBookQueryForm").form({
			    url:"GuestBook/OutToExcel",
			});
			//提交表单
			$("#guestBookQueryForm").submit();
		},
		remove : function () {
			var rows = $("#guestBook_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var guestBookIds = [];
						for (var i = 0; i < rows.length; i ++) {
							guestBookIds.push(rows[i].guestBookId);
						}
						$.ajax({
							type : "POST",
							url : "GuestBook/deletes",
							data : {
								guestBookIds : guestBookIds.join(","),
							},
							beforeSend : function () {
								$("#guestBook_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#guestBook_manage").datagrid("loaded");
									$("#guestBook_manage").datagrid("load");
									$("#guestBook_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#guestBook_manage").datagrid("loaded");
									$("#guestBook_manage").datagrid("load");
									$("#guestBook_manage").datagrid("unselectAll");
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
			var rows = $("#guestBook_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "GuestBook/" + rows[0].guestBookId +  "/update",
					type : "get",
					data : {
						//guestBookId : rows[0].guestBookId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (guestBook, response, status) {
						$.messager.progress("close");
						if (guestBook) { 
							$("#guestBookEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
