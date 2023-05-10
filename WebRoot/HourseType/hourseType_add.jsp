<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/hourseType.css" />
<div id="hourseTypeAddDiv">
	<form id="hourseTypeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">房屋类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourseType_typeName" name="hourseType.typeName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="hourseTypeAddButton" class="easyui-linkbutton">添加</a>
			<a id="hourseTypeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/HourseType/js/hourseType_add.js"></script> 
