<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.BuildingInfo" %>
<%@ page import="com.chengxusheji.po.AreaInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的areaObj信息
    List<AreaInfo> areaInfoList = (List<AreaInfo>)request.getAttribute("areaInfoList");
    BuildingInfo buildingInfo = (BuildingInfo)request.getAttribute("buildingInfo");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改楼盘信息信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">楼盘信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="buildingInfoEditForm" id="buildingInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="buildingInfo_buildingId_edit" class="col-md-3 text-right">楼盘编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="buildingInfo_buildingId_edit" name="buildingInfo.buildingId" class="form-control" placeholder="请输入楼盘编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="buildingInfo_areaObj_areaId_edit" class="col-md-3 text-right">所在区域:</label>
		  	 <div class="col-md-9">
			    <select id="buildingInfo_areaObj_areaId_edit" name="buildingInfo.areaObj.areaId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="buildingInfo_buildingName_edit" class="col-md-3 text-right">楼盘名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="buildingInfo_buildingName_edit" name="buildingInfo.buildingName" class="form-control" placeholder="请输入楼盘名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="buildingInfo_buildingPhoto_edit" class="col-md-3 text-right">楼盘图片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="buildingInfo_buildingPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="buildingInfo_buildingPhoto" name="buildingInfo.buildingPhoto"/>
			    <input id="buildingPhotoFile" name="buildingPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxBuildingInfoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#buildingInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改楼盘信息界面并初始化数据*/
function buildingInfoEdit(buildingId) {
	$.ajax({
		url :  basePath + "BuildingInfo/" + buildingId + "/update",
		type : "get",
		dataType: "json",
		success : function (buildingInfo, response, status) {
			if (buildingInfo) {
				$("#buildingInfo_buildingId_edit").val(buildingInfo.buildingId);
				$.ajax({
					url: basePath + "AreaInfo/listAll",
					type: "get",
					success: function(areaInfos,response,status) { 
						$("#buildingInfo_areaObj_areaId_edit").empty();
						var html="";
		        		$(areaInfos).each(function(i,areaInfo){
		        			html += "<option value='" + areaInfo.areaId + "'>" + areaInfo.areaName + "</option>";
		        		});
		        		$("#buildingInfo_areaObj_areaId_edit").html(html);
		        		$("#buildingInfo_areaObj_areaId_edit").val(buildingInfo.areaObjPri);
					}
				});
				$("#buildingInfo_buildingName_edit").val(buildingInfo.buildingName);
				$("#buildingInfo_buildingPhoto").val(buildingInfo.buildingPhoto);
				$("#buildingInfo_buildingPhotoImg").attr("src", basePath +　buildingInfo.buildingPhoto);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交楼盘信息信息表单给服务器端修改*/
function ajaxBuildingInfoModify() {
	$.ajax({
		url :  basePath + "BuildingInfo/" + $("#buildingInfo_buildingId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#buildingInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#buildingInfoQueryForm").submit();
            }else{
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
    buildingInfoEdit("<%=request.getParameter("buildingId")%>");
 })
 </script> 
</body>
</html>

