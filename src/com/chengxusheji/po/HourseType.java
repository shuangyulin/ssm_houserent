package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class HourseType {
    /*类别编号*/
    private Integer typeId;
    public Integer getTypeId(){
        return typeId;
    }
    public void setTypeId(Integer typeId){
        this.typeId = typeId;
    }

    /*房屋类型*/
    @NotEmpty(message="房屋类型不能为空")
    private String typeName;
    public String getTypeName() {
        return typeName;
    }
    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonHourseType=new JSONObject(); 
		jsonHourseType.accumulate("typeId", this.getTypeId());
		jsonHourseType.accumulate("typeName", this.getTypeName());
		return jsonHourseType;
    }}