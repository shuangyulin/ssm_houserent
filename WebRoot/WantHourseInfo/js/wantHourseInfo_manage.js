var wantHourseInfo_manage_tool = null; 
$(function () { 
	initWantHourseInfoManageTool(); //建立WantHourseInfo管理对象
	wantHourseInfo_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#wantHourseInfo_manage").datagrid({
		url : 'WantHourseInfo/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "wantHourseId",
		sortOrder : "desc",
		toolbar : "#wantHourseInfo_manage_tool",
		columns : [[
			{
				field : "userObj",
				title : "求租用户",
				width : 140,
			},
			{
				field : "title",
				title : "标题",
				width : 140,
			},
			{
				field : "position",
				title : "求租区域",
				width : 140,
			},
			{
				field : "hourseTypeObj",
				title : "房屋类型",
				width : 140,
			},
			{
				field : "priceRangeObj",
				title : "价格范围",
				width : 140,
			},
			{
				field : "price",
				title : "最高能出租金",
				width : 70,
			},
			{
				field : "lianxiren",
				title : "联系人",
				width : 140,
			},
			{
				field : "telephone",
				title : "联系电话",
				width : 140,
			},
		]],
	});

	$("#wantHourseInfoEditDiv").dialog({
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
				if ($("#wantHourseInfoEditForm").form("validate")) {
					//验证表单 
					if(!$("#wantHourseInfoEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#wantHourseInfoEditForm").form({
						    url:"WantHourseInfo/" + $("#wantHourseInfo_wantHourseId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#wantHourseInfoEditForm").form("validate"))  {
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
			                        $("#wantHourseInfoEditDiv").dialog("close");
			                        wantHourseInfo_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#wantHourseInfoEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#wantHourseInfoEditDiv").dialog("close");
				$("#wantHourseInfoEditForm").form("reset"); 
			},
		}],
	});
});

function initWantHourseInfoManageTool() {
	wantHourseInfo_manage_tool = {
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
			$.ajax({
				url : "AreaInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#position_areaId_query").combobox({ 
					    valueField:"areaId",
					    textField:"areaName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{areaId:0,areaName:"不限制"});
					$("#position_areaId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "HourseType/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#hourseTypeObj_typeId_query").combobox({ 
					    valueField:"typeId",
					    textField:"typeName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{typeId:0,typeName:"不限制"});
					$("#hourseTypeObj_typeId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "PriceRange/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#priceRangeObj_rangeId_query").combobox({ 
					    valueField:"rangeId",
					    textField:"priceName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{rangeId:0,priceName:"不限制"});
					$("#priceRangeObj_rangeId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#wantHourseInfo_manage").datagrid("reload");
		},
		redo : function () {
			$("#wantHourseInfo_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#wantHourseInfo_manage").datagrid("options").queryParams;
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["title"] = $("#title").val();
			queryParams["position.areaId"] = $("#position_areaId_query").combobox("getValue");
			queryParams["hourseTypeObj.typeId"] = $("#hourseTypeObj_typeId_query").combobox("getValue");
			queryParams["priceRangeObj.rangeId"] = $("#priceRangeObj_rangeId_query").combobox("getValue");
			$("#wantHourseInfo_manage").datagrid("options").queryParams=queryParams; 
			$("#wantHourseInfo_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#wantHourseInfoQueryForm").form({
			    url:"WantHourseInfo/OutToExcel",
			});
			//提交表单
			$("#wantHourseInfoQueryForm").submit();
		},
		remove : function () {
			var rows = $("#wantHourseInfo_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var wantHourseIds = [];
						for (var i = 0; i < rows.length; i ++) {
							wantHourseIds.push(rows[i].wantHourseId);
						}
						$.ajax({
							type : "POST",
							url : "WantHourseInfo/deletes",
							data : {
								wantHourseIds : wantHourseIds.join(","),
							},
							beforeSend : function () {
								$("#wantHourseInfo_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#wantHourseInfo_manage").datagrid("loaded");
									$("#wantHourseInfo_manage").datagrid("load");
									$("#wantHourseInfo_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#wantHourseInfo_manage").datagrid("loaded");
									$("#wantHourseInfo_manage").datagrid("load");
									$("#wantHourseInfo_manage").datagrid("unselectAll");
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
			var rows = $("#wantHourseInfo_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "WantHourseInfo/" + rows[0].wantHourseId +  "/update",
					type : "get",
					data : {
						//wantHourseId : rows[0].wantHourseId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (wantHourseInfo, response, status) {
						$.messager.progress("close");
						if (wantHourseInfo) { 
							$("#wantHourseInfoEditDiv").dialog("open");
							$("#wantHourseInfo_wantHourseId_edit").val(wantHourseInfo.wantHourseId);
							$("#wantHourseInfo_wantHourseId_edit").validatebox({
								required : true,
								missingMessage : "请输入记录编号",
								editable: false
							});
							$("#wantHourseInfo_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"realName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#wantHourseInfo_userObj_user_name_edit").combobox("select", wantHourseInfo.userObjPri);
									//var data = $("#wantHourseInfo_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#wantHourseInfo_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#wantHourseInfo_title_edit").val(wantHourseInfo.title);
							$("#wantHourseInfo_title_edit").validatebox({
								required : true,
								missingMessage : "请输入标题",
							});
							$("#wantHourseInfo_position_areaId_edit").combobox({
								url:"AreaInfo/listAll",
							    valueField:"areaId",
							    textField:"areaName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#wantHourseInfo_position_areaId_edit").combobox("select", wantHourseInfo.positionPri);
									//var data = $("#wantHourseInfo_position_areaId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#wantHourseInfo_position_areaId_edit").combobox("select", data[0].areaId);
						            //}
								}
							});
							$("#wantHourseInfo_hourseTypeObj_typeId_edit").combobox({
								url:"HourseType/listAll",
							    valueField:"typeId",
							    textField:"typeName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#wantHourseInfo_hourseTypeObj_typeId_edit").combobox("select", wantHourseInfo.hourseTypeObjPri);
									//var data = $("#wantHourseInfo_hourseTypeObj_typeId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#wantHourseInfo_hourseTypeObj_typeId_edit").combobox("select", data[0].typeId);
						            //}
								}
							});
							$("#wantHourseInfo_priceRangeObj_rangeId_edit").combobox({
								url:"PriceRange/listAll",
							    valueField:"rangeId",
							    textField:"priceName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#wantHourseInfo_priceRangeObj_rangeId_edit").combobox("select", wantHourseInfo.priceRangeObjPri);
									//var data = $("#wantHourseInfo_priceRangeObj_rangeId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#wantHourseInfo_priceRangeObj_rangeId_edit").combobox("select", data[0].rangeId);
						            //}
								}
							});
							$("#wantHourseInfo_price_edit").val(wantHourseInfo.price);
							$("#wantHourseInfo_price_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入最高能出租金",
								invalidMessage : "最高能出租金输入不对",
							});
							$("#wantHourseInfo_lianxiren_edit").val(wantHourseInfo.lianxiren);
							$("#wantHourseInfo_lianxiren_edit").validatebox({
								required : true,
								missingMessage : "请输入联系人",
							});
							$("#wantHourseInfo_telephone_edit").val(wantHourseInfo.telephone);
							$("#wantHourseInfo_telephone_edit").validatebox({
								required : true,
								missingMessage : "请输入联系电话",
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
