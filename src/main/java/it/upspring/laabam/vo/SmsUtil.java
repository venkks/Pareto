package it.upspring.laabam.utils;

/*import com.telerivet.*;

import java.io.BufferedReader;
import java.io.IOException ;
import java.io.InputStreamReader;
import java.util.List;

/**
 * Created by sri on 20/11/15.
 */
/*public class SmsUtil {

    public  void sendSms(String mobileNo, String content) {

        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        try {
            //String apiKey = "2oFLPifigQIteI2PUZsdAOibN0igoIBq";
//            String apiKey = "G9V6lxNVBqR93PNx2CEdZ48qyYxXul1A";
            String apiKey = "i2x8Ekma60eUKDfdVsH3kjWdZez0TrdC";
            TelerivetAPI tr = new TelerivetAPI(apiKey);

            APICursor<Project> cursor = tr.queryProjects();

            List<Project> projects = cursor.all();

            Project project;

            int numProjects = projects.size();

            if (numProjects > 1) {
                for (int i = 0; i < numProjects; i++) {
                    System.out.println((i + 1) + ": " + projects.get(i).getName());
                }

                System.out.print("Choose a project (1-" + numProjects + "): ");
                String projectIndexStr = br.readLine();
                int projectIndex = Integer.parseInt(projectIndexStr) - 1;
                if (projectIndex < 0 || projectIndex >= numProjects) {
                    System.out.println("Invalid project index");
                    return;
                }

                project = projects.get(projectIndex);
            } else if (numProjects == 1) {
                project = projects.get(0);
            } else {
                System.out.println("You do not have any projects.");
                return;
            }

            String toNumber = mobileNo;

            //String content = "Hi " + name + ", Welcome message from Laabam.";

            Message message = project.sendMessage(Util.options(
                    "to_number", toNumber,
                    "content", content
            ));

            System.out.println("Message is " + message.getStatus() + ", message id=" + message.getId());
        } catch (IOException ex) {
            throw new RuntimeException(ex);
        }
    }

}*/


