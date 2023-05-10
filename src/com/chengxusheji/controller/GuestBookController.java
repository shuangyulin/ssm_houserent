package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.GuestBookService;
import com.chengxusheji.po.GuestBook;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//GuestBook管理控制层
@Controller
@RequestMapping("/GuestBook")
public class GuestBookController extends BaseController {

    /*业务层对象*/
    @Resource GuestBookService guestBookService;

    @Resource UserInfoService userInfoService;
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("guestBook")
	public void initBinderGuestBook(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("guestBook.");
	}
	/*跳转到添加GuestBook视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new GuestBook());
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "GuestBook_add";
	}

	/*客户端ajax方式提交添加留言信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated GuestBook guestBook, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        guestBookService.addGuestBook(guestBook);
        message = "留言信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询留言信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String title,@ModelAttribute("userObj") UserInfo userObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (title == null) title = "";
		if(rows != 0)guestBookService.setRows(rows);
		List<GuestBook> guestBookList = guestBookService.queryGuestBook(title, userObj, page);
	    /*计算总的页数和总的记录数*/
	    guestBookService.queryTotalPageAndRecordNumber(title, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = guestBookService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = guestBookService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(GuestBook guestBook:guestBookList) {
			JSONObject jsonGuestBook = guestBook.getJsonObject();
			jsonArray.put(jsonGuestBook);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询留言信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<GuestBook> guestBookList = guestBookService.queryAllGuestBook();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(GuestBook guestBook:guestBookList) {
			JSONObject jsonGuestBook = new JSONObject();
			jsonGuestBook.accumulate("guestBookId", guestBook.getGuestBookId());
			jsonGuestBook.accumulate("title", guestBook.getTitle());
			jsonArray.put(jsonGuestBook);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询留言信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String title,@ModelAttribute("userObj") UserInfo userObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (title == null) title = "";
		List<GuestBook> guestBookList = guestBookService.queryGuestBook(title, userObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    guestBookService.queryTotalPageAndRecordNumber(title, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = guestBookService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = guestBookService.getRecordNumber();
	    request.setAttribute("guestBookList",  guestBookList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("title", title);
	    request.setAttribute("userObj", userObj);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "GuestBook/guestBook_frontquery_result"; 
	}

     /*前台查询GuestBook信息*/
	@RequestMapping(value="/{guestBookId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer guestBookId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键guestBookId获取GuestBook对象*/
        GuestBook guestBook = guestBookService.getGuestBook(guestBookId);

        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("guestBook",  guestBook);
        return "GuestBook/guestBook_frontshow";
	}

	/*ajax方式显示留言信息修改jsp视图页*/
	@RequestMapping(value="/{guestBookId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer guestBookId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键guestBookId获取GuestBook对象*/
        GuestBook guestBook = guestBookService.getGuestBook(guestBookId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonGuestBook = guestBook.getJsonObject();
		out.println(jsonGuestBook.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新留言信息信息*/
	@RequestMapping(value = "/{guestBookId}/update", method = RequestMethod.POST)
	public void update(@Validated GuestBook guestBook, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			guestBookService.updateGuestBook(guestBook);
			message = "留言信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "留言信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除留言信息信息*/
	@RequestMapping(value="/{guestBookId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer guestBookId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  guestBookService.deleteGuestBook(guestBookId);
	            request.setAttribute("message", "留言信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "留言信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条留言信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String guestBookIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = guestBookService.deleteGuestBooks(guestBookIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出留言信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String title,@ModelAttribute("userObj") UserInfo userObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(title == null) title = "";
        List<GuestBook> guestBookList = guestBookService.queryGuestBook(title,userObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "GuestBook信息记录"; 
        String[] headers = { "留言标题","留言内容","留言人","留言时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<guestBookList.size();i++) {
        	GuestBook guestBook = guestBookList.get(i); 
        	dataset.add(new String[]{guestBook.getTitle(),guestBook.getContent(),guestBook.getUserObj().getRealName(),guestBook.getAddTime()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"GuestBook.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
