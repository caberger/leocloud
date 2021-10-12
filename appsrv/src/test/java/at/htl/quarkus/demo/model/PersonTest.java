package at.htl.quarkus.demo.model;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import static org.junit.Assert.assertEquals;

public class PersonTest {
    Person person;
    String fullName;

    @Given("a person")
    public void a_person() {
        this.person = new Person();
    }
    @Given("first name is {string}")
    public void first_name_is(String firstName) {
        person.setFirstName(firstName);
    }
    @Given("last name is {string}")
    public void last_name_is(String lastName) {
        person.setLastName(lastName);
    }
    @When("I ask for the full name")
    public void i_ask_for_the_full_name() {
        fullName = person.fullName();
    }
    @Then("I should be told {string}")
    public void i_should_be_told(String string) {
        assertEquals(string, this.fullName);
    }
}