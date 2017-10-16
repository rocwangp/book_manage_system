package com.book;

public class Author {

	private Integer authorID;
	private String name;
	private Integer age;
	private String country;
	
	public Author(Integer authorID, String name, Integer age, String country)
	{
		this.authorID = authorID;
		this.name = name;
		this.age = age;
		this.country = country;
	}
	
	public Integer getAuthorID()
	{
		return authorID;
	}
	
	public String getName()
	{
		return name;
	}
	
	public Integer getAge()
	{
		return age;
	}
	
	public String getCountry()
	{
		return country;
	}
	
	
	public void setAuthorID(Integer authorID)
	{
		this.authorID = authorID;
	}
	
	public void setName(String name)
	{
		this.name = name;
	}
	
	public void setAge(Integer age)
	{
		this.age = age;
	}
	
	public void setCountry(String country)
	{
		this.country = country;
	}
}
