<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.GuestBook" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<GuestBook> guestBookList = (List<GuestBook>)request.getAttribute("guestBookList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String title = (String)request.getAttribute("title"); //留言标题查询关键字
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>留言信息查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#guestBookListPanel" aria-controls="guestBookListPanel" role="tab" data-toggle="tab">留言信息列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>GuestBook/guestBook_frontAdd.jsp" style="display:none;">添加留言信息</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="guestBookListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>留言标题</td><td>留言内容</td><td>留言人</td><td>留言时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<guestBookList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		GuestBook guestBook = guestBookList.get(i); //获取到留言信息对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=guestBook.getTitle() %></td>
 											<td><%=guestBook.getContent() %></td>
 											<td><%=guestBook.getUserObj().getRealName() %></td>
 											<td><%=guestBook.getAddTime() %></td>
 											<td>
 												<a href="<%=basePath  %>GuestBook/<%=guestBook.getGuestBookId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="guestBookEdit('<%=guestBook.getGuestBookId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="guestBookDelete('<%=guestBook.getGuestBookId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>留言信息查询</h1>
		</div>
		<form name="guestBookQueryForm" id="guestBookQueryForm" action="<%=basePath %>GuestBook/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="title">留言标题:</label>
				<input type="text" id="title" name="title" value="<%=title %>" class="form-control" placeholder="请输入留言标题">
			</div>






            <div class="form-group">
            	<label for="userObj_user_name">留言人：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getRealName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="guestBookEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;留言信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#guestBookEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxGuestBookModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.guestBookQueryForm.currentPage.value = currentPage;
    document.guestBookQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.guestBookQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.guestBookQueryForm.currentPage.value = pageValue;
    documentguestBookQueryForm.submit();
}

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
				$('#guestBookEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除留言信息信息*/
function guestBookDelete(guestBookId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "GuestBook/deletes",
			data : {
				guestBookIds : guestBookId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#guestBookQueryForm").submit();
					//location.href= basePath + "GuestBook/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

