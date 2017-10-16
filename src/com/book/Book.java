package com.book;


public class Book {
	private String title;
	private String isbn;
	private Integer authorID;
	private String publisher;
	private String publishDate;
	private Double price;
	
	public Book()
	{
		
	}
	public Book(String title, String isbn, 
				Integer authorID, String publisher,
				String publishDate, Double price)
	{
		this.title = title;
		this.isbn = isbn;
		this.authorID = authorID;
		this.publisher = publisher;
		this.publishDate = publishDate;
		this.price = price;
	}
	
	
	
	public String getTitle()
	{
		return title;
	}
	
	public String getIsbn()
	{
		return isbn;
	}
	
	public Integer getAuthorID()
	{
		return authorID;
	}
	
	public Double getPrice()
	{
		return price;
	}
	
	public String getPublisher()
	{
		return publisher;
	}
	public String getPublishDate()
	{
		return publishDate;
	}
	
	public void setPublishDate(String publishDate)
	{
		this.publishDate = publishDate;
	}
	public void setTitle(String title)
	{
		this.title = title;
	}
	
	public void setIsbn(String isbn)
	{
		this.isbn = isbn;
	}
	
	public void setAuthorID(Integer authorID)
	{
		this.authorID = authorID;
	}
	
	public void setPrice(Double price)
	{
		this.price = price;
	}
	
}