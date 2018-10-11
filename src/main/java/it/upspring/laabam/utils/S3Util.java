package it.upspring.laabam.utils;

import java.io.File;
import java.io.IOException;

import com.amazonaws.AmazonClientException;
import com.amazonaws.AmazonServiceException;
import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;

import com.amazonaws.services.s3.model.ObjectMetadata;
import com.sun.xml.internal.ws.policy.privateutil.PolicyUtils;
import org.springframework.web.multipart.MultipartFile;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

import com.amazonaws.services.s3.model.GetObjectRequest;
import com.amazonaws.services.s3.model.S3Object;



public class S3Util {

    String bucketName     = "sourabh-test-bucket";

    public void UploadObjectSingleOperation (MultipartFile uploadFile) {

            AmazonS3 s3client = new AmazonS3Client(new ProfileCredentialsProvider());
            try {
                System.out.println("Uploading a new object to S3 from a file\n");

                ObjectMetadata objectMetadata = new ObjectMetadata();
                String keyName = uploadFile.getOriginalFilename();
                s3client.putObject(bucketName,keyName,uploadFile.getInputStream(),objectMetadata);

            }
            catch (IOException ioe){
                ioe.printStackTrace();
            }
            catch (AmazonServiceException ase) {
                System.out.println("Caught an AmazonServiceException, which " +
                        "means your request made it " +
                        "to Amazon S3, but was rejected with an error response" +
                        " for some reason.");
                System.out.println("Error Message:    " + ase.getMessage());
                System.out.println("HTTP Status Code: " + ase.getStatusCode());
                System.out.println("AWS Error Code:   " + ase.getErrorCode());
                System.out.println("Error Type:       " + ase.getErrorType());
                System.out.println("Request ID:       " + ase.getRequestId());
            } catch (AmazonClientException ace) {
                System.out.println("Caught an AmazonClientException, which " +
                        "means the client encountered " +
                        "an internal error while trying to " +
                        "communicate with S3, " +
                        "such as not being able to access the network.");
                System.out.println("Error Message: " + ace.getMessage());
            }
    }

    public void GetObject(String key){
            AmazonS3 s3Client = new AmazonS3Client(new ProfileCredentialsProvider());
            try {
                System.out.println("Downloading an object");
                S3Object s3object = s3Client.getObject(new GetObjectRequest(
                        bucketName, key));
                System.out.println("Content-Type: "  +
                        s3object.getObjectMetadata().getContentType());
                displayTextInputStream(s3object.getObjectContent());

                // Get a range of bytes from an object.

                GetObjectRequest rangeObjectRequest = new GetObjectRequest(
                        bucketName, key);
                rangeObjectRequest.setRange(0, 10);
                S3Object objectPortion = s3Client.getObject(rangeObjectRequest);

                System.out.println("Printing bytes retrieved.");
                displayTextInputStream(objectPortion.getObjectContent());

            }
            catch (IOException ioe){
                ioe.printStackTrace();
            }
            catch (AmazonServiceException ase) {
                System.out.println("Caught an AmazonServiceException, which" +
                        " means your request made it " +
                        "to Amazon S3, but was rejected with an error response" +
                        " for some reason.");
                System.out.println("Error Message:    " + ase.getMessage());
                System.out.println("HTTP Status Code: " + ase.getStatusCode());
                System.out.println("AWS Error Code:   " + ase.getErrorCode());
                System.out.println("Error Type:       " + ase.getErrorType());
                System.out.println("Request ID:       " + ase.getRequestId());
            } catch (AmazonClientException ace) {
                System.out.println("Caught an AmazonClientException, which means"+
                        " the client encountered " +
                        "an internal error while trying to " +
                        "communicate with S3, " +
                        "such as not being able to access the network.");
                System.out.println("Error Message: " + ace.getMessage());
            }
    }


        private static void displayTextInputStream(InputStream input)
        throws IOException {
            // Read one text line at a time and display.
            BufferedReader reader = new BufferedReader(new
                    InputStreamReader(input));
            while (true) {
                String line = reader.readLine();
                if (line == null) break;

                System.out.println("    " + line);
            }
            System.out.println();
        }
    }









