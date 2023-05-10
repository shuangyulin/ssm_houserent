package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class GuestBook {
    /*记录编号*/
    private Integer guestBookId;
    public Integer getGuestBookId(){
        return guestBookId;
    }
    public void setGuestBookId(Integer guestBookId){
        this.guestBookId = guestBookId;
    }

    /*留言标题*/
    @NotEmpty(message="留言标题不能为空")
    private String title;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    /*留言内容*/
    @NotEmpty(message="留言内容不能为空")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*留言人*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*留言时间*/
    @NotEmpty(message="留言时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonGuestBook=new JSONObject(); 
		jsonGuestBook.accumulate("guestBookId", this.getGuestBookId());
		jsonGuestBook.accumulate("title", this.getTitle());
		jsonGuestBook.accumulate("content", this.getContent());
		jsonGuestBook.accumulate("userObj", this.getUserObj().getRealName());
		jsonGuestBook.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonGuestBook.accumulate("addTime", this.getAddTime());
		return jsonGuestBook;
    }}