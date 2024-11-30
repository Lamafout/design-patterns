CREATE TABLE students (
    id SERIAL PRIMARY KEY,           
    surname VARCHAR(100) NOT NULL,   
    name VARCHAR(100) NOT NULL,      
    second_name VARCHAR(100) NOT NULL,        
    birthdate DATE NOT NULL,                  
    phone VARCHAR(15),               
    telegram VARCHAR(50),            
    email VARCHAR(255),              
    git VARCHAR(255)                 
);
