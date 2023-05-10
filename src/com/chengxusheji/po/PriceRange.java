package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class PriceRange {
    /*记录编号*/
    private Integer rangeId;
    public Integer getRangeId(){
        return rangeId;
    }
    public void setRangeId(Integer rangeId){
        this.rangeId = rangeId;
    }

    /*价格区间*/
    @NotEmpty(message="价格区间不能为空")
    private String priceName;
    public String getPriceName() {
        return priceName;
    }
    public void setPriceName(String priceName) {
        this.priceName = priceName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonPriceRange=new JSONObject(); 
		jsonPriceRange.accumulate("rangeId", this.getRangeId());
		jsonPriceRange.accumulate("priceName", this.getPriceName());
		return jsonPriceRange;
    }}