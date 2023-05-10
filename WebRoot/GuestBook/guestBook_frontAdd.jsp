<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.UserInfo" %>
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
<title>留言信息添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>GuestBook/frontlist">留言信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#guestBookAdd" aria-controls="guestBookAdd" role="tab" data-toggle="tab">添加留言信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="guestBookList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="guestBookAdd"> 
				      	<form class="form-horizontal" name="guestBookAddForm" id="guestBookAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="guestBook_title" class="col-md-2 text-right">留言标题:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="guestBook_title" name="guestBook.title" class="form-control" placeholder="请输入留言标题">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="guestBook_content" class="col-md-2 text-right">留言内容:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="guestBook_content" name="guestBook.content" class="form-control" placeholder="请输入留言内容">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="guestBook_userObj_user_name" class="col-md-2 text-right">留言人:</label>
						  	 <div class="col-md-8">
							    <select id="guestBook_userObj_user_name" name="guestBook.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="guestBook_addTime" class="col-md-2 text-right">留言时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="guestBook_addTime" name="guestBook.addTime" class="form-control" placeholder="请输入留言时间">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxGuestBookAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#guestBookAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
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
	//提交添加留言信息信息
	function ajaxGuestBookAdd() { 
		//提交之前先验证表单
		$("#guestBookAddForm").data('bootstrapValidator').validate();
		if(!$("#guestBookAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "GuestBook/add",
			dataType : "json" , 
			data: new FormData($("#guestBookAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#guestBookAddForm").find("input").val("");
					$("#guestBookAddForm").find("textarea").val("");
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
	//验证留言信息添加表单字段
	$('#guestBookAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"guestBook.title": {
				validators: {
					notEmpty: {
						message: "留言标题不能为空",
					}
				}
			},
			"guestBook.content": {
				validators: {
					notEmpty: {
						message: "留言内容不能为空",
					}
				}
			},
			"guestBook.addTime": {
				validators: {
					notEmpty: {
						message: "留言时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化留言人下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#guestBook_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.realName + "</option>";
    		});
    		$("#guestBook_userObj_user_name").html(html);
    	}
	});
})
</script>
</body>
</html>
