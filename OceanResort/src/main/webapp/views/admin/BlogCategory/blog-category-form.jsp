<%@ page import="com.mvc.model.BlogCategory" %>

<%
    BlogCategory category =
        (BlogCategory) request.getAttribute("category");

    boolean isEdit = (category != null);
%>

<!-- Content Header -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2">
      <div class="col-sm-6">
        <h1 class="m-0">
          <%= isEdit ? "Edit Blog Category" : "Add Blog Category" %>
        </h1>
      </div>
      <div class="col-sm-6">
        <ol class="breadcrumb float-sm-right">
          <li class="breadcrumb-item">
            <a href="<%=request.getContextPath()%>/dashboard">Home</a>
          </li>
          <li class="breadcrumb-item">
            <a href="<%=request.getContextPath()%>/blog-categories">
              Blog Categories
            </a>
          </li>
          <li class="breadcrumb-item active">
            <%= isEdit ? "Edit" : "Add" %>
          </li>
        </ol>
      </div>
    </div>
  </div>
</div>

<!-- Main Content -->
<section class="content">
  <div class="container-fluid">

    <div class="card card-primary">
      <div class="card-header">
        <h3 class="card-title">
          <%= isEdit ? "Update Category Details" : "Enter Category Details" %>
        </h3>
      </div>

      <!-- Form Start -->
      <form action="${pageContext.request.contextPath}/blog-categories" method="post">

        <div class="card-body">

          <!-- Hidden Action -->
          <input type="hidden" name="action"
                 value="<%= isEdit ? "update" : "insert" %>">

          <% if (isEdit) { %>
              <input type="hidden" name="id"
                     value="<%= category.getId() %>">
          <% } %>

          <!-- Category Name -->
          <div class="form-group">
            <label>Category Name</label>
            <input type="text"
                   name="name"
                   class="form-control"
                   placeholder="Enter category name"
                   value="<%= isEdit ? category.getName() : "" %>"
                   required>
          </div>

          <!-- Description -->
          <div class="form-group">
            <label>Description</label>
            <textarea name="description"
                      class="form-control"
                      rows="4"
                      placeholder="Enter description"><%= isEdit ? category.getDescription() : "" %></textarea>
          </div>

        </div>

        <!-- Card Footer -->
        <div class="card-footer">

          <button type="submit" class="btn btn-success">
            <i class="fas fa-save"></i>
            <%= isEdit ? "Update Category" : "Save Category" %>
          </button>

          <a href="${pageContext.request.contextPath}/blog-categories"
             class="btn btn-secondary">
            Cancel
          </a>

        </div>

      </form>
      <!-- Form End -->

    </div>

  </div>
</section>