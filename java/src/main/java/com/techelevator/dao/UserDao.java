package com.techelevator.dao;

import com.techelevator.model.User;
import org.springframework.security.access.prepost.PreAuthorize;

import java.security.Principal;
import java.util.List;

public interface UserDao {

    User currentUser(Principal principal);

    List<User> findAll();

    User getUserById(Long userId);

    User findByUsername(String username);

    int findIdByUsername(String username);

    boolean create(String username, String password, String role);
}
