package com.techelevator.dao;

import com.techelevator.model.Address;
import com.techelevator.model.Beverage;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class AddressDaoJdbc implements AddressDao{

    private JdbcTemplate jdbcTemplate;

    public AddressDaoJdbc(JdbcTemplate jdbcTemplate){
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public Address getAddressById(int addressId) {
        Address address = null;
        String sql = "SELECT * FROM address_info " +
                "WHERE address_id = ?";

        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, addressId);
        if(results.next()){
            address = mapRowToAddress(results);
        }
        return address;
    }

    @Override
    public List<Address> getAllAddresses() {
        List<Address> addressList= new ArrayList<>();

        String sql = "SELECT * " +
                "FROM address_info";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql);
        while (results.next()){
            Address address = mapRowToAddress(results);
            addressList.add(address);
        }
        return addressList;
    }

    @Override
    public boolean updateAddress(Address address) {
        String sql = "UPDATE address_info SET address = ?, phone_number = ?, latitude = ?, longitude = ? " +
                "WHERE address_id = ?";
        return jdbcTemplate.update(sql, address.getAddress(), address.getPhoneNumber(), address.getLatitude(), address.getLongitude(),
                address.getAddressId()) == 0;
    }

    public Address mapRowToAddress(SqlRowSet rowSet){
        Address address = new Address();
        address.setAddress(rowSet.getString("address"));
        address.setAddressId(rowSet.getInt("address_id"));
        address.setLatitude(rowSet.getDouble("latitude"));
        address.setLongitude(rowSet.getDouble("longitude"));
        address.setPhoneNumber(rowSet.getString("phone_number"));
        return address;
    }
}
