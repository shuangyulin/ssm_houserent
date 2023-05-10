<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userInfo.css" />
<div id="userInfo_editDiv">
	<form id="userInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">用户名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_user_name_edit" name="userInfo.user_name" value="<%=request.getParameter("user_name") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_password_edit" name="userInfo.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_realName_edit" name="userInfo.realName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_sex_edit" name="userInfo.sex" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_birthday_edit" name="userInfo.birthday" />

			</span>

		</div>
		<div>
			<span class="label">身份证:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_cardNumber_edit" name="userInfo.cardNumber" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">籍贯:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_city_edit" name="userInfo.city" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">照片:</span>
			<span class="inputControl">
				<img id="userInfo_photoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="userInfo_photo" name="userInfo.photo"/>
				<input id="photoFile" name="photoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">家庭地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_address_edit" name="userInfo.address" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="userInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/UserInfo/js/userInfo_modify.js"></script> 
