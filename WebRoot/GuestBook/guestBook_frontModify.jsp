<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.GuestBook" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    GuestBook guestBook = (GuestBook)request.getAttribute("guestBook");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改留言信息信息</TITLE>
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
  		<li class="active">留言信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="guestBookEditForm" id="guestBookEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="guestBook_guestBookId_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="guestBook_guestBookId_edit" name="guestBook.guestBookId" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="guestBook_title_edit" class="col-md-3 text-right">留言标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="guestBook_title_edit" name="guestBook.title" class="form-control" placeholder="请输入留言标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="guestBook_content_edit" class="col-md-3 text-right">留言内容:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="guestBook_content_edit" name="guestBook.content" class="form-control" placeholder="请输入留言内容">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="guestBook_userObj_user_name_edit" class="col-md-3 text-right">留言人:</label>
		  	 <div class="col-md-9">
			    <select id="guestBook_userObj_user_name_edit" name="guestBook.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="guestBook_addTime_edit" class="col-md-3 text-right">留言时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="guestBook_addTime_edit" name="guestBook.addTime" class="form-control" placeholder="请输入留言时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxGuestBookModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#guestBookEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改留言信息界面并初始化数据*/
function guestBookEdit(guestBookId) {
	$.ajax({
		url :  basePath + "GuestBook/" + guestBookId + "/update",
		type : "get",
		dataType: "json",
		success : function (guestBook, response, status) {
			if (guestBook) {
				$("#guestBook_guestBookId_edit").val(guestBook.guestBookId);
				$("#guestBook_title_edit").val(guestBook.title);
				$("#guestBook_content_edit").val(guestBook.content);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#guestBook_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.realName + "</option>";
		        		});
		        		$("#guestBook_userObj_user_name_edit").html(html);
		        		$("#guestBook_userObj_user_name_edit").val(guestBook.userObjPri);
					}
				});
				$("#guestBook_addTime_edit").val(guestBook.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交留言信息信息表单给服务器端修改*/
function ajaxGuestBookModify() {
	$.ajax({
		url :  basePath + "GuestBook/" + $("#guestBook_guestBookId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#guestBookEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#guestBookQueryForm").submit();
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
    guestBookEdit("<%=request.getParameter("guestBookId")%>");
 })
 </script> 
</body>
</html>

