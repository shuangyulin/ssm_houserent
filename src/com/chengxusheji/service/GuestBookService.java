package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.GuestBook;

import com.chengxusheji.mapper.GuestBookMapper;
@Service
public class GuestBookService {

	@Resource GuestBookMapper guestBookMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加留言信息记录*/
    public void addGuestBook(GuestBook guestBook) throws Exception {
    	guestBookMapper.addGuestBook(guestBook);
    }

    /*按照查询条件分页查询留言信息记录*/
    public ArrayList<GuestBook> queryGuestBook(String title,UserInfo userObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_guestBook.title like '%" + title + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_guestBook.userObj='" + userObj.getUser_name() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return guestBookMapper.queryGuestBook(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<GuestBook> queryGuestBook(String title,UserInfo userObj) throws Exception  { 
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_guestBook.title like '%" + title + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_guestBook.userObj='" + userObj.getUser_name() + "'";
    	return guestBookMapper.queryGuestBookList(where);
    }

    /*查询所有留言信息记录*/
    public ArrayList<GuestBook> queryAllGuestBook()  throws Exception {
        return guestBookMapper.queryGuestBookList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String title,UserInfo userObj) throws Exception {
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_guestBook.title like '%" + title + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_guestBook.userObj='" + userObj.getUser_name() + "'";
        recordNumber = guestBookMapper.queryGuestBookCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取留言信息记录*/
    public GuestBook getGuestBook(int guestBookId) throws Exception  {
        GuestBook guestBook = guestBookMapper.getGuestBook(guestBookId);
        return guestBook;
    }

    /*更新留言信息记录*/
    public void updateGuestBook(GuestBook guestBook) throws Exception {
        guestBookMapper.updateGuestBook(guestBook);
    }

    /*删除一条留言信息记录*/
    public void deleteGuestBook (int guestBookId) throws Exception {
        guestBookMapper.deleteGuestBook(guestBookId);
    }

    /*删除多条留言信息信息*/
    public int deleteGuestBooks (String guestBookIds) throws Exception {
    	String _guestBookIds[] = guestBookIds.split(",");
    	for(String _guestBookId: _guestBookIds) {
    		guestBookMapper.deleteGuestBook(Integer.parseInt(_guestBookId));
    	}
    	return _guestBookIds.length;
    }
}
