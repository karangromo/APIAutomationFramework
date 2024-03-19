package utils;

import com.github.javafaker.Faker;
public class commonUtils {
    static Faker faker = new Faker();
    public static String getRandomInteger(int size){
        return faker.number().digits(size);
    }
    public static String getRandomString(){
        return faker.name().fullName();
    }

    public void threadSleep(int size){
         threadSleep(size);
    }
}
