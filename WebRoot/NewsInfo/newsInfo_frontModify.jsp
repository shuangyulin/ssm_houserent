<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.NewsInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    NewsInfo newsInfo = (NewsInfo)request.getAttribute("newsInfo");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改新闻公告信息</TITLE>
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
  		<li class="active">新闻公告信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="newsInfoEditForm" id="newsInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="newsInfo_newsId_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="newsInfo_newsId_edit" name="newsInfo.newsId" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="newsInfo_newsTitle_edit" class="col-md-3 text-right">标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="newsInfo_newsTitle_edit" name="newsInfo.newsTitle" class="form-control" placeholder="请输入标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="newsInfo_newsContent_edit" class="col-md-3 text-right">新闻内容:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="newsInfo_newsContent_edit" name="newsInfo.newsContent" class="form-control" placeholder="请输入新闻内容">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="newsInfo_newsDate_edit" class="col-md-3 text-right">发布日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date newsInfo_newsDate_edit col-md-12" data-link-field="newsInfo_newsDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="newsInfo_newsDate_edit" name="newsInfo.newsDate" size="16" type="text" value="" placeholder="请选择发布日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxNewsInfoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#newsInfoEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改新闻公告界面并初始化数据*/
function newsInfoEdit(newsId) {
	$.ajax({
		url :  basePath + "NewsInfo/" + newsId + "/update",
		type : "get",
		dataType: "json",
		success : function (newsInfo, response, status) {
			if (newsInfo) {
				$("#newsInfo_newsId_edit").val(newsInfo.newsId);
				$("#newsInfo_newsTitle_edit").val(newsInfo.newsTitle);
				$("#newsInfo_newsContent_edit").val(newsInfo.newsContent);
				$("#newsInfo_newsDate_edit").val(newsInfo.newsDate);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交新闻公告信息表单给服务器端修改*/
function ajaxNewsInfoModify() {
	$.ajax({
		url :  basePath + "NewsInfo/" + $("#newsInfo_newsId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#newsInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#newsInfoQueryForm").submit();
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
    /*发布日期组件*/
    $('.newsInfo_newsDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    newsInfoEdit("<%=request.getParameter("newsId")%>");
 })
 </script> 
</body>
</html>

