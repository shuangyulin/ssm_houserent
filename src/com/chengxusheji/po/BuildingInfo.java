package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class BuildingInfo {
    /*楼盘编号*/
    private Integer buildingId;
    public Integer getBuildingId(){
        return buildingId;
    }
    public void setBuildingId(Integer buildingId){
        this.buildingId = buildingId;
    }

    /*所在区域*/
    private AreaInfo areaObj;
    public AreaInfo getAreaObj() {
        return areaObj;
    }
    public void setAreaObj(AreaInfo areaObj) {
        this.areaObj = areaObj;
    }

    /*楼盘名称*/
    @NotEmpty(message="楼盘名称不能为空")
    private String buildingName;
    public String getBuildingName() {
        return buildingName;
    }
    public void setBuildingName(String buildingName) {
        this.buildingName = buildingName;
    }

    /*楼盘图片*/
    private String buildingPhoto;
    public String getBuildingPhoto() {
        return buildingPhoto;
    }
    public void setBuildingPhoto(String buildingPhoto) {
        this.buildingPhoto = buildingPhoto;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonBuildingInfo=new JSONObject(); 
		jsonBuildingInfo.accumulate("buildingId", this.getBuildingId());
		jsonBuildingInfo.accumulate("areaObj", this.getAreaObj().getAreaName());
		jsonBuildingInfo.accumulate("areaObjPri", this.getAreaObj().getAreaId());
		jsonBuildingInfo.accumulate("buildingName", this.getBuildingName());
		jsonBuildingInfo.accumulate("buildingPhoto", this.getBuildingPhoto());
		return jsonBuildingInfo;
    }}