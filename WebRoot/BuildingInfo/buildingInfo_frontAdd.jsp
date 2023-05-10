<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.AreaInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>楼盘信息添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>BuildingInfo/frontlist">楼盘信息管理</a></li>
  			<li class="active">添加楼盘信息</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="buildingInfoAddForm" id="buildingInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="buildingInfo_areaObj_areaId" class="col-md-2 text-right">所在区域:</label>
				  	 <div class="col-md-8">
					    <select id="buildingInfo_areaObj_areaId" name="buildingInfo.areaObj.areaId" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="buildingInfo_buildingName" class="col-md-2 text-right">楼盘名称:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="buildingInfo_buildingName" name="buildingInfo.buildingName" class="form-control" placeholder="请输入楼盘名称">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="buildingInfo_buildingPhoto" class="col-md-2 text-right">楼盘图片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="buildingInfo_buildingPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="buildingInfo_buildingPhoto" name="buildingInfo.buildingPhoto"/>
					    <input id="buildingPhotoFile" name="buildingPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxBuildingInfoAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#buildingInfoAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
	    </div>
	</div>
</div>
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加楼盘信息信息
	function ajaxBuildingInfoAdd() { 
		//提交之前先验证表单
		$("#buildingInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#buildingInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "BuildingInfo/add",
			dataType : "json" , 
			data: new FormData($("#buildingInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#buildingInfoAddForm").find("input").val("");
					$("#buildingInfoAddForm").find("textarea").val("");
				} else {
					alert(obj.message);
				}
			},
			processData: false, 
			contentType: false, 
		});
	} 
$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();
	//验证楼盘信息添加表单字段
	$('#buildingInfoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"buildingInfo.buildingName": {
				validators: {
					notEmpty: {
						message: "楼盘名称不能为空",
					}
				}
			},
		}
	}); 
	//初始化所在区域下拉框值 
	$.ajax({
		url: basePath + "AreaInfo/listAll",
		type: "get",
		success: function(areaInfos,response,status) { 
			$("#buildingInfo_areaObj_areaId").empty();
			var html="";
    		$(areaInfos).each(function(i,areaInfo){
    			html += "<option value='" + areaInfo.areaId + "'>" + areaInfo.areaName + "</option>";
    		});
    		$("#buildingInfo_areaObj_areaId").html(html);
    	}
	});
})
</script>
</body>
</html>
