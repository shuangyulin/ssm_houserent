<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/guestBook.css" />
<div id="guestBookAddDiv">
	<form id="guestBookAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">留言标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="guestBook_title" name="guestBook.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">留言内容:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="guestBook_content" name="guestBook.content" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">留言人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="guestBook_userObj_user_name" name="guestBook.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">留言时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="guestBook_addTime" name="guestBook.addTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="guestBookAddButton" class="easyui-linkbutton">添加</a>
			<a id="guestBookClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/GuestBook/js/guestBook_add.js"></script> 
