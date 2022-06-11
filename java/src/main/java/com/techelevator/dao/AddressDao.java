package com.techelevator.dao;

import com.techelevator.model.Address;

import java.util.List;

public interface AddressDao {

    Address getAddressById(int addressId);

    List<Address> getAllAddresses();

    boolean updateAddress(Address address);

}
