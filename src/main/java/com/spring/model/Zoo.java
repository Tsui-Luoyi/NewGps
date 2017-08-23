package com.spring.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class Zoo {
    
    @Autowired
    private Tiger tiger;
    
    @Autowired
    private Monkey monkey;
    
    public String toString(){
        return tiger + "\n" + monkey;
    }
    
    public static void main(String[] args){
    	Zoo z=new Zoo();
    	System.out.println(z.toString());
    }
}