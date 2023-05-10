var priceRange_manage_tool = null; 
$(function () { 
	initPriceRangeManageTool(); //建立PriceRange管理对象
	priceRange_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#priceRange_manage").datagrid({
		url : 'PriceRange/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "rangeId",
		sortOrder : "desc",
		toolbar : "#priceRange_manage_tool",
		columns : [[
			{
				field : "rangeId",
				title : "记录编号",
				width : 70,
			},
			{
				field : "priceName",
				title : "价格区间",
				width : 140,
			},
		]],
	});

	$("#priceRangeEditDiv").dialog({
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
				if ($("#priceRangeEditForm").form("validate")) {
					//验证表单 
					if(!$("#priceRangeEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#priceRangeEditForm").form({
						    url:"PriceRange/" + $("#priceRange_rangeId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#priceRangeEditForm").form("validate"))  {
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
			                        $("#priceRangeEditDiv").dialog("close");
			                        priceRange_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#priceRangeEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#priceRangeEditDiv").dialog("close");
				$("#priceRangeEditForm").form("reset"); 
			},
		}],
	});
});

function initPriceRangeManageTool() {
	priceRange_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#priceRange_manage").datagrid("reload");
		},
		redo : function () {
			$("#priceRange_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#priceRange_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#priceRangeQueryForm").form({
			    url:"PriceRange/OutToExcel",
			});
			//提交表单
			$("#priceRangeQueryForm").submit();
		},
		remove : function () {
			var rows = $("#priceRange_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var rangeIds = [];
						for (var i = 0; i < rows.length; i ++) {
							rangeIds.push(rows[i].rangeId);
						}
						$.ajax({
							type : "POST",
							url : "PriceRange/deletes",
							data : {
								rangeIds : rangeIds.join(","),
							},
							beforeSend : function () {
								$("#priceRange_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#priceRange_manage").datagrid("loaded");
									$("#priceRange_manage").datagrid("load");
									$("#priceRange_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#priceRange_manage").datagrid("loaded");
									$("#priceRange_manage").datagrid("load");
									$("#priceRange_manage").datagrid("unselectAll");
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
			var rows = $("#priceRange_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "PriceRange/" + rows[0].rangeId +  "/update",
					type : "get",
					data : {
						//rangeId : rows[0].rangeId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (priceRange, response, status) {
						$.messager.progress("close");
						if (priceRange) { 
							$("#priceRangeEditDiv").dialog("open");
							$("#priceRange_rangeId_edit").val(priceRange.rangeId);
							$("#priceRange_rangeId_edit").validatebox({
								required : true,
								missingMessage : "请输入记录编号",
								editable: false
							});
							$("#priceRange_priceName_edit").val(priceRange.priceName);
							$("#priceRange_priceName_edit").validatebox({
								required : true,
								missingMessage : "请输入价格区间",
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
