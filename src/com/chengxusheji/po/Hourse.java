package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Hourse {
    /*房屋编号*/
    private Integer hourseId;
    public Integer getHourseId(){
        return hourseId;
    }
    public void setHourseId(Integer hourseId){
        this.hourseId = hourseId;
    }

    /*房屋名称*/
    @NotEmpty(message="房屋名称不能为空")
    private String hourseName;
    public String getHourseName() {
        return hourseName;
    }
    public void setHourseName(String hourseName) {
        this.hourseName = hourseName;
    }

    /*所在楼盘*/
    private BuildingInfo buildingObj;
    public BuildingInfo getBuildingObj() {
        return buildingObj;
    }
    public void setBuildingObj(BuildingInfo buildingObj) {
        this.buildingObj = buildingObj;
    }

    /*房屋图片*/
    private String housePhoto;
    public String getHousePhoto() {
        return housePhoto;
    }
    public void setHousePhoto(String housePhoto) {
        this.housePhoto = housePhoto;
    }

    /*房屋类型*/
    private HourseType hourseTypeObj;
    public HourseType getHourseTypeObj() {
        return hourseTypeObj;
    }
    public void setHourseTypeObj(HourseType hourseTypeObj) {
        this.hourseTypeObj = hourseTypeObj;
    }

    /*价格范围*/
    private PriceRange priceRangeObj;
    public PriceRange getPriceRangeObj() {
        return priceRangeObj;
    }
    public void setPriceRangeObj(PriceRange priceRangeObj) {
        this.priceRangeObj = priceRangeObj;
    }

    /*面积*/
    @NotEmpty(message="面积不能为空")
    private String area;
    public String getArea() {
        return area;
    }
    public void setArea(String area) {
        this.area = area;
    }

    /*租金(元/月)*/
    @NotNull(message="必须输入租金(元/月)")
    private Float price;
    public Float getPrice() {
        return price;
    }
    public void setPrice(Float price) {
        this.price = price;
    }

    /*楼层/总楼层*/
    @NotEmpty(message="楼层/总楼层不能为空")
    private String louceng;
    public String getLouceng() {
        return louceng;
    }
    public void setLouceng(String louceng) {
        this.louceng = louceng;
    }

    /*装修*/
    @NotEmpty(message="装修不能为空")
    private String zhuangxiu;
    public String getZhuangxiu() {
        return zhuangxiu;
    }
    public void setZhuangxiu(String zhuangxiu) {
        this.zhuangxiu = zhuangxiu;
    }

    /*朝向*/
    private String caoxiang;
    public String getCaoxiang() {
        return caoxiang;
    }
    public void setCaoxiang(String caoxiang) {
        this.caoxiang = caoxiang;
    }

    /*建筑年代*/
    private String madeYear;
    public String getMadeYear() {
        return madeYear;
    }
    public void setMadeYear(String madeYear) {
        this.madeYear = madeYear;
    }

    /*联系人*/
    @NotEmpty(message="联系人不能为空")
    private String connectPerson;
    public String getConnectPerson() {
        return connectPerson;
    }
    public void setConnectPerson(String connectPerson) {
        this.connectPerson = connectPerson;
    }

    /*联系电话*/
    @NotEmpty(message="联系电话不能为空")
    private String connectPhone;
    public String getConnectPhone() {
        return connectPhone;
    }
    public void setConnectPhone(String connectPhone) {
        this.connectPhone = connectPhone;
    }

    /*详细信息*/
    private String detail;
    public String getDetail() {
        return detail;
    }
    public void setDetail(String detail) {
        this.detail = detail;
    }

    /*地址*/
    private String address;
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonHourse=new JSONObject(); 
		jsonHourse.accumulate("hourseId", this.getHourseId());
		jsonHourse.accumulate("hourseName", this.getHourseName());
		jsonHourse.accumulate("buildingObj", this.getBuildingObj().getBuildingName());
		jsonHourse.accumulate("buildingObjPri", this.getBuildingObj().getBuildingId());
		jsonHourse.accumulate("housePhoto", this.getHousePhoto());
		jsonHourse.accumulate("hourseTypeObj", this.getHourseTypeObj().getTypeName());
		jsonHourse.accumulate("hourseTypeObjPri", this.getHourseTypeObj().getTypeId());
		jsonHourse.accumulate("priceRangeObj", this.getPriceRangeObj().getPriceName());
		jsonHourse.accumulate("priceRangeObjPri", this.getPriceRangeObj().getRangeId());
		jsonHourse.accumulate("area", this.getArea());
		jsonHourse.accumulate("price", this.getPrice());
		jsonHourse.accumulate("louceng", this.getLouceng());
		jsonHourse.accumulate("zhuangxiu", this.getZhuangxiu());
		jsonHourse.accumulate("caoxiang", this.getCaoxiang());
		jsonHourse.accumulate("madeYear", this.getMadeYear());
		jsonHourse.accumulate("connectPerson", this.getConnectPerson());
		jsonHourse.accumulate("connectPhone", this.getConnectPhone());
		jsonHourse.accumulate("detail", this.getDetail());
		jsonHourse.accumulate("address", this.getAddress());
		return jsonHourse;
    }}