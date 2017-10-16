<%@ page language="java" contentType="text/html; charset=UTF-8"  
    pageEncoding="UTF-8"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>  

<!DOCTYPE html>
<html lang="zh-CN">


<head>
	

	<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
	
    <title>图书信息</title>
    
    
    <script type="text/javascript">
    	function hideBooksAndAuthorsDiv(){
    		$("#books_div").hide();
    		$("#authors_div").hide();
    	}
    </script>
</head>
<body onLoad="hideBooksAndAuthorsDiv()">

<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target="#example-navbar-collapse">
                <span class="sr-only">切换导航</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand">我的图书馆</a>
        </div>
        <div class="collapse navbar-collapse" id="example-navbar-collapse">
            <ul class="nav navbar-nav navbar-left">
            
                
            	<li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        图书管理
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                  	  <li class="divider"></li>
                        <li><a onclick="onListBookButtonClicked()">全部图书</a></li>
                        <li class="divider"></li>
                        <li><a  onclick="onAddBookButtonClicked()" data-toggle="modal" data-target="#addbook">增加图书</a></li>
                        <li class="divider"></li>
                        <li><a  onclick="onQueryBookButtonClicked()" data-toggle="modal" data-target="#querybook">查询图书</a></li>
                    </ul>
                </li>
				
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">
					作者管理
						<b class="caret"></b>
					</a>
					<ul class="dropdown-menu">
						<li class="divider"></li>
						<li><a  onclick="onListAuthorButtonClicked()">全部作者</a></li>
						<li class="divider"></li>
						<li><a  onclick="onAddAuthorButtonClicked()" data-toggle="modal" data-target="#addauthor">增加作者</a></li>
						<li class="divider"></li>
						<li><a  onclick="onQueryAuthorButtonClicked()" data-toggle="modal" data-target="#queryauthor">查询作者</a></li>
					</ul>
            </ul>
        </div>
    </div>
</nav>


<!-- 图书查询 模态框 -->
<div class="modal fade" id="querybook" tabindex="-1" role="dialog" aria-labelledby="querybook" aria-hidden="true"  data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="query_form_header">
				查询图书
				</h4>
			</div>
			
			<div class="modal-body">
				<div class="form-group">
					<label for="book_name" class="col-sm-3 control-label">书名</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="book_query_title" name="title">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button onclick="onQueryBookSubmitButtonClicked()" type="submit" class="btn btn-primary">提交
					</button><span id="book_query_submit_btn"></span>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 添加图书（Modal） -->
<div class="modal fade" id="addbook" tabindex="-1" role="dialog" aria-labelledby="addbook" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title" id="book_add_header">
                           添加图书
            </h4>
        </div>
        
        <div class="modal-body">
            <div class="form-group">
                 <label for="title" class="col-sm-3 control-label">书名</label>
                  <div class="col-sm-9">
                      <input type="text" class="form-control" id="book_add_title" name="title" value="" placeholder="请输入书名">
                  </div>
         </div>    
                    
         <div class="form-group">
              <label for="isbn" class="col-sm-3 control-label">ISBN</label>
               <div class="col-sm-9">
                    <input type="text" class="form-control" id="book_add_isbn" name="isbn" placeholder="请输入ISBN">
                </div>
         </div>
                
         <div class="form-group">
                <label for="authorId" class="col-sm-3 control-label">作者ID</label>
                <div class="col-sm-9">
                     <input type="text" class="form-control" name="authorID" value="" id="book_add_authorID" placeholder="请输入作者ID">
                 </div>
          </div>
                 
          <div class="form-group">
               <label for="publisher" class="col-sm-3 control-label">出版社</label>
               <div class="col-sm-9">
                    <input type="text" class="form-control" name="publisher" value="" id="book_add_publisher" placeholder="请输入出版社">
               </div>
          </div>
                  
          <div class="form-group">
               <label for="publishDate" class="col-sm-3 control-label">出版日期</label>
               <div class="col-sm-9">
  						  <input type="text" class="form-control"  name="publishDate" value="" id="book_add_publishDate" placeholder="请输入日期">
               </div>
          </div>
          
	<div class="form-group">
	     <label for="price" class="col-sm-3 control-label">价格</label>
	     <div class="col-sm-9">
	         <input type="text" class="form-control" name="price" value="" id="book_add_price"  placeholder="请输入价格">
	      </div>
	</div>
                   
            </div>
            <div class="modal-footer">
                <button type="button" id="closebtn" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="submit" onclick ="onAddBookSubmitButtonClicked()" class="btn btn-primary"> 提交</button><span id="book_add_submit_btn"> </span>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- 修改图书（Modal） -->
<div class="modal fade" id="modifybook" tabindex="-1" role="dialog" aria-labelledby="modifybook" aria-hidden="true"  data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="book_modify_header">
                    修改图书
                </h4>
            </div>
            <div class="modal-body">
              
                 <div class="form-group">
                        <label for="title" class="col-sm-3 control-label">书名</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="book_modify_title" name="title"
                                   >
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="isbn" class="col-sm-3 control-label">ISBN</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="book_modify_isbn" name="isbn"
                                   placeholder="请输入ISBN">
                        </div>
                    </div>
                   
                    <div class="form-group">
                        <label for="authorId" class="col-sm-3 control-label">作者ID</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="authorID"  id="book_modify_authorID"
                                   placeholder="作者ID">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="publisher" class="col-sm-3 control-label">出版社</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="publisher"  id="book_modify_publisher"
                                   placeholder="出版社">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="publishDate" class="col-sm-3 control-label">出版日期</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="publishDate" id="book_modify_publishDate"
                                   placeholder="出版日期">
                        </div>
                    </div>
          
                                  <div class="form-group">
                        <label for="price" class="col-sm-3 control-label">价格</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="price"  id="book_modify_price"
                                   placeholder="价格">
                        </div>
                    </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button onclick = "onModifyBookSubmitButtonClicked()" class="btn btn-primary">
                    提交
                </button><span id="book_modify_submit_btn"> </span>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- 图书详细信息 -->
<div class="modal fade" id="detailbook" tabindex="-1" role="dialog" aria-labelledby="detailbook" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="book_detail_header">
                    图书信息
                </h4>
            </div>
            <div class="modal-body">
              
                 <div class="form-group">
                        <label for="title" class="col-sm-3 control-label">书名</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="book_detail_title" name="title"
                                   >
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="isbn" class="col-sm-3 control-label">ISBN</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="book_detail_isbn" name="isbn"
                                   placeholder="请输入ISBN">
                        </div>
                    </div>
                   
                    <div class="form-group">
                        <label for="authorId" class="col-sm-3 control-label">作者ID</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="authorID"  id="book_detail_authorID"
                                   placeholder="作者ID">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="publisher" class="col-sm-3 control-label">出版社</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="publisher"  id="book_detail_publisher"
                                   placeholder="出版社">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="publishDate" class="col-sm-3 control-label">出版日期</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="publishDate" id="book_detail_publishDate"
                                   placeholder="出版日期">
                        </div>
                    </div>
          
                                  <div class="form-group">
                        <label for="price" class="col-sm-3 control-label">价格</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="price"  id="book_detail_price"
                                   placeholder="价格">
                        </div>
                    </div>
            </div>

 		
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>

               <h4 class="modal-title" id="author_detail_header">
                    作者信息
                </h4>
            <div class="modal-body">
                    <div class="form-group">
                        <label for="publisher" class="col-sm-3 control-label">ID</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="authorID"  id="author_detail_authorID"
                                   placeholder="出版社">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="publishDate" class="col-sm-3 control-label">姓名</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="name" id="author_detail_name"
                                   placeholder="出版日期">
                        </div>
                    </div>
          
                        <div class="form-group">
                        <label for="price" class="col-sm-3 control-label">年龄</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="age"  id="author_detail_age"
                                   placeholder="价格">
                        </div>
                    </div>       
                    
                       <div class="form-group">
                        <label for="price" class="col-sm-3 control-label">国家</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="country"  id="author_detail_country"
                                   placeholder="价格">
                        </div>
                    </div>           	
            </div>
            </div>
       
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>








   <!-- 删除图书（Modal） -->

<div class="modal fade" id="deletebook" tabindex="-1" role="dialog" aria-labelledby="deletebook" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="book_delete_header">
                    确定要删除吗
                </h4>
            </div>
            <div class="modal-body">
              
                 <div class="form-group">
                        <label for="title" class="col-sm-3 control-label">书名</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="book_delete_title" name="title"
                                   >
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="isbn" class="col-sm-3 control-label">ISBN</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="book_delete_isbn" name="isbn"
                                   placeholder="请输入ISBN">
                        </div>
                    </div>
                   
                    <div class="form-group">
                        <label for="authorId" class="col-sm-3 control-label">作者ID</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="authorID"  id="book_delete_authorID"
                                   placeholder="作者ID">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="publisher" class="col-sm-3 control-label">出版社</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="publisher"  id="book_delete_publisher"
                                   placeholder="出版社">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="publishDate" class="col-sm-3 control-label">出版日期</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="publishDate" id="book_delete_publishDate"
                                   placeholder="出版日期">
                        </div>
                    </div>
          
                                  <div class="form-group">
                        <label for="price" class="col-sm-3 control-label">价格</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="price"  id="book_delete_price"
                                   placeholder="价格">
                        </div>
                    </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button onclick = "onDeleteBookSubmitButtonClicked()" class="btn btn-primary">
                    提交
                </button><span id="book_delete_submit_btn"> </span>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>




 

<!-- 作者查询 模态框 -->

<div class="modal fade" id="queryauthor" tabindex="-1" role="dialog" aria-labelledby="queryauthor" aria-hidden="true" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="queryauthor">
				查询作者
				</h4>
			</div>
			<div class="modal-body">
			
				<div class="form-group">
					<label for="author_name" class="col-sm-3 control-label">作者名</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="author_query_name" name="name" placeholder="请输入作者名">
					</div>
				</div>
			</div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button onclick="onQueryAuthorSubmitButtonClicked()" type="submit" class="btn btn-primary">提交
                    </button><span id="name"> </span>
                </div>     
		</div>
	</div>
</div>



<!-- 添加作者 -->
<div class="modal fade"  id="addauthor" tabindex="-1" role="dialog" aria-labelledby="addauthor" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"  >
                &times;
            </button>
            <h4 class="modal-title" id="addauthor" >
                           添加作者
            </h4>
        </div>
        
        
        <div class="modal-body">
            <div class="form-group">
                 <label for="title" class="col-sm-3 control-label">ID</label>
                  <div class="col-sm-9">
                      <input type="text" class="form-control" id="author_add_authorID" name="authorID" placeholder="请输入ID">
                  </div>
         </div>    
                    
         <div class="form-group">
              <label for="isbn" class="col-sm-3 control-label">姓名</label>
               <div class="col-sm-9">
                    <input type="text" class="form-control" id="author_add_name" name="name" placeholder="请输入姓名">
                </div>
         </div>
                
         <div class="form-group">
                <label for="authorId" class="col-sm-3 control-label">年龄</label>
                <div class="col-sm-9">
                     <input type="text" class="form-control" name="age" value="" id="author_add_age" placeholder="请输入年龄">
                 </div>
          </div>
                 
          <div class="form-group">
               <label for="publisher" class="col-sm-3 control-label">国家</label>
               <div class="col-sm-9">
                    <input type="text" class="form-control" name="country" value="" id="author_add_country" placeholder="请输入国家">
               </div>
          </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="submit" onclick="onAddAuthorSubmitButtonClicked()" class="btn btn-primary"> 提交</button><span id="author"> </span>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

    


<!-- 修改作者信息 -->
   
<div class="modal fade" id="modifyauthor" tabindex="-1" role="dialog" aria-labelledby="modifyauthor" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="modifyauthor">
                    修改作者
                </h4>
            </div>
            <div class="modal-body">
              
                 <div class="form-group">
                        <label for="title" class="col-sm-3 control-label">ID</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="author_modify_authorID" name="authorID"
                                   placeholder="请输入ID">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="isbn" class="col-sm-3 control-label">姓名</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="author_modify_name" name="name"
                                   placeholder="请输入姓名">
                        </div>
                    </div>
                   
                    <div class="form-group">
                        <label for="authorId" class="col-sm-3 control-label">年龄</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="age"  id="author_modify_age"
                                   placeholder="请输入年龄">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="publisher" class="col-sm-3 control-label">国家</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="country"  id="author_modify_country"
                                   placeholder="请输入国家">
                        </div>
                    </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button onclick="onModifyAuthorSubmitButtonClicked()" type="submit" class="btn btn-primary">
                    提交
                </button><span id="author"> </span>
            </div>

        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>






  <!-- 删除作者（Modal） -->

<div class="modal fade" id="deleteauthor" tabindex="-1" role="dialog" aria-labelledby="deleteauthor" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="author_delete_header">
                    确定要删除吗
                </h4>
            </div>
            <div class="modal-body">
              
                 <div class="form-group">
                        <label for="title" class="col-sm-3 control-label">ID</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="author_delete_authorID" name="authorID"
                                   >
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="isbn" class="col-sm-3 control-label">姓名</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="author_delete_name" name="name"
                                  >
                        </div>
                    </div>
                   
                    <div class="form-group">
                        <label for="authorId" class="col-sm-3 control-label">年龄</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="age"  id="author_delete_age"
                                   >
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="publisher" class="col-sm-3 control-label">国家</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="country"  id="author_delete_country"
                                 >
                        </div>
                    </div>

                  
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button onclick = "onDeleteAuthorSubmitButtonClicked()" class="btn btn-primary">
                    提交
                </button><span id="author_delete_submit_btn"> </span>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>


<!-- 图书列表 -->

<div id = "books_div" class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">
            图书列表：
        </h3>
    </div>
    <div id = "books_list" class="panel-body">
        <table id = "books_table" class="table table-hover">
            <thead>
            <tr>
                <th>书名</th>
                <th>作者</th>
                <th>出版社</th>
               	<th>出版日期</th>
                <th>ISBN</th>
                <th>价格</th>
                <th>详情</th>
                <th>修改</th>
                <th>删除</th>
            </tr>
            </thead>
            <tbody id = "books_tbody">
            <c:forEach items="${books}" var="book">
                <tr id = "book${book.isbn }">
                    <td>${book.title }</td>
   					<td>${book.authorID}</td>
                   	<td>${book.publisher}</td>
                   	<td>${book.publishDate }</td>
                   	<td>${book.isbn}</td>
                   	<td>${book.price }</td>
                   	<td><a><button type="button" class="btn btn-success btn-xs" data-toggle="modal" data-target="#detailbook" onclick="onDetailBookButtonClicked(${book.isbn})">详情</button></a></td>
					<td><a><button type="button" class="btn btn-success btn-xs" data-toggle="modal" data-target="#modifybook" onclick="onModifyBookButtonClicked(${book.isbn})">修改</button></a></td>
                   	<td><a><button type="button" class="btn btn-success btn-xs" data-toggle="modal" data-target="#deletebook" onclick="onDeleteBookButtonClicked(${book.isbn})">删除</button></a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>



<!-- 作者列表 -->
<div id="authors_div" class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">
            查询结果：
        </h3>
    </div>
    <div class="panel-body">
        <table id="authors_table" class="table table-hover">
            <thead>
            <tr>
                <th>ID</th>
                <th>姓名</th>
                <th>年龄</th>
               	<th>国家</th>
               	<th>修改</th>
               	<th>删除</th>
            </tr>
            </thead>
            <tbody id="authors_tbody">
            <c:forEach items="${authors}" var="author">
                <tr id="author${author.authorID }">
                    <td>${author.authorID }</td>
   					<td>${author.name}</td>
                   	<td>${author.age}</td>
                   	<td>${author.country }</td>
                   	<td><a><button type="button" class="btn btn-success btn-xs" data-toggle="modal" data-target="#modifyauthor" onclick="onModifyAuthorButtonClicked(${author.authorID})">修改</button></a></td>
                   	<td><a><button type="button" class="btn btn-success btn-xs" data-toggle="modal" data-target="#deleteauthor" onclick="onDeleteAuthorButtonClicked(${author.authorID})">删除</button></a></td>		
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>






<!--  
<script> 
     //绑定模态框展示的方法 
    $('#modifybook').on('show.bs.modal', function (event) {  
        var button = $(event.relatedTarget) // 触发事件的按钮  
        var modal = $(this)  //获得模态框本身
        modal.find('.modal-body input').eq(0).val(button.data('title'))  
        modal.find('.modal-body input').eq(1).val(button.data('isbn'))
        modal.find('.modal-body input').eq(2).val(button.data('authorid'))
        modal.find('.modal-body input').eq(3).val(button.data('publisher'))
        modal.find('.modal-body input').eq(4).val(button.data('publishdate'))
        modal.find('.modal-body input').eq(5).val(button.data('price'))
    })  
</script>  
-->

<script type="text/javascript">
	function onListBookButtonClicked(){
		$.ajax({
			type : "get",
			url : "reader_book_list_clicked",
			dataType: "json",
			success: function(data){
				
				var books_tbody = $("#books_tbody tr");
				for(var i = 0; i < books_tbody.length; ++i){
					books_tbody.eq(i).remove();
				}
				for(var i = 0; i < data.length; ++i){
				     var book = data[i];
					 $("#books_table tbody").prepend("<tr id=\"book" + book.isbn + "\">" + 
	 						 "<td>" + book.title + "</td>" + 
	 						 "<td>" + book.authorID + "</td>" + 
	 						 "<td>" + book.publisher + "</td>" + 
	 						 "<td>" + book.publishDate + "</td>" + 
	 						 "<td>" + book.isbn + "</td>" + 
	 						 "<td>" + book.price + "</td>" + 
	 						 "<td><a><button type=\"button\" class=\"btn btn-success btn-xs\" data-toggle=\"modal\" data-target=\"#detailbook\" onclick=\"onDetailBookButtonClicked(" + book.isbn + ")\"" + ">详情</button></a></td>" + 
	 						 "<td><a><button type=\"button\" class=\"btn btn-success btn-xs\" data-toggle=\"modal\" data-target=\"#modifybook\" onclick=\"onModifyBookButtonClicked(" + book.isbn + ")\"" + ">修改</button></a></td>" + 
	                       	 "<td><a><button type=\"button\" class=\"btn btn-success btn-xs\" data-toggle=\"modal\" data-target=\"#deletebook\" onclick=\"onDeleteBookButtonClicked(" + book.isbn + ")\"" + ">删除</button></a></td>" + 
	 						 "</tr>");
				}
				if(!$("#authors_div").is(":hidden"))
					$("#authors_div").hide();
				if($("#books_div").is(":hidden"))
					$("#books_div").show();
			},
			error: function(){
				alert("error")

			}
		});
	}
</script>


<script type="text/javascript">
	function onModifyBookButtonClicked(isbn){
		$.ajax({
			type: 'post',
			data :{
				"isbn": isbn
			},
			url : "reader_book_modify_clicked",
			success: function(data){
				var obj = eval('(' + data + ')');
				$("#book_modify_title").val(obj.title),
				$("#book_modify_authorID").val(obj.authorID),
				$("#book_modify_isbn").val(obj.isbn),
				$("#book_modify_publisher").val(obj.publisher),
				$("#book_modify_publishDate").val(obj.publishDate),
				$("#book_modify_price").val(obj.price),
				
				$("#book_modify_title").attr("readonly", "readonly"),
				$("#book_modify_isbn").attr("readonly", "readonly")
			},
			error: function(){
				
			},
			complete: function(){
				
			}
		});
	}
</script>

<script type="text/javascript">
	function onModifyBookSubmitButtonClicked(){
		if($("#book_modify_title").val()=='' || 
				$("#book_modify_isbn").val()==''||
				$("#book_modify_authorID").val()==''||
				$("#book_modify_publisher").val()==''||
				$("#book_modify_publishDate").val()==''||
				$("#book_modify_price").val()==""){
			alert("请输入完整信息");
			return false;
		}
		
		$.ajax({
			type: 'post',
			url : 'reader_book_modify_submit_clicked',
			dataType : "json",
			data: {
				title : $("#book_modify_title").val(),
				isbn: $("#book_modify_isbn").val(),
				authorID: $("#book_modify_authorID").val(),
				publisher: $("#book_modify_publisher").val(),
				publishDate: $("#book_modify_publishDate").val(),
				price: $("#book_modify_price").val()
			},
			success: function(data){
				if(data[0].exist=="no"){
					 $("#addauthor").modal('show');
				 }

				$("#book"+data[1].isbn).children().eq(0).text(data[1].title);
				$("#book"+data[1].isbn).children().eq(1).text(data[1].authorID);
				$("#book"+data[1].isbn).children().eq(2).text(data[1].publisher);
				$("#book"+data[1].isbn).children().eq(3).text(data[1].publishDate);
				$("#book"+data[1].isbn).children().eq(4).text(data[1].isbn);
				$("#book"+data[1].isbn).children().eq(5).text(data[1].price);
			},
			error: function(){				
				alert("modify error");
			},
			complete: function(){
				$("#modifybook").modal('hide')
			}
		});
	}
</script>

<script type="text/javascript">
	function onQueryBookButtonClicked(){
		$("#book_query_title").val("");
	}
	
</script>


<script type="text/javascript">
 	function onQueryBookSubmitButtonClicked(){
 		if($("#book_query_title").val()==''){
 			alert("请输入完整信息");
 			return false;
 		}
 		$.ajax({
 			type: "post",
 			url: "reader_book_query_submit_clicked",
 			data:{
 				title: $("#book_query_title").val()
 			},
 			dataType: "json",
 			success: function(data){
 						
 				var book_tbody = $("#books_tbody tr");
 				
 				for(var i = 0; i < book_tbody.length; ++i){
 						book_tbody.eq(i).remove();
 				}
 				
 				var book = data;
				 $("#books_table tbody").prepend("<tr id=\"book" + book.isbn + "\">" + 
 						 "<td>" + book.title + "</td>" + 
 						 "<td>" + book.authorID + "</td>" + 
 						 "<td>" + book.publisher + "</td>" + 
 						 "<td>" + book.publishDate + "</td>" + 
 						 "<td>" + book.isbn + "</td>" + 
 						 "<td>" + book.price + "</td>" + 
 						 "<td><a><button type=\"button\" class=\"btn btn-success btn-xs\" data-toggle=\"modal\" data-target=\"#detailbook\" onclick=\"onDetailBookButtonClicked(" + book.isbn + ")\"" + ">详情</button></a></td>" + 
 						 "<td><a><button type=\"button\" class=\"btn btn-success btn-xs\" data-toggle=\"modal\" data-target=\"#modifybook\" onclick=\"onModifyBookButtonClicked(" + book.isbn + ")\"" + ">修改</button></a></td>" + 
                       	 "<td><a><button type=\"button\" class=\"btn btn-success btn-xs\" data-toggle=\"modal\" data-target=\"#deletebook\" onclick=\"onDeleteBookButtonClicked(" + book.isbn + ")\"" + ">删除</button></a></td>" + 
 						 "</tr>");
				 
 			
 			},
 			error: function(){
 				var book_tbody = $("#books_tbody tr");
 				for(var i = 0; i < book_tbody.length; ++i){
						book_tbody.eq(i).remove();
				}
 			},
 			complete: function(){
				$("#querybook").modal('hide');
 				
				if(!$("#authors_div").is(":hidden"))
					$("#authors_div").hide();
				if($("#books_div").is(":hidden"))
					$("#books_div").show();
				
 			}
 		});
 	}
 
 </script>   


<script type="text/javascript">
	function onDeleteBookButtonClicked(isbn){
		$.ajax({
			type: 'post',
			data :{
				"isbn": isbn
			},
			url : "reader_book_delete_clicked",
			success: function(data){
				var obj = eval('(' + data + ')');
				$("#book_delete_title").val(obj.title),
				$("#book_delete_authorID").val(obj.authorID),
				$("#book_delete_isbn").val(obj.isbn),
				$("#book_delete_publisher").val(obj.publisher),
				$("#book_delete_publishDate").val(obj.publishDate),
				$("#book_delete_price").val(obj.price),
				
				$("#book_delete_title").attr("readonly", "readonly"),
				$("#book_delete_authorID").attr("readonly", "readonly"),
				$("#book_delete_isbn").attr("readonly", "readonly"),
				$("#book_delete_publisher").attr("readonly", "readonly"),
				$("#book_delete_publishDate").attr("readonly", "readonly"),
				$("#book_delete_price").attr("readonly", "readonly")
			},
			error: function(){
				alert("delete error")
			},
			complete: function(){
				
			}
		});
	}
</script>

<script type="text/javascript">
	function onDeleteBookSubmitButtonClicked(){
		
		var delete_isbn = $("#book_delete_isbn").val();
		$.ajax({
			type: 'post',
			url : 'reader_book_delete_submit_clicked',
			data: {
				isbn: delete_isbn
			},
			success: function(data){
				
				$("#book"+ delete_isbn).remove();
			},
			error: function(){
				alert("delete error");
			},
			complete: function(){
				$("#deletebook").modal('hide')
			}
		});
	}
</script>

<script type="text/javascript">
	function onDetailBookButtonClicked(isbn){
		
		$.ajax({
			type: 'post',
			data :{
				"isbn": isbn
			},
			url : "reader_book_detail_clicked",
			dataType: "json",
			success: function(data){

				$("#book_detail_title").val($("#book"+isbn).children().eq(0).text());
				$("#book_detail_authorID").val($("#book"+isbn).children().eq(1).text());
				$("#book_detail_publisher").val($("#book"+isbn).children().eq(2).text());
				$("#book_detail_publishDate").val($("#book"+isbn).children().eq(3).text());
				$("#book_detail_isbn").val($("#book"+isbn).children().eq(4).text());
				$("#book_detail_price").val($("#book"+isbn).children().eq(5).text());
				
				$("#author_detail_authorID").val(data.authorID),
				$("#author_detail_name").val(data.name),
				$("#author_detail_age").val(data.age),
				$("#author_detail_country").val(data.country),
				
				$("#book_detail_title").attr("readonly", "readonly"),
				$("#book_detail_authorID").attr("readonly", "readonly"),
				$("#book_detail_publisher").attr("readonly", "readonly"),
				$("#book_detail_publishDate").attr("readonly", "readonly")
				$("#book_detail_isbn").attr("readonly", "readonly"),
				$("#book_detail_price").attr("readonly", "readonly"),
			
				$("#author_detail_authorID").attr("readonly", "readonly"),
				$("#author_detail_name").attr("readonly", "readonly"),
				$("#author_detail_age").attr("readonly", "readonly"),
				$("#author_detail_country").attr("readonly", "readonly")

			},
			error: function(){
				alert("detail error")
			},
			complete: function(){
				
			}
		});
	}
</script>

<script type="text/javascript">
	function onAddBookButtonClicked(){

		$("#book_add_title").val("");
		$("#book_add_isbn").val("");
		$("#book_add_authorID").val("");
		$("#book_add_publisher").val("");
		$("#book_add_publishDate").val("");
		$("#book_add_price").val("");
	}
</script>

<script type="text/javascript">
	function onAddBookSubmitButtonClicked(){
		
		if($("#book_add_title").val()=='' || 
				$("#book_add_isbn").val()==''||
				$("#book_add_authorID").val()==''||
				$("#book_add_publisher").val()==''||
				$("#book_add_publishDate").val()==''||
				$("#book_add_price").val()==""){
			alert("请输入完整信息");
			return false;
		}
		
		$.ajax({
			type: "post",
			url : "reader_book_add_submit_clicked",
			dataType: "json",
			data: {
				title : $("#book_add_title").val(),
				isbn: $("#book_add_isbn").val(),
				authorID: $("#book_add_authorID").val(),
				publisher: $("#book_add_publisher").val(),
				publishDate: $("#book_add_publishDate").val(),
				price: $("#book_add_price").val()
			},
			success: function(data){
				

				 if(data[0].exist=="no"){
					 $("#addauthor").modal('show');
				 }

				 var book = data[1];
				 $("#books_table tbody").prepend("<tr id=\"book" + book.isbn + "\">" + 
						 						 "<td>" + book.title + "</td>" + 
						 						 "<td>" + book.authorID + "</td>" + 
						 						 "<td>" + book.publisher + "</td>" + 
						 						 "<td>" + book.publishDate + "</td>" + 
						 						 "<td>" + book.isbn + "</td>" + 
						 						 "<td>" + book.price + "</td>" + 
						 						 "<td><a><button type=\"button\" class=\"btn btn-success btn-xs\" data-toggle=\"modal\" data-target=\"#detailbook\" onclick=\"onDetailBookButtonClicked(" + book.isbn + ")\"" + ">详情</button></a></td>" + 
						 						 "<td><a><button type=\"button\" class=\"btn btn-success btn-xs\" data-toggle=\"modal\" data-target=\"#modifybook\" onclick=\"onModifyBookButtonClicked(" + book.isbn + ")\"" + ">修改</button></a></td>" + 
						                       	 "<td><a><button type=\"button\" class=\"btn btn-success btn-xs\" data-toggle=\"modal\" data-target=\"#deletebook\" onclick=\"onDeleteBookButtonClicked(" + book.isbn + ")\"" + ">删除</button></a></td>" + 
						 						 "</tr>");
				 
			},
			error: function(){
			
				alert("format error");
			},
			complete: function(){
				$("#addbook").modal('hide');
			}
		});
	}
</script>








<script type="text/javascript">
	function onListAuthorButtonClicked(){
		$.ajax({
			type: "get",
			url : "reader_author_list_clicked",
			dataType: "json",
			success: function(data){
			
				var authors_tbody = $("#authors_tbody tr");
				for(var i = 0; i < authors_tbody.length; ++i){
					authors_tbody.eq(i).remove();
				}
				
				for(var i = 0; i < data.length; ++i){
					var author = data[i];
					$("#authors_table tbody").prepend("<tr id=\"author" + author.authorID + "\">" + 
													  "<td>" + author.authorID + "</td>" + 
													  "<td>" + author.name + "</td>" + 
													  "<td>" + author.age + "</td>" + 
													  "<td>" + author.country + "</td>" + 
													   "<td><a><button type=\"button\" class=\"btn btn-success btn-xs\" data-toggle=\"modal\" data-target=\"#modifyauthor\" onclick=\"onModifyAuthorButtonClicked(" + author.authorID + ")\"" + ">修改</button></a></td>" + 
								                      "<td><a><button type=\"button\" class=\"btn btn-success btn-xs\" data-toggle=\"modal\" data-target=\"#deleteauthor\" onclick=\"onDeleteAuthorButtonClicked(" + author.authorID + ")\"" + ">删除</button></a></td>" + 
								 					  "</tr>");
				}
				
				if($("#authors_div").is(":hidden"))
					$("#authors_div").show();
				if(!$("#books_div").is(":hidden"))
					$("#books_div").hide();
				
			},
			error: function(){
				if(!$("#books_div").is(":hidden"))
					$("#books_div").hide();
				alert("list error");
			}
		});
	}
</script>

<script type="text/javascript">
	function onDeleteAuthorButtonClicked(authorID){
		$.ajax({
			type: "post",
			url: "reader_author_delete_clicked",
			dataType: "json",
			data:{
				'authorID' : authorID
			},
			success: function(data){
				$("#author_delete_authorID").val(data.authorID);
				$("#author_delete_name").val(data.name);
				$("#author_delete_age").val(data.age);
				$("#author_delete_country").val(data.country);
				
				$("#author_delete_authorID").attr("readonly", "readonly");
				$("#author_delete_name").attr("readonly", "readonly");
				$("#author_delete_age").attr("readonly", "readonly");
				$("#author_delete_country").attr("readonly", "readonly");
			},
			error: function(){
				alert("delete error")
			}
		});
	}
</script>

<script type="text/javascript">
	function onDeleteAuthorSubmitButtonClicked(){
		
		var delete_authorID = $("#author_delete_authorID").val();
		$.ajax({
			type: "post",
			url: "reader_author_delete_submit_clicked",
			data : {
				authorID : delete_authorID
			},
			
			success: function(data){
				$("#author" + delete_authorID).remove();
			},
			error: function(){
				alert("delete error")
			},
			complete: function(){
				$("#deleteauthor").modal('hide');
			}
			
		});
	}
</script>


<script type="text/javascript">

function onAddAuthorButtonClicked(){
	$("#author_add_authorID").val("");
	$("#author_add_name").val("");
	$("#author_add_age").val("");
	$("#author_add_country").val("");
}
</script>

<script type="text/javascript">
	$("#addauthor").on('shown.bs.modal',function(e){
		onAddAuthorButtonClicked();
	})
</script>


  <script type="text/javascript">
	function onAddAuthorSubmitButtonClicked(){
		if($("#author_add_title").val()=='' ||
				$("#author_add_name").val()==''||
				$("#author_add_age").val()==''||
				$("#author_add_country").val()==''){
			alert("请输入完整信息");
			return false;
		}
	
		
		$.ajax({
			type: "post",
			url : "reader_author_add_submit_clicked",
			dataType: "json",
			data: {
				name : $("#author_add_name").val(),
				authorID: $("#author_add_authorID").val(),
				age: $("#author_add_age").val(),
				country: $("#author_add_country").val()
			},

			success: function(data){
				
				 var author = data;
				 $("#authors_table tbody").prepend("<tr id=\"author" + author.authorID + "\">" + 
						  "<td>" + author.authorID + "</td>" + 
						  "<td>" + author.name + "</td>" + 
						  "<td>" + author.age + "</td>" + 
						  "<td>" + author.country + "</td>" + 
						  "<td><a><button type=\"button\" class=\"btn btn-success btn-xs\" data-toggle=\"modal\" data-target=\"#modifyauthor\" onclick=\"onModifyAuthorButtonClicked(" + author.authorID + ")\"" + ">修改</button></a></td>" + 
	                      "<td><a><button type=\"button\" class=\"btn btn-success btn-xs\" data-toggle=\"modal\" data-target=\"#deleteauthor\" onclick=\"onDeleteAuthorButtonClicked(" + author.authorID + ")\"" + ">删除</button></a></td>" + 
	 					  "</tr>");
				
			},
			error: function(){
				 alert("format error");
			},
			complete: function(){
				$("#addauthor").modal('hide');
			}
		});
	}
	
	
</script>


<script type="text/javascript">
	function onModifyAuthorButtonClicked(authorID){
		
		$.ajax({
			type: "post",
			url : "reader_author_modify_clicked",
			dataType: "json",
			data: {
				'authorID': authorID
			},
			success: function(data){
				$("#author_modify_authorID").val(data.authorID);
				$("#author_modify_name").val(data.name);
				$("#author_modify_age").val(data.age);
				$("#author_modify_country").val(data.country);
				
				$("#author_modify_authorID").attr("readonly", "readonly");
			},
			error: function(){
			}
		});
	}
</script>

<script type="text/javascript">
	function onModifyAuthorSubmitButtonClicked(){
		if($("#author_modify_authorID").val()==''||
				$("#author_modify_name").val()==''||
				$("#author_modify_age").val()==''||
				$("#author_modify_country").val()==''){
			alert("请输入完整信息");
			return false;
		}
		$.ajax({
			type: "post",
			url: "reader_author_modify_submit_clicked",
			dataType: "json",
			data: {
				'authorID' : $("#author_modify_authorID").val(),
				'name': $("#author_modify_name").val(),
				'age' : $("#author_modify_age").val(),
				'country': $("#author_modify_country").val()
			},
			success: function(data){
				var author_tr = $("#author" + $("#author_modify_authorID").val()); 
				author_tr.children().eq(0).text(data.authorID);
				author_tr.children().eq(1).text(data.name);
				author_tr.children().eq(2).text(data.age);
				author_tr.children().eq(3).text(data.country);
				$("#modifyauthor").modal('hide');
			},
			error: function(){
				$("#modifyauthor").modal('hide');
				alert("format error")
			}
		});
	}
</script>

<script type="text/javascript">
	function onQueryAuthorButtonClicked(){
		$("#author_query_name").val("");
	}
</script>

<script type="text/javascript">
	function onQueryAuthorSubmitButtonClicked(){
		if($("#author_query_name").val()==''){
			alert("请输入完整信息");
			return false;
		}
	
		$.ajax({
			type: "post",
			url: "reader_author_query_clicked",
			dataType: "json",
			data :{
				name: $("#author_query_name").val()
			},
			
 			success: function(data){
				
 				var author_tbody = $("#authors_tbody tr");
 				
 				for(var i = 0; i < author_tbody.length; ++i){
 						author_tbody.eq(i).remove();
 				}
 				
 				var author = data;
				$("#authors_table tbody").prepend("<tr id=\"author" + author.authorID + "\">" + 
						  "<td>" + author.authorID + "</td>" + 
						  "<td>" + author.name + "</td>" + 
						  "<td>" + author.age + "</td>" + 
						  "<td>" + author.country + "</td>" + 
						   "<td><a><button type=\"button\" class=\"btn btn-success btn-xs\" data-toggle=\"modal\" data-target=\"#modifyauthor\" onclick=\"onModifyAuthorButtonClicked(" + author.authorID + ")\"" + ">修改</button></a></td>" + 
	                      "<td><a><button type=\"button\" class=\"btn btn-success btn-xs\" data-toggle=\"modal\" data-target=\"#deleteauthor\" onclick=\"onDeleteAuthorButtonClicked(" + author.authorID + ")\"" + ">删除</button></a></td>" + 
	 					  "</tr>");
 			},
 			error: function(){
 				alert("query error")
 			},
 			complete: function(){
				$("#queryauthor").modal('hide');
 				
				if($("#authors_div").is(":hidden"))
					$("#authors_div").show();
				if(!$("#books_div").is(":hidden"))
					$("#books_div").hide();
 			}
		});
	}
</script>

</body>
</html>
