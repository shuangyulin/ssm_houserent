var hourse_manage_tool = null; 
$(function () { 
	initHourseManageTool(); //建立Hourse管理对象
	hourse_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#hourse_manage").datagrid({
		url : 'Hourse/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "hourseId",
		sortOrder : "desc",
		toolbar : "#hourse_manage_tool",
		columns : [[
			{
				field : "hourseName",
				title : "房屋名称",
				width : 140,
			},
			{
				field : "buildingObj",
				title : "所在楼盘",
				width : 140,
			},
			{
				field : "housePhoto",
				title : "房屋图片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
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
				field : "area",
				title : "面积",
				width : 140,
			},
			{
				field : "price",
				title : "租金(元/月)",
				width : 70,
			},
			{
				field : "louceng",
				title : "楼层/总楼层",
				width : 140,
			},
			{
				field : "zhuangxiu",
				title : "装修",
				width : 140,
			},
			{
				field : "caoxiang",
				title : "朝向",
				width : 140,
			},
			{
				field : "madeYear",
				title : "建筑年代",
				width : 140,
			},
			{
				field : "connectPerson",
				title : "联系人",
				width : 140,
			},
			{
				field : "connectPhone",
				title : "联系电话",
				width : 140,
			},
		]],
	});

	$("#hourseEditDiv").dialog({
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
				if ($("#hourseEditForm").form("validate")) {
					//验证表单 
					if(!$("#hourseEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#hourseEditForm").form({
						    url:"Hourse/" + $("#hourse_hourseId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#hourseEditForm").form("validate"))  {
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
			                        $("#hourseEditDiv").dialog("close");
			                        hourse_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#hourseEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#hourseEditDiv").dialog("close");
				$("#hourseEditForm").form("reset"); 
			},
		}],
	});
});

function initHourseManageTool() {
	hourse_manage_tool = {
		init: function() {
			$.ajax({
				url : "BuildingInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#buildingObj_buildingId_query").combobox({ 
					    valueField:"buildingId",
					    textField:"buildingName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{buildingId:0,buildingName:"不限制"});
					$("#buildingObj_buildingId_query").combobox("loadData",data); 
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
			$("#hourse_manage").datagrid("reload");
		},
		redo : function () {
			$("#hourse_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#hourse_manage").datagrid("options").queryParams;
			queryParams["hourseName"] = $("#hourseName").val();
			queryParams["buildingObj.buildingId"] = $("#buildingObj_buildingId_query").combobox("getValue");
			queryParams["hourseTypeObj.typeId"] = $("#hourseTypeObj_typeId_query").combobox("getValue");
			queryParams["priceRangeObj.rangeId"] = $("#priceRangeObj_rangeId_query").combobox("getValue");
			queryParams["madeYear"] = $("#madeYear").val();
			queryParams["connectPerson"] = $("#connectPerson").val();
			queryParams["connectPhone"] = $("#connectPhone").val();
			$("#hourse_manage").datagrid("options").queryParams=queryParams; 
			$("#hourse_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#hourseQueryForm").form({
			    url:"Hourse/OutToExcel",
			});
			//提交表单
			$("#hourseQueryForm").submit();
		},
		remove : function () {
			var rows = $("#hourse_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var hourseIds = [];
						for (var i = 0; i < rows.length; i ++) {
							hourseIds.push(rows[i].hourseId);
						}
						$.ajax({
							type : "POST",
							url : "Hourse/deletes",
							data : {
								hourseIds : hourseIds.join(","),
							},
							beforeSend : function () {
								$("#hourse_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#hourse_manage").datagrid("loaded");
									$("#hourse_manage").datagrid("load");
									$("#hourse_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#hourse_manage").datagrid("loaded");
									$("#hourse_manage").datagrid("load");
									$("#hourse_manage").datagrid("unselectAll");
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
			var rows = $("#hourse_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Hourse/" + rows[0].hourseId +  "/update",
					type : "get",
					data : {
						//hourseId : rows[0].hourseId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (hourse, response, status) {
						$.messager.progress("close");
						if (hourse) { 
							$("#hourseEditDiv").dialog("open");
							$("#hourse_hourseId_edit").val(hourse.hourseId);
							$("#hourse_hourseId_edit").validatebox({
								required : true,
								missingMessage : "请输入房屋编号",
								editable: false
							});
							$("#hourse_hourseName_edit").val(hourse.hourseName);
							$("#hourse_hourseName_edit").validatebox({
								required : true,
								missingMessage : "请输入房屋名称",
							});
							$("#hourse_buildingObj_buildingId_edit").combobox({
								url:"BuildingInfo/listAll",
							    valueField:"buildingId",
							    textField:"buildingName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#hourse_buildingObj_buildingId_edit").combobox("select", hourse.buildingObjPri);
									//var data = $("#hourse_buildingObj_buildingId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#hourse_buildingObj_buildingId_edit").combobox("select", data[0].buildingId);
						            //}
								}
							});
							$("#hourse_housePhoto").val(hourse.housePhoto);
							$("#hourse_housePhotoImg").attr("src", hourse.housePhoto);
							$("#hourse_hourseTypeObj_typeId_edit").combobox({
								url:"HourseType/listAll",
							    valueField:"typeId",
							    textField:"typeName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#hourse_hourseTypeObj_typeId_edit").combobox("select", hourse.hourseTypeObjPri);
									//var data = $("#hourse_hourseTypeObj_typeId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#hourse_hourseTypeObj_typeId_edit").combobox("select", data[0].typeId);
						            //}
								}
							});
							$("#hourse_priceRangeObj_rangeId_edit").combobox({
								url:"PriceRange/listAll",
							    valueField:"rangeId",
							    textField:"priceName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#hourse_priceRangeObj_rangeId_edit").combobox("select", hourse.priceRangeObjPri);
									//var data = $("#hourse_priceRangeObj_rangeId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#hourse_priceRangeObj_rangeId_edit").combobox("select", data[0].rangeId);
						            //}
								}
							});
							$("#hourse_area_edit").val(hourse.area);
							$("#hourse_area_edit").validatebox({
								required : true,
								missingMessage : "请输入面积",
							});
							$("#hourse_price_edit").val(hourse.price);
							$("#hourse_price_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入租金(元/月)",
								invalidMessage : "租金(元/月)输入不对",
							});
							$("#hourse_louceng_edit").val(hourse.louceng);
							$("#hourse_louceng_edit").validatebox({
								required : true,
								missingMessage : "请输入楼层/总楼层",
							});
							$("#hourse_zhuangxiu_edit").val(hourse.zhuangxiu);
							$("#hourse_zhuangxiu_edit").validatebox({
								required : true,
								missingMessage : "请输入装修",
							});
							$("#hourse_caoxiang_edit").val(hourse.caoxiang);
							$("#hourse_madeYear_edit").val(hourse.madeYear);
							$("#hourse_connectPerson_edit").val(hourse.connectPerson);
							$("#hourse_connectPerson_edit").validatebox({
								required : true,
								missingMessage : "请输入联系人",
							});
							$("#hourse_connectPhone_edit").val(hourse.connectPhone);
							$("#hourse_connectPhone_edit").validatebox({
								required : true,
								missingMessage : "请输入联系电话",
							});
							$("#hourse_detail_edit").val(hourse.detail);
							$("#hourse_address_edit").val(hourse.address);
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
