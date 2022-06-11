package com.techelevator.dao;

import com.techelevator.model.User;
import com.techelevator.model.Username;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class UsernameDaoJdbc implements UsernameDao{

    private JdbcTemplate jdbcTemplate;

    public UsernameDaoJdbc(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public Username getUsernameById(int userId) {
        Username username = null;
        String sql = "SELECT username, user_id FROM users WHERE user_id = ?";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, userId);
        if(results.next()){
            username = mapRowToUsername(results);
        }
        return username;
    }

    @Override
    public Username getUsernameByUsername(String name) {
        Username returnedUsername = null;
        String sql = "SELECT username, user_id FROM users WHERE username = ?";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, name);
        if(results.next()){
            returnedUsername = mapRowToUsername(results);
        }
        return returnedUsername;
    }
    @Override
    public List<Username> getAllUsernames() {
        List<Username> usernameList = new ArrayList<>();
        String sql = "SELECT username, user_id FROM users";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql);
        while(results.next()){
            Username username = mapRowToUsername(results);
            usernameList.add(username);
        }
        return usernameList;
    }

    public Username mapRowToUsername(SqlRowSet rowSet){
        Username username = new Username();
        username.setUsername(rowSet.getString("username"));
        username.setUserId(rowSet.getInt("user_id"));
        return username;
    }
}
