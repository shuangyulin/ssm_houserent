<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>新闻公告添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>NewsInfo/frontlist">新闻公告列表</a></li>
			    	<li role="presentation" class="active"><a href="#newsInfoAdd" aria-controls="newsInfoAdd" role="tab" data-toggle="tab">添加新闻公告</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="newsInfoList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="newsInfoAdd"> 
				      	<form class="form-horizontal" name="newsInfoAddForm" id="newsInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="newsInfo_newsTitle" class="col-md-2 text-right">标题:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="newsInfo_newsTitle" name="newsInfo.newsTitle" class="form-control" placeholder="请输入标题">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="newsInfo_newsContent" class="col-md-2 text-right">新闻内容:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="newsInfo_newsContent" name="newsInfo.newsContent" class="form-control" placeholder="请输入新闻内容">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="newsInfo_newsDateDiv" class="col-md-2 text-right">发布日期:</label>
						  	 <div class="col-md-8">
				                <div id="newsInfo_newsDateDiv" class="input-group date newsInfo_newsDate col-md-12" data-link-field="newsInfo_newsDate" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="newsInfo_newsDate" name="newsInfo.newsDate" size="16" type="text" value="" placeholder="请选择发布日期" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxNewsInfoAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#newsInfoAddForm .form-group {margin:10px;}  </style>
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
	//提交添加新闻公告信息
	function ajaxNewsInfoAdd() { 
		//提交之前先验证表单
		$("#newsInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#newsInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "NewsInfo/add",
			dataType : "json" , 
			data: new FormData($("#newsInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#newsInfoAddForm").find("input").val("");
					$("#newsInfoAddForm").find("textarea").val("");
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
	//验证新闻公告添加表单字段
	$('#newsInfoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"newsInfo.newsTitle": {
				validators: {
					notEmpty: {
						message: "标题不能为空",
					}
				}
			},
			"newsInfo.newsContent": {
				validators: {
					notEmpty: {
						message: "新闻内容不能为空",
					}
				}
			},
			"newsInfo.newsDate": {
				validators: {
					notEmpty: {
						message: "发布日期不能为空",
					}
				}
			},
		}
	}); 
	//发布日期组件
	$('#newsInfo_newsDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#newsInfoAddForm').data('bootstrapValidator').updateStatus('newsInfo.newsDate', 'NOT_VALIDATED',null).validateField('newsInfo.newsDate');
	});
})
</script>
</body>
</html>
