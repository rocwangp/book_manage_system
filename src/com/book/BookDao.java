package com.book;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;

public class BookDao {
	
	private static String driver_url = "com.mysql.jdbc.Driver";
	private static String user_url = System.getenv("ACCESSKEY");
	private static String password_url = System.getenv("SECRETKEY");
	private static String dbUrl = String.format("jdbc:mysql://%s:%s/%s", System.getenv("MYSQL_HOST"), System.getenv("MYSQL_PORT"), System.getenv("MYSQL_DB"));
	
//	private static String user_url = "root";
//	private static String password_url = "3764819";
//	private static String dbUrl = "jdbc:mysql://localhost:3306/bookdb";
	
	private static String query_pattern_base_url = "select * from";
	private static String update_book_pattern_base_url = "update book set";
	private static String update_author_table_pattern_base_url = "update author set";
	private static String delete_pattern_base_url = "delete from";
	private static String insert_pattern_base_url = "insert into";
	
	
	private static String book_table_pattern = "book";
	private static String author_table_pattern = "author";
	
	private static String book_table_columns_element = "ISBN,Title,AuthorID,Publisher,PublishDate,Price";
	private static String author_table_columns_element = "AuthorID,Name,Age,Country";
	

	public BookDao(){
		try{
		Class.forName(driver_url);
		}
		catch(Exception e){
			
		}
	}
	
	public ArrayList<Book> listBooks()
	{
		ArrayList<Book> booksList = new ArrayList<Book>();
		try
		{
		
			Connection conn = DriverManager.getConnection(dbUrl, user_url, password_url);
			PreparedStatement ps = conn.prepareStatement(query_pattern_base_url + " " + book_table_pattern);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				booksList.add(new Book(rs.getString("Title"), 
		   				 rs.getString("ISBN"),
		   				 rs.getInt("AuthorID"),
		   				 rs.getString("Publisher"),
		   				 rs.getString("PublishDate"),
		   				 rs.getDouble("Price")));
			}	
			conn.close();
			return booksList;
		}
		catch(Exception e)
		{
			return booksList;
		}
	}
	
	
	public ArrayList<Author> listAuthors()
	{
		
		ArrayList<Author> authorsList = new ArrayList<Author>();
		try
		{
			
			Connection conn = DriverManager.getConnection(dbUrl, user_url, password_url);
			PreparedStatement ps = conn.prepareStatement(query_pattern_base_url + " " + author_table_pattern);
			ResultSet rs = ps.executeQuery();

			while(rs.next())
			{
				authorsList.add(new Author(rs.getInt("AuthorID"),
										   rs.getString("Name"),
										   rs.getInt("Age"),
										   rs.getString("Country")));
			}
			conn.close();
			return authorsList;
		}
		catch(Exception e)
		{
			return authorsList;
		}
	}
	
	public ArrayList<Author> queryAuthors(String query_pattern, String query_element)
	{
	
		ArrayList<Author> query_authors = new ArrayList<Author>();
		try
		{
			
			
			Connection conn = DriverManager.getConnection(dbUrl, user_url, password_url);
			PreparedStatement ps = conn.prepareStatement(query_pattern_base_url + " author " + "where " + 
					query_pattern + "=\'" + query_element + "\'");
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{

				query_authors.add(new Author(rs.getInt("AuthorID"),
											 rs.getString("Name"),
											 rs.getInt("Age"),
											 rs.getString("Country")));
			}

			conn.close();
			return query_authors;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return query_authors;
		}
	}
	public void modifyBook(String table_pattern, Book book)
	{

		try
		{
			
			Connection conn = DriverManager.getConnection(dbUrl, user_url, password_url);
			PreparedStatement ps = conn.prepareStatement(update_book_pattern_base_url  + 
					" Title=?,AuthorID=?,Publisher=?,PublishDate=?,Price=? where ISBN=?");
			ps.setString(1, book.getTitle());
			ps.setInt(2, book.getAuthorID());
			ps.setString(3, book.getPublisher());
			ps.setString(4, book.getPublishDate());
			ps.setDouble(5, book.getPrice());
			ps.setString(6, book.getIsbn());
			ps.executeUpdate();
			
			conn.close();

		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public void modifyAuthor(String table_pattern, Author author)
	{

		try
		{
			
			Connection conn = DriverManager.getConnection(dbUrl, user_url, password_url);
			PreparedStatement ps = conn.prepareStatement(update_author_table_pattern_base_url + 
														" Name=?,Age=?,Country=? where AuthorID=?");
			ps.setString(1, author.getName());
			ps.setInt(2, author.getAge());
			ps.setString(3, author.getCountry());
			ps.setInt(4, author.getAuthorID());
			
			ps.executeUpdate();
			conn.close();

		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	public void deleteBook(String delete_pattern, String delete_element)
	{
		try
		{
			
			Connection conn = DriverManager.getConnection(dbUrl, user_url, password_url);
			PreparedStatement ps = conn.prepareStatement(delete_pattern_base_url + " " + book_table_pattern +  " where " + 
														delete_pattern + "=\'" + delete_element + "\'");
			ps.executeUpdate();
			conn.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public void deleteAuthor(String delete_pattern, String delete_element)
	{

		try
		{
			
			Connection conn = DriverManager.getConnection(dbUrl, user_url, password_url);
			PreparedStatement ps = conn.prepareStatement(delete_pattern_base_url + " " + author_table_pattern + " where " + 
														delete_pattern + "=\'" + delete_element + "\'");
			ps.executeUpdate();
			conn.close();

		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public void insertBook(Book book)
	{

		try
		{

			
			Connection conn = DriverManager.getConnection(dbUrl, user_url, password_url);
			PreparedStatement ps = conn.prepareStatement(insert_pattern_base_url + " book " +
													 "(" + book_table_columns_element + ")" + " values " + "(" + 
													  "\'" + book.getIsbn() + "\'," + 
													  "\'" + book.getTitle() + "\'," +
													  book.getAuthorID() + "," +
													  "\'" + book.getPublisher() + "\'," +
													  "\'" + book.getPublishDate() + "\'," + 
													  book.getPrice() + ")");
			ps.executeUpdate();

			conn.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public void insertAuthor(Author author)
	{
		try
		{

			
			Connection conn = DriverManager.getConnection(dbUrl, user_url, password_url);
			PreparedStatement ps = conn.prepareStatement(insert_pattern_base_url + " author " +
													 "(" + author_table_columns_element + ")" + " values " + "(" + 
													 author.getAuthorID() + "," + 
													 "\'" + author.getName() + "\'," +
													 author.getAge() + "," +
													 "\'" + author.getCountry() + "\')");
			ps.executeUpdate();
			conn.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public Boolean is_exist_authorid(Integer authorId)
	{
		
		try
		{
			
			Connection conn = DriverManager.getConnection(dbUrl, user_url, password_url);
			PreparedStatement ps = conn.prepareStatement(query_pattern_base_url + " " + "author" + " where " + 
														"AuthorID=" + authorId + "");
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				conn.close();
				return true;
			}
			else
			{
				conn.close();
				return false;
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return false;
		}
	}
	
	public ArrayList<Book> query_books_from_booktable( String query_pattern, String query_element)
	{
		ArrayList<Book> query_books = new ArrayList<Book>();
		try
		{
			
			Connection conn = DriverManager.getConnection(dbUrl, user_url, password_url);
			PreparedStatement ps = conn.prepareStatement(query_pattern_base_url + " " + book_table_pattern +" where " + 
														query_pattern + "=\'" + query_element + "\'");
			ResultSet rs = ps.executeQuery();

			while(rs.next())
			{
			   query_books.add(new Book(rs.getString("Title"), 
		   				 rs.getString("ISBN"),
		   				 rs.getInt("AuthorID"),
		   				 rs.getString("Publisher"),
		   				 rs.getString("PublishDate"),
		   				 rs.getDouble("Price")));
			}
			conn.close();
			return query_books;
		}
		catch(Exception e)
		{
			return query_books;
		}
	}
	
	public ArrayList<Book> query_books_from_authortable(String query_pattern, String query_element)
	{
		ArrayList<Book> query_books = new ArrayList<Book>();
		try
		{
			HashSet<Integer> author_id_set = new HashSet<Integer>();
			
			
			Connection conn = DriverManager.getConnection(dbUrl, user_url, password_url);
			PreparedStatement ps = conn.prepareStatement(query_pattern_base_url + " " + author_table_pattern +" where " + 
														query_pattern + "=\'" + query_element + "\'");
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{	
				author_id_set.add(rs.getInt("AuthorID"));
			}	
		
			
			for(Iterator<Integer> it = author_id_set.iterator(); it.hasNext();)
			{

				Integer authorId = (Integer)it.next();
				
				ps = conn.prepareStatement(query_pattern_base_url + " " + "book" +" where " + 
						"AuthorID" + "=\'" + authorId + "\'");
				rs = ps.executeQuery();
				
				while(rs.next())
				{
				  query_books.add(new Book(rs.getString("Title"), 
	   				 rs.getString("ISBN"),
	   				 rs.getInt("AuthorID"),
	   				 rs.getString("Publisher"),
	   				 rs.getString("PublishDate"),
	   				 rs.getDouble("Price")));
				}
				
			}
			conn.close();
			return query_books;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return query_books;
		}
	}
}

