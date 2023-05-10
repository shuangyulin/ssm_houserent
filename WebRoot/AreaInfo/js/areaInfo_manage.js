var areaInfo_manage_tool = null; 
$(function () { 
	initAreaInfoManageTool(); //建立AreaInfo管理对象
	areaInfo_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#areaInfo_manage").datagrid({
		url : 'AreaInfo/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "areaId",
		sortOrder : "desc",
		toolbar : "#areaInfo_manage_tool",
		columns : [[
			{
				field : "areaId",
				title : "记录编号",
				width : 70,
			},
			{
				field : "areaName",
				title : "区域名称",
				width : 140,
			},
		]],
	});

	$("#areaInfoEditDiv").dialog({
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
				if ($("#areaInfoEditForm").form("validate")) {
					//验证表单 
					if(!$("#areaInfoEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#areaInfoEditForm").form({
						    url:"AreaInfo/" + $("#areaInfo_areaId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#areaInfoEditForm").form("validate"))  {
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
			                        $("#areaInfoEditDiv").dialog("close");
			                        areaInfo_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#areaInfoEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#areaInfoEditDiv").dialog("close");
				$("#areaInfoEditForm").form("reset"); 
			},
		}],
	});
});

function initAreaInfoManageTool() {
	areaInfo_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#areaInfo_manage").datagrid("reload");
		},
		redo : function () {
			$("#areaInfo_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#areaInfo_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#areaInfoQueryForm").form({
			    url:"AreaInfo/OutToExcel",
			});
			//提交表单
			$("#areaInfoQueryForm").submit();
		},
		remove : function () {
			var rows = $("#areaInfo_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var areaIds = [];
						for (var i = 0; i < rows.length; i ++) {
							areaIds.push(rows[i].areaId);
						}
						$.ajax({
							type : "POST",
							url : "AreaInfo/deletes",
							data : {
								areaIds : areaIds.join(","),
							},
							beforeSend : function () {
								$("#areaInfo_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#areaInfo_manage").datagrid("loaded");
									$("#areaInfo_manage").datagrid("load");
									$("#areaInfo_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#areaInfo_manage").datagrid("loaded");
									$("#areaInfo_manage").datagrid("load");
									$("#areaInfo_manage").datagrid("unselectAll");
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
			var rows = $("#areaInfo_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "AreaInfo/" + rows[0].areaId +  "/update",
					type : "get",
					data : {
						//areaId : rows[0].areaId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (areaInfo, response, status) {
						$.messager.progress("close");
						if (areaInfo) { 
							$("#areaInfoEditDiv").dialog("open");
							$("#areaInfo_areaId_edit").val(areaInfo.areaId);
							$("#areaInfo_areaId_edit").validatebox({
								required : true,
								missingMessage : "请输入记录编号",
								editable: false
							});
							$("#areaInfo_areaName_edit").val(areaInfo.areaName);
							$("#areaInfo_areaName_edit").validatebox({
								required : true,
								missingMessage : "请输入区域名称",
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
