package com.techelevator.dao;

import com.techelevator.model.Username;

import java.util.List;

public interface UsernameDao {

    Username getUsernameById(int userId);

    Username getUsernameByUsername(String name);

    List<Username> getAllUsernames();
}
