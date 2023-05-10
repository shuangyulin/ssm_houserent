<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/hourse.css" />
<div id="hourseAddDiv">
	<form id="hourseAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">房屋名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_hourseName" name="hourse.hourseName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所在楼盘:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_buildingObj_buildingId" name="hourse.buildingObj.buildingId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">房屋图片:</span>
			<span class="inputControl">
				<input id="housePhotoFile" name="housePhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">房屋类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_hourseTypeObj_typeId" name="hourse.hourseTypeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">价格范围:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_priceRangeObj_rangeId" name="hourse.priceRangeObj.rangeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">面积:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_area" name="hourse.area" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">租金(元/月):</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_price" name="hourse.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">楼层/总楼层:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_louceng" name="hourse.louceng" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">装修:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_zhuangxiu" name="hourse.zhuangxiu" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">朝向:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_caoxiang" name="hourse.caoxiang" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">建筑年代:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_madeYear" name="hourse.madeYear" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_connectPerson" name="hourse.connectPerson" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_connectPhone" name="hourse.connectPhone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">详细信息:</span>
			<span class="inputControl">
				<textarea id="hourse_detail" name="hourse.detail" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_address" name="hourse.address" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="hourseAddButton" class="easyui-linkbutton">添加</a>
			<a id="hourseClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Hourse/js/hourse_add.js"></script> 
