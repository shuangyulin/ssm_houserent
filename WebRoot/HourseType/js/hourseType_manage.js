var hourseType_manage_tool = null; 
$(function () { 
	initHourseTypeManageTool(); //建立HourseType管理对象
	hourseType_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#hourseType_manage").datagrid({
		url : 'HourseType/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "typeId",
		sortOrder : "desc",
		toolbar : "#hourseType_manage_tool",
		columns : [[
			{
				field : "typeId",
				title : "类别编号",
				width : 70,
			},
			{
				field : "typeName",
				title : "房屋类型",
				width : 140,
			},
		]],
	});

	$("#hourseTypeEditDiv").dialog({
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
				if ($("#hourseTypeEditForm").form("validate")) {
					//验证表单 
					if(!$("#hourseTypeEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#hourseTypeEditForm").form({
						    url:"HourseType/" + $("#hourseType_typeId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#hourseTypeEditForm").form("validate"))  {
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
			                        $("#hourseTypeEditDiv").dialog("close");
			                        hourseType_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#hourseTypeEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#hourseTypeEditDiv").dialog("close");
				$("#hourseTypeEditForm").form("reset"); 
			},
		}],
	});
});

function initHourseTypeManageTool() {
	hourseType_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#hourseType_manage").datagrid("reload");
		},
		redo : function () {
			$("#hourseType_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#hourseType_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#hourseTypeQueryForm").form({
			    url:"HourseType/OutToExcel",
			});
			//提交表单
			$("#hourseTypeQueryForm").submit();
		},
		remove : function () {
			var rows = $("#hourseType_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var typeIds = [];
						for (var i = 0; i < rows.length; i ++) {
							typeIds.push(rows[i].typeId);
						}
						$.ajax({
							type : "POST",
							url : "HourseType/deletes",
							data : {
								typeIds : typeIds.join(","),
							},
							beforeSend : function () {
								$("#hourseType_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#hourseType_manage").datagrid("loaded");
									$("#hourseType_manage").datagrid("load");
									$("#hourseType_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#hourseType_manage").datagrid("loaded");
									$("#hourseType_manage").datagrid("load");
									$("#hourseType_manage").datagrid("unselectAll");
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
			var rows = $("#hourseType_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "HourseType/" + rows[0].typeId +  "/update",
					type : "get",
					data : {
						//typeId : rows[0].typeId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (hourseType, response, status) {
						$.messager.progress("close");
						if (hourseType) { 
							$("#hourseTypeEditDiv").dialog("open");
							$("#hourseType_typeId_edit").val(hourseType.typeId);
							$("#hourseType_typeId_edit").validatebox({
								required : true,
								missingMessage : "请输入类别编号",
								editable: false
							});
							$("#hourseType_typeName_edit").val(hourseType.typeName);
							$("#hourseType_typeName_edit").validatebox({
								required : true,
								missingMessage : "请输入房屋类型",
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
