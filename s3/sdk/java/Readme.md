# Create new maven project

'''
mvn archetype:generate \
-DgroupId=com.mycompany.app \
-DartifactId=my-app \
-DarchetypeArtifactId=maven-archetype-quickstart \
-DarchetypeVersion=1.5 \
-DinteractiveMode=false
''''

'''
mvn -B archetype:generate \
 -DarchetypeGroupId=software.amazon.awssdk \
 -DarchetypeArtifactId=archetype-lambda \
 -Dservice=s3 -Dregion=EU_WEST_1 \
 -DarchetypeVersion=2.31.66 \
 -DgroupId=com.example.myapp \
 -DartifactId=myapp
 '''