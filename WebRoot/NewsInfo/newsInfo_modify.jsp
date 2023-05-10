<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newsInfo.css" />
<div id="newsInfo_editDiv">
	<form id="newsInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsInfo_newsId_edit" name="newsInfo.newsId" value="<%=request.getParameter("newsId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsInfo_newsTitle_edit" name="newsInfo.newsTitle" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">新闻内容:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsInfo_newsContent_edit" name="newsInfo.newsContent" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">发布日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsInfo_newsDate_edit" name="newsInfo.newsDate" />

			</span>

		</div>
		<div class="operation">
			<a id="newsInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/NewsInfo/js/newsInfo_modify.js"></script> 
