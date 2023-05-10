<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/guestBook.css" />
<div id="guestBook_editDiv">
	<form id="guestBookEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="guestBook_guestBookId_edit" name="guestBook.guestBookId" value="<%=request.getParameter("guestBookId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">留言标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="guestBook_title_edit" name="guestBook.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">留言内容:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="guestBook_content_edit" name="guestBook.content" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">留言人:</span>
			<span class="inputControl">
				<input class="textbox"  id="guestBook_userObj_user_name_edit" name="guestBook.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">留言时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="guestBook_addTime_edit" name="guestBook.addTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="guestBookModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/GuestBook/js/guestBook_modify.js"></script> 
