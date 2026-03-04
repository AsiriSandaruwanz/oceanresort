package com.mvc.test;

import com.mvc.dao.UserDAO;
import com.mvc.model.User;

import org.junit.jupiter.api.*;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class UserTest {

    private static UserDAO userDAO;
    private static User testUser;
    private static int testUserId;

    @BeforeAll
    static void setup() {
        userDAO = new UserDAO();

        testUser = new User();
        testUser.setName("JUnit Test User");
        testUser.setEmail("junit@test.com");
        testUser.setPhone("0771234567");
        testUser.setPassword("1234");
        testUser.setRole("customer");
    }

    // ---------------- TEST MODEL ----------------
    @Test
    @Order(1)
    void testUserModel() {
        User user = new User();
        user.setUserId(1);
        user.setName("Test");
        user.setEmail("test@email.com");
        user.setPhone("0710000000");
        user.setPassword("pass");
        user.setRole("admin");

        assertEquals(1, user.getUserId());
        assertEquals("Test", user.getName());
        assertEquals("test@email.com", user.getEmail());
        assertEquals("0710000000", user.getPhone());
        assertEquals("pass", user.getPassword());
        assertEquals("admin", user.getRole());
    }

    // ---------------- REGISTER ----------------
    @Test
    @Order(2)
    void testRegisterUser() {
        boolean inserted = userDAO.registerUser(testUser);
        assertTrue(inserted);
    }

    // ---------------- LOGIN ----------------
    @Test
    @Order(3)
    void testLogin() {
        User loggedUser = userDAO.login("junit@test.com", "1234");
        assertNotNull(loggedUser);
        assertEquals("JUnit Test User", loggedUser.getName());

        testUserId = loggedUser.getUserId(); // Save ID for next tests
    }

    // ---------------- GET BY ID ----------------
    @Test
    @Order(4)
    void testGetUserById() {
        User user = userDAO.getUserById(testUserId);
        assertNotNull(user);
        assertEquals("junit@test.com", user.getEmail());
    }

    // ---------------- GET ALL USERS ----------------
    @Test
    @Order(5)
    void testGetAllUsers() {
        List<User> users = userDAO.getAllUsers();
        assertNotNull(users);
        assertTrue(users.size() > 0);
    }

    // ---------------- UPDATE USER ----------------
    @Test
    @Order(6)
    void testUpdateUser() {
        User user = userDAO.getUserById(testUserId);
        user.setName("Updated Name");

        boolean updated = userDAO.updateUser(user);
        assertTrue(updated);

        User updatedUser = userDAO.getUserById(testUserId);
        assertEquals("Updated Name", updatedUser.getName());
    }

    // ---------------- UPDATE PROFILE ----------------
    @Test
    @Order(7)
    void testUpdateUserProfile() {
        User user = userDAO.getUserById(testUserId);
        user.setName("Profile Updated");
        user.setPhone("0779999999");

        boolean updated = userDAO.updateUserProfile(user);
        assertTrue(updated);

        User updatedUser = userDAO.getUserById(testUserId);
        assertEquals("Profile Updated", updatedUser.getName());
        assertEquals("0779999999", updatedUser.getPhone());
    }

    // ---------------- DELETE USER ----------------
    @Test
    @Order(8)
    void testDeleteUser() {
        boolean deleted = userDAO.deleteUser(testUserId);
        assertTrue(deleted);

        User user = userDAO.getUserById(testUserId);
        assertNull(user);
    }
}