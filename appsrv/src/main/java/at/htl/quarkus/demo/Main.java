package at.htl.quarkus.demo;


import io.quarkus.runtime.annotations.QuarkusMain;
import io.quarkus.runtime.Quarkus;

@QuarkusMain
public class Main {
    public static void main(String ... args) {
        Quarkus.run(args);
    }
}