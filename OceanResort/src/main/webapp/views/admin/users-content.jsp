<%@ page import="java.util.List" %>
<%@ page import="com.mvc.model.User" %>

<div class="content-header">
    <div class="container-fluid d-flex justify-content-between align-items-center">
        <h1 class="m-0">User Management</h1>

        <!-- ADD USER BUTTON -->
        <a href="<%=request.getContextPath()%>/users?action=new" class="btn btn-primary">
            <i class="fas fa-plus"></i> Add User
        </a>
    </div>
</div>

<section class="content">
    <div class="container-fluid">
        <div class="card">

            <div class="card-body">
                <table id="userTable" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Role</th>
                            <th>Created At</th>
                            <th width="120">Actions</th>
                        </tr>
                    </thead>

                    <tbody>
                        <%
                            List<User> userList = (List<User>) request.getAttribute("userList");
                            if (userList != null && !userList.isEmpty()) {
                                for (User user : userList) {
                        %>
                        <tr>
                            <td><%= user.getUserId() %></td>
                            <td><%= user.getName() %></td>
                            <td><%= user.getEmail() %></td>
                            <td><%= user.getPhone() %></td>
                            <td><%= user.getRole() %></td>
                            <td><%= user.getCreatedAt() %></td>

                            <!-- ACTION BUTTONS -->
                            <td>
                                <a href="<%=request.getContextPath()%>/users?action=edit&id=<%=user.getUserId()%>"
                                   class="btn btn-sm btn-warning">
                                   Edit
                                </a>

                                <a href="<%=request.getContextPath()%>/users?action=delete&id=<%=user.getUserId()%>"
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('Are you sure you want to delete this user?')">
                                   Delete
                                </a>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="7" class="text-center">No users found</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>

<!-- DATATABLE SCRIPT -->
<script>
$(document).ready(function () {
    $('#userTable').DataTable({
        "responsive": true,
        "autoWidth": false
    });
});
</script>