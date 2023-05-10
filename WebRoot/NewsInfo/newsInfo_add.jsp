<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newsInfo.css" />
<div id="newsInfoAddDiv">
	<form id="newsInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsInfo_newsTitle" name="newsInfo.newsTitle" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">新闻内容:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsInfo_newsContent" name="newsInfo.newsContent" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">发布日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsInfo_newsDate" name="newsInfo.newsDate" />

			</span>

		</div>
		<div class="operation">
			<a id="newsInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="newsInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/NewsInfo/js/newsInfo_add.js"></script> 
