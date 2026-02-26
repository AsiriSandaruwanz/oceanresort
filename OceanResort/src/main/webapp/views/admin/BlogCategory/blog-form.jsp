<%@ page import="java.util.List" %>
<%@ page import="com.mvc.model.Blog" %>
<%@ page import="com.mvc.model.BlogCategory" %>

<%
    Blog blog = (Blog) request.getAttribute("blog");
    List<BlogCategory> categories = (List<BlogCategory>) request.getAttribute("categories");
    boolean isEdit = (blog != null);
%>

<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0"><%= isEdit ? "Edit Blog" : "Add Blog" %></h1>
            </div>
            <div class="col-sm-6 text-right">
                <a href="<%=request.getContextPath()%>/blogs" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Blogs
                </a>
            </div>
        </div>
    </div>
</div>

<section class="content">
    <div class="container-fluid">
        <div class="card card-primary">
            <div class="card-header"><h3 class="card-title"><%= isEdit ? "Edit Blog" : "Add Blog" %></h3></div>
            
            <form action="<%=request.getContextPath()%>/blogs" method="post" enctype="multipart/form-data">
                <div class="card-body">

                    <% if (isEdit) { %>
                        <input type="hidden" name="id" value="<%= blog.getId() %>"/>
                        <input type="hidden" name="action" value="update"/>
                    <% } else { %>
                        <input type="hidden" name="action" value="insert"/>
                    <% } %>

                    <!-- Blog Title -->
                    <div class="form-group">
                        <label for="title">Blog Title</label>
                        <input type="text" class="form-control" id="title" name="title" placeholder="Enter title"
                               value="<%= isEdit ? blog.getTitle() : "" %>" required>
                    </div>

                    <!-- Blog Category -->
                    <div class="form-group">
                        <label for="blog_category_id">Category</label>
                        <select class="form-control" id="blog_category_id" name="blog_category_id" required>
                            <option value="">-- Select Category --</option>
                            <% for (BlogCategory c : categories) { %>
                                <option value="<%= c.getId() %>"
                                    <%= (isEdit && blog.getBlogCategoryId() == c.getId()) ? "selected" : "" %>>
                                    <%= c.getName() %>
                                </option>
                            <% } %>
                        </select>
                    </div>

                    <!-- Blog Date -->
                    <div class="form-group">
                        <label for="blog_date">Blog Date</label>
                        <input type="date" class="form-control" id="blog_date" name="blog_date"
                               value="<%= isEdit ? blog.getBlogDate() : "" %>" required>
                    </div>

                    <!-- Blog Image -->
                    <div class="form-group">
                        <label for="image_path">Image</label>
                        <input type="file" class="form-control-file" id="image_path" name="image_path" <%= isEdit ? "" : "required" %>>
                        <% if (isEdit && blog.getImagePath() != null && !blog.getImagePath().isEmpty()) { %>
                            <div class="mt-2">
                                <img src="<%=request.getContextPath() + "/" + blog.getImagePath() %>" width="150"/>
                            </div>
                        <% } %>
                    </div>

                    <!-- Blog Content -->
                    <div class="form-group">
                        <label for="content">Content</label>
                        <textarea class="form-control" id="content" name="content" rows="6" required><%= isEdit ? blog.getContent() : "" %></textarea>
                    </div>

                </div>

                <div class="card-footer">
                    <button type="submit" class="btn btn-primary"><%= isEdit ? "Update Blog" : "Add Blog" %></button>
                    <a href="<%=request.getContextPath()%>/blogs" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</section>