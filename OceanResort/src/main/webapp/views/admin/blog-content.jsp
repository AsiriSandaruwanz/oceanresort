<%@ page import="java.util.List" %>
<%@ page import="com.mvc.model.Blog" %>



  <!-- Content Header -->
  <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6"><h1>All Blogs</h1></div>
        <div class="col-sm-6 text-right">
          <a href="${pageContext.request.contextPath}/blogs?action=new" class="btn btn-primary">
            <i class="fas fa-plus"></i> Add Blog
          </a>
        </div>
      </div>
    </div>
  </section>

  <!-- Main content -->
  <section class="content">
    <div class="container-fluid">

      <div class="card">
        <div class="card-header">
          <h3 class="card-title">Blog List</h3>
        </div>

        <div class="card-body">
          <table id="blogsTable" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Category</th>
                <th>Date</th>
                <th>Image</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <%
                List<Blog> blogs = (List<Blog>) request.getAttribute("blogList");
                if (blogs != null) {
                    for (Blog b : blogs) {
              %>
              <tr>
                <td><%= b.getId() %></td>
                <td><%= b.getTitle() %></td>
                <td><%= b.getCategoryName() %></td>
                <td><%= b.getBlogDate() %></td>
                <td>
                  <img src="<%=request.getContextPath()%>/<%= b.getImagePath() %>" width="80" />
                </td>
                <td>
                  <a href="${pageContext.request.contextPath}/blogs?action=edit&id=<%= b.getId() %>" class="btn btn-sm btn-info">
                    <i class="fas fa-edit"></i>
                  </a>
                  <a href="${pageContext.request.contextPath}/blogs?action=delete&id=<%= b.getId() %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this blog?');">
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
  $(function () {
    $("#blogsTable").DataTable({
      "responsive": true,
      "autoWidth": false,
      "searching": true,   // enables search box
      "lengthChange": true, // allows changing number of rows per page
      "pageLength": 10
    });
  });
</script>