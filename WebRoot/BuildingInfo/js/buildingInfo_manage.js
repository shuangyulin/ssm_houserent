var buildingInfo_manage_tool = null; 
$(function () { 
	initBuildingInfoManageTool(); //建立BuildingInfo管理对象
	buildingInfo_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#buildingInfo_manage").datagrid({
		url : 'BuildingInfo/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "buildingId",
		sortOrder : "desc",
		toolbar : "#buildingInfo_manage_tool",
		columns : [[
			{
				field : "buildingId",
				title : "楼盘编号",
				width : 70,
			},
			{
				field : "areaObj",
				title : "所在区域",
				width : 140,
			},
			{
				field : "buildingName",
				title : "楼盘名称",
				width : 140,
			},
			{
				field : "buildingPhoto",
				title : "楼盘图片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
		]],
	});

	$("#buildingInfoEditDiv").dialog({
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
				if ($("#buildingInfoEditForm").form("validate")) {
					//验证表单 
					if(!$("#buildingInfoEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#buildingInfoEditForm").form({
						    url:"BuildingInfo/" + $("#buildingInfo_buildingId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#buildingInfoEditForm").form("validate"))  {
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
			                        $("#buildingInfoEditDiv").dialog("close");
			                        buildingInfo_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#buildingInfoEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#buildingInfoEditDiv").dialog("close");
				$("#buildingInfoEditForm").form("reset"); 
			},
		}],
	});
});

function initBuildingInfoManageTool() {
	buildingInfo_manage_tool = {
		init: function() {
			$.ajax({
				url : "AreaInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#areaObj_areaId_query").combobox({ 
					    valueField:"areaId",
					    textField:"areaName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{areaId:0,areaName:"不限制"});
					$("#areaObj_areaId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#buildingInfo_manage").datagrid("reload");
		},
		redo : function () {
			$("#buildingInfo_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#buildingInfo_manage").datagrid("options").queryParams;
			queryParams["areaObj.areaId"] = $("#areaObj_areaId_query").combobox("getValue");
			queryParams["buildingName"] = $("#buildingName").val();
			$("#buildingInfo_manage").datagrid("options").queryParams=queryParams; 
			$("#buildingInfo_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#buildingInfoQueryForm").form({
			    url:"BuildingInfo/OutToExcel",
			});
			//提交表单
			$("#buildingInfoQueryForm").submit();
		},
		remove : function () {
			var rows = $("#buildingInfo_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var buildingIds = [];
						for (var i = 0; i < rows.length; i ++) {
							buildingIds.push(rows[i].buildingId);
						}
						$.ajax({
							type : "POST",
							url : "BuildingInfo/deletes",
							data : {
								buildingIds : buildingIds.join(","),
							},
							beforeSend : function () {
								$("#buildingInfo_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#buildingInfo_manage").datagrid("loaded");
									$("#buildingInfo_manage").datagrid("load");
									$("#buildingInfo_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#buildingInfo_manage").datagrid("loaded");
									$("#buildingInfo_manage").datagrid("load");
									$("#buildingInfo_manage").datagrid("unselectAll");
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
			var rows = $("#buildingInfo_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "BuildingInfo/" + rows[0].buildingId +  "/update",
					type : "get",
					data : {
						//buildingId : rows[0].buildingId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (buildingInfo, response, status) {
						$.messager.progress("close");
						if (buildingInfo) { 
							$("#buildingInfoEditDiv").dialog("open");
							$("#buildingInfo_buildingId_edit").val(buildingInfo.buildingId);
							$("#buildingInfo_buildingId_edit").validatebox({
								required : true,
								missingMessage : "请输入楼盘编号",
								editable: false
							});
							$("#buildingInfo_areaObj_areaId_edit").combobox({
								url:"AreaInfo/listAll",
							    valueField:"areaId",
							    textField:"areaName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#buildingInfo_areaObj_areaId_edit").combobox("select", buildingInfo.areaObjPri);
									//var data = $("#buildingInfo_areaObj_areaId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#buildingInfo_areaObj_areaId_edit").combobox("select", data[0].areaId);
						            //}
								}
							});
							$("#buildingInfo_buildingName_edit").val(buildingInfo.buildingName);
							$("#buildingInfo_buildingName_edit").validatebox({
								required : true,
								missingMessage : "请输入楼盘名称",
							});
							$("#buildingInfo_buildingPhoto").val(buildingInfo.buildingPhoto);
							$("#buildingInfo_buildingPhotoImg").attr("src", buildingInfo.buildingPhoto);
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
