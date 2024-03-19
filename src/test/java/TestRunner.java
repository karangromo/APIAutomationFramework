import com.intuit.karate.Runner;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class TestRunner {

@Test
public void runFeature(){
        Runner.path("src/test/java/features/CreateCustomer.feature").parallel(1);
    }

   @Test
   public void runAllFeatures(){
        Runner.path(featuresLists).parallel(2);
    }
    List<String> featuresLists = Arrays.asList("src/test/java/features/CreateCustomer.feature",
            "src/test/java/features/CreateLead.feature");
}
