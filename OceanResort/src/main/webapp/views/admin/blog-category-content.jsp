<%@ page import="java.util.List" %>
<%@ page import="com.mvc.model.BlogCategory" %>

<!-- Content Header -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2">
      <div class="col-sm-6">
        <h1 class="m-0">Blog Categories</h1>
      </div>
      <div class="col-sm-6">
        <ol class="breadcrumb float-sm-right">
          <li class="breadcrumb-item">
            <a href="<%=request.getContextPath()%>/dashboard">Home</a>
          </li>
          <li class="breadcrumb-item active">Blog Categories</li>
        </ol>
      </div>
    </div>
  </div>
</div>

<!-- Main Content -->
<section class="content">
  <div class="container-fluid">

    <div class="card">
      <div class="card-header">
        <h3 class="card-title">All Blog Categories</h3>
        <div class="card-tools">
          <a href="${pageContext.request.contextPath}/blog-categories?action=new"
             class="btn btn-primary btn-sm">
             <i class="fas fa-plus"></i> Add Category
          </a>
        </div>
      </div>

      <div class="card-body">

        <table id="categoryTable" class="table table-bordered table-striped">
          <thead>
            <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Description</th>
              <th>Created At</th>
              <th width="120">Actions</th>
            </tr>
          </thead>
          <tbody>
            <%
              List<BlogCategory> list =
                (List<BlogCategory>) request.getAttribute("categoryList");

              if (list != null) {
                for (BlogCategory c : list) {
            %>
            <tr>
              <td><%= c.getId() %></td>
              <td><%= c.getName() %></td>
              <td><%= c.getDescription() %></td>
              <td><%= c.getCreatedAt() %></td>
              <td>
                <a href="${pageContext.request.contextPath}/blog-categories?action=edit&id=<%= c.getId() %>"
                   class="btn btn-sm btn-info">
                   <i class="fas fa-edit"></i>
                </a>
                <a href="${pageContext.request.contextPath}/blog-categories?action=delete&id=<%= c.getId() %>"
                   class="btn btn-sm btn-danger"
                   onclick="return confirm('Are you sure you want to delete this category?');">
                   <i class="fas fa-trash"></i>
                </a>
              </td>
            </tr>
            <%
                }
              }
            %>
          </tbody>
        </table>

      </div>
    </div>

  </div>
</section>

<!-- DataTables Script -->
<script>
$(document).ready(function () {
  $('#categoryTable').DataTable({
      "paging": true,
      "lengthChange": true,
      "searching": true,
      "ordering": true,
      "info": true,
      "autoWidth": false,
      "responsive": true
  });
});
</script>