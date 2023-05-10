package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class NewsInfo {
    /*记录编号*/
    private Integer newsId;
    public Integer getNewsId(){
        return newsId;
    }
    public void setNewsId(Integer newsId){
        this.newsId = newsId;
    }

    /*标题*/
    @NotEmpty(message="标题不能为空")
    private String newsTitle;
    public String getNewsTitle() {
        return newsTitle;
    }
    public void setNewsTitle(String newsTitle) {
        this.newsTitle = newsTitle;
    }

    /*新闻内容*/
    @NotEmpty(message="新闻内容不能为空")
    private String newsContent;
    public String getNewsContent() {
        return newsContent;
    }
    public void setNewsContent(String newsContent) {
        this.newsContent = newsContent;
    }

    /*发布日期*/
    @NotEmpty(message="发布日期不能为空")
    private String newsDate;
    public String getNewsDate() {
        return newsDate;
    }
    public void setNewsDate(String newsDate) {
        this.newsDate = newsDate;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonNewsInfo=new JSONObject(); 
		jsonNewsInfo.accumulate("newsId", this.getNewsId());
		jsonNewsInfo.accumulate("newsTitle", this.getNewsTitle());
		jsonNewsInfo.accumulate("newsContent", this.getNewsContent());
		jsonNewsInfo.accumulate("newsDate", this.getNewsDate().length()>19?this.getNewsDate().substring(0,19):this.getNewsDate());
		return jsonNewsInfo;
    }}