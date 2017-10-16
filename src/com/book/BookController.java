package com.book;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.regex.*;

@Controller
public class BookController {
	
   private static BookDao bookDao = new BookDao();


   private String convertFormat(String data)
   {
	   Pattern p = Pattern.compile("<");
	   Matcher m = p.matcher(data);
	   data = m.replaceAll("¡¶");
	   
	   p = Pattern.compile(">");
	   m = p.matcher(data);
	   data = m.replaceAll("¡·");
	   return data;
   }
   
   @RequestMapping("/")
   public String mainHome()
   {
	   return "reader_main";
   }
   

   @RequestMapping("/reader_book_list_clicked")
   public void readerListBookClicked(HttpServletResponse response) throws ServletException, IOException
   {

	   ArrayList<Book> books = bookDao.listBooks();
	   String json = JSONArray.fromObject(books).toString();
	   
	   PrintWriter pw = response.getWriter();
	   pw.print(json);
	   pw.flush();
	   pw.close();
   }
   
   @RequestMapping({"/reader_book_modify_clicked", "/reader_book_delete_clicked"})
   public void readerModifyBookClicked(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
	   
	   String isbn = request.getParameter("isbn");
	   PrintWriter pw = response.getWriter();
	   Book book = bookDao.query_books_from_booktable("ISBN", isbn).get(0);
	   String json = "{'title':\'" + book.getTitle() + "\','isbn':\'" + book.getIsbn() + "\','authorID':\'" + book.getAuthorID() +
			   "\','publisher':\'" + book.getPublisher() + "\','publishDate':\'" + book.getPublishDate() + "\','price':\'" + book.getPrice() + "\'}";
	   pw.print(json);
	   pw.flush();
	   pw.close();
   }
    
   
   @RequestMapping("/reader_book_modify_submit_clicked")
   public void readerModifyBookSubmitClicked(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
   {

	   String title = convertFormat(request.getParameter("title"));
	   Integer authorID = Integer.parseInt(request.getParameter("authorID"));
	   String isbn = convertFormat(request.getParameter("isbn"));
	   String publisher = convertFormat(request.getParameter("publisher"));
	   String publishDate = convertFormat(request.getParameter("publishDate"));
	   Double price = Double.parseDouble(request.getParameter("price"));
	   
	   String book_string = "";
	   String result_string = "";

	   Book book = new Book(title, isbn, authorID, publisher, publishDate, price);
	   bookDao.modifyBook("ISBN", book);
   
	   book_string = JSONObject.fromObject(book).toString();
   
	   Boolean authorid_exist = bookDao.is_exist_authorid(authorID);
	   if(authorid_exist)
		   result_string = "{\"exist\":\"yes\"}";
	   else
		   result_string = "{\"exist\":\"no\"}";
	   
	   ArrayList<String> jsonList = new ArrayList<String>();
	   jsonList.add(result_string);
	   jsonList.add(book_string);
	   
	   String json = JSONArray.fromObject(jsonList).toString();

	   PrintWriter pw = response.getWriter();
	   pw.print(json);
	   pw.flush();
	   pw.close();
   }
   
   @RequestMapping("/reader_book_delete_submit_clicked")
   public void readerDeleteBookSubmitClicked(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
   {

	   String isbn = request.getParameter("isbn");
	   bookDao.deleteBook("ISBN", isbn);

	   PrintWriter pw = response.getWriter();
	   String json = "{'result':'success'}";
	  
	   pw.print(json);
	   pw.flush();
	   pw.close();
   }
   
   @RequestMapping("/reader_book_query_submit_clicked")
   public void readerQueryBookSubmitClicked(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
   {
	  
	   String title = request.getParameter("title");
	   
	   ArrayList<Book> books = bookDao.query_books_from_booktable("Title", title);
	   if(books.size() != 0){
		   Book book = bookDao.query_books_from_booktable("Title", title).get(0);
		   String json = JSONObject.fromObject(book).toString();
		   PrintWriter pw = response.getWriter();
		   pw.print(json);
		   pw.flush();
		   pw.close();
	   }
   }
   
   
   @RequestMapping("/reader_book_detail_clicked")
   public void readerDetailBookClicked(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
	  
	   String isbn = request.getParameter("isbn");
	   ArrayList<Book> books = bookDao.query_books_from_booktable("ISBN", isbn);
	   Book book = null;
	   if(books.size() != 0)
		   book = books.get(0);
	   ArrayList<Author> authors = bookDao.queryAuthors("AuthorID", book.getAuthorID().toString());
	   Author author = null;
	   if(authors.size() != 0)
		   author = authors.get(0);
	   
	   PrintWriter pw = response.getWriter();
	   String json = JSONObject.fromObject(author).toString();
	   pw.print(json);
	   pw.flush();
	   pw.close();
   }
   
   
   @RequestMapping("/reader_book_add_submit_clicked")
   public void readerAddBookClicked(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
	   
	   String title = convertFormat(request.getParameter("title"));
	   Integer authorID = Integer.parseInt(request.getParameter("authorID"));
	   String isbn = convertFormat(request.getParameter("isbn"));
	   String publisher = convertFormat(request.getParameter("publisher"));
	   String publishDate = convertFormat(request.getParameter("publishDate"));
	   Double price = Double.parseDouble(request.getParameter("price"));
	   
	   String book_string = "";
	   String result_string = "";


	   Book book = new Book(title, isbn, authorID, publisher, publishDate, price);
	   bookDao.insertBook(book);
   
	   book_string = JSONObject.fromObject(book).toString();
   
	   Boolean authorid_exist = bookDao.is_exist_authorid(authorID);

	   if(authorid_exist)
		   result_string = "{\"exist\":\"yes\"}";
	   else
		   result_string = "{\"exist\":\"no\"}";
	   
	   
	   ArrayList<String> jsonList = new ArrayList<String>();
	   jsonList.add(result_string);
	   jsonList.add(book_string);
	   
	   String json = JSONArray.fromObject(jsonList).toString();
	 
	   PrintWriter pw = response.getWriter();
	   pw.print(json);
	   
	   pw.flush();
	   pw.close();
	   
   }
   
  

 

   
   

   


   
   @RequestMapping("/reader_author_list_clicked")
   public void readerAuthorListButtonClicked(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
	   ArrayList<Author> authors = bookDao.listAuthors();
	   String json = JSONArray.fromObject(authors).toString();
	   
	   PrintWriter pw = response.getWriter();
	   pw.print(json);
	   pw.flush();
	   pw.close();
   }
   
   @RequestMapping("/reader_author_delete_clicked")
   public void readerAuthorDeleteButtonClicked(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
	  
	   Integer authorID = Integer.parseInt(request.getParameter("authorID"));
	   ArrayList<Author> authors = bookDao.queryAuthors("AuthorID", authorID.toString());
	   
	   String json = JSONObject.fromObject(authors.get(0)).toString();
	   PrintWriter pw = response.getWriter();
	   pw.print(json);
	   pw.flush();
	   pw.close();
   }
   @RequestMapping("/reader_author_delete_submit_clicked")
   public void readerAuthorDeleteButtonSubmitClicked(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
	   
	   Integer authorID = Integer.parseInt(request.getParameter("authorID"));
	   bookDao.deleteAuthor("AuthorID", authorID.toString());
	   
	   String json = "{'result': 'success'}";
	   PrintWriter pw = response.getWriter();
	   pw.print(json);
	   pw.flush();
	   pw.close();
   }
   @RequestMapping("/reader_author_modify_clicked")
   public void readerAuthorModifyButtonClicked(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
	   
	   Integer authorId = Integer.parseInt(request.getParameter("authorID"));
	   ArrayList<Author> authors = bookDao.queryAuthors("AuthorID", authorId.toString());

	   PrintWriter pw = response.getWriter();
	   String json = JSONObject.fromObject(authors.get(0)).toString();
	   System.out.println(json);
	   pw.print(json);
	   pw.flush();
	   pw.close();
   }
   
   @RequestMapping("/reader_author_modify_submit_clicked")
   public void readerAuthorModifySubmitButtonClicked(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
	  
	   Integer authorID = Integer.parseInt(request.getParameter("authorID"));
	   String name = convertFormat(request.getParameter("name"));
	   Integer age = Integer.parseInt(request.getParameter("age"));
	   String country = convertFormat(request.getParameter("country"));

	   Author author = new Author(authorID, name, age, country);
	   bookDao.modifyAuthor("AuthorID", author);
	   

	   String json = JSONObject.fromObject(author).toString();
	   PrintWriter pw = response.getWriter();
	   System.out.println(json);
	   pw.print(json);
	   pw.flush();
	   pw.close();
   }
   @RequestMapping("/reader_author_add_submit_clicked")
   public void readerAddAuthorButtonClicked(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
	  
	   Integer authorID = Integer.parseInt(request.getParameter("authorID"));
	   String name = convertFormat(request.getParameter("name"));
	   Integer age = Integer.parseInt(request.getParameter("age"));
	   String country = convertFormat(request.getParameter("country"));

	   Author author = new Author(authorID, name, age, country);
	   bookDao.insertAuthor(author);
	   
	   PrintWriter pw = response.getWriter();
	   String json = JSONObject.fromObject(author).toString();
	   
	   pw.print(json);
	   pw.flush();
	   pw.close();
   }

   @RequestMapping("/reader_author_query_clicked")
   public void readerQueryAuthorButtonClicked(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
	  
	   String name = request.getParameter("name");
	   ArrayList<Author> authors = bookDao.queryAuthors("Name", name);
	  
	   
	   PrintWriter pw = response.getWriter();
	   String json = JSONObject.fromObject(authors.get(0)).toString();
	  
	   pw.print(json);
	   pw.flush();
	   pw.close();
   }
   
}