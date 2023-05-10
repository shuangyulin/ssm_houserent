<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.HourseType" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    HourseType hourseType = (HourseType)request.getAttribute("hourseType");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改房屋类别信息</TITLE>
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
  		<li class="active">房屋类别信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="hourseTypeEditForm" id="hourseTypeEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="hourseType_typeId_edit" class="col-md-3 text-right">类别编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="hourseType_typeId_edit" name="hourseType.typeId" class="form-control" placeholder="请输入类别编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="hourseType_typeName_edit" class="col-md-3 text-right">房屋类型:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="hourseType_typeName_edit" name="hourseType.typeName" class="form-control" placeholder="请输入房屋类型">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxHourseTypeModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#hourseTypeEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改房屋类别界面并初始化数据*/
function hourseTypeEdit(typeId) {
	$.ajax({
		url :  basePath + "HourseType/" + typeId + "/update",
		type : "get",
		dataType: "json",
		success : function (hourseType, response, status) {
			if (hourseType) {
				$("#hourseType_typeId_edit").val(hourseType.typeId);
				$("#hourseType_typeName_edit").val(hourseType.typeName);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交房屋类别信息表单给服务器端修改*/
function ajaxHourseTypeModify() {
	$.ajax({
		url :  basePath + "HourseType/" + $("#hourseType_typeId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#hourseTypeEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                location.href= basePath + "HourseType/frontlist";
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
    hourseTypeEdit("<%=request.getParameter("typeId")%>");
 })
 </script> 
</body>
</html>

