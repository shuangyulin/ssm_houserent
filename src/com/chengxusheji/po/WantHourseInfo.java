package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class WantHourseInfo {
    /*记录编号*/
    private Integer wantHourseId;
    public Integer getWantHourseId(){
        return wantHourseId;
    }
    public void setWantHourseId(Integer wantHourseId){
        this.wantHourseId = wantHourseId;
    }

    /*求租用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*标题*/
    @NotEmpty(message="标题不能为空")
    private String title;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    /*求租区域*/
    private AreaInfo position;
    public AreaInfo getPosition() {
        return position;
    }
    public void setPosition(AreaInfo position) {
        this.position = position;
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

    /*最高能出租金*/
    @NotNull(message="必须输入最高能出租金")
    private Float price;
    public Float getPrice() {
        return price;
    }
    public void setPrice(Float price) {
        this.price = price;
    }

    /*联系人*/
    @NotEmpty(message="联系人不能为空")
    private String lianxiren;
    public String getLianxiren() {
        return lianxiren;
    }
    public void setLianxiren(String lianxiren) {
        this.lianxiren = lianxiren;
    }

    /*联系电话*/
    @NotEmpty(message="联系电话不能为空")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonWantHourseInfo=new JSONObject(); 
		jsonWantHourseInfo.accumulate("wantHourseId", this.getWantHourseId());
		jsonWantHourseInfo.accumulate("userObj", this.getUserObj().getRealName());
		jsonWantHourseInfo.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonWantHourseInfo.accumulate("title", this.getTitle());
		jsonWantHourseInfo.accumulate("position", this.getPosition().getAreaName());
		jsonWantHourseInfo.accumulate("positionPri", this.getPosition().getAreaId());
		jsonWantHourseInfo.accumulate("hourseTypeObj", this.getHourseTypeObj().getTypeName());
		jsonWantHourseInfo.accumulate("hourseTypeObjPri", this.getHourseTypeObj().getTypeId());
		jsonWantHourseInfo.accumulate("priceRangeObj", this.getPriceRangeObj().getPriceName());
		jsonWantHourseInfo.accumulate("priceRangeObjPri", this.getPriceRangeObj().getRangeId());
		jsonWantHourseInfo.accumulate("price", this.getPrice());
		jsonWantHourseInfo.accumulate("lianxiren", this.getLianxiren());
		jsonWantHourseInfo.accumulate("telephone", this.getTelephone());
		return jsonWantHourseInfo;
    }}