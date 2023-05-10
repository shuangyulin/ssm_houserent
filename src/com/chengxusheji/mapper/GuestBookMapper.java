package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.GuestBook;

public interface GuestBookMapper {
	/*添加留言信息信息*/
	public void addGuestBook(GuestBook guestBook) throws Exception;

	/*按照查询条件分页查询留言信息记录*/
	public ArrayList<GuestBook> queryGuestBook(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有留言信息记录*/
	public ArrayList<GuestBook> queryGuestBookList(@Param("where") String where) throws Exception;

	/*按照查询条件的留言信息记录数*/
	public int queryGuestBookCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条留言信息记录*/
	public GuestBook getGuestBook(int guestBookId) throws Exception;

	/*更新留言信息记录*/
	public void updateGuestBook(GuestBook guestBook) throws Exception;

	/*删除留言信息记录*/
	public void deleteGuestBook(int guestBookId) throws Exception;

}
