#!/bin/bash

# Set the variables
aiv_port=8080
aiv_db_url="jdbc:postgresql://localhost:5432/aiv"
aiv_db_user="postgres"
aiv_db_password="root"
security_db_url="jdbc:postgresql://localhost:5432/aiv?currentSchema=security"
security_db_user="postgres"
security_db_password="root"
aiv_logs="$(pwd)\logs"
aiv_base="$(pwd)"

# Set file paths
original_file="$aiv_base/config/application.template"
aiv_logback_file="$aiv_base/config/logback.template"

new_file="$aiv_base/config/application.yml"
aiv_logback_new_file="$aiv_base/config/logback.xml"

# Convert backslashes to forward slashes in aiv_base (for Unix-style paths)
aiv_base="${aiv_base//\\//}"

# Create a temporary file for processing
temp_file="$aiv_base/config/temp.yml"

# Replace placeholders in the application template and write to new_file
cp $original_file $new_file
sed -e "s|\${aiv_port}|$aiv_port|" -i $new_file
sed -e "s|\${aiv_db_url}|$aiv_db_url|" -i $new_file
sed -e "s|\${aiv_db_user}|$aiv_db_user|" -i $new_file
sed -e "s|\${aiv_db_password|$aiv_db_password|" -i $new_file
sed -e "s|\${security_db_url}|$security_db_url|" -i $new_file
sed -e "s|\${security_db_user}|$security_db_user|" -i $new_file
sed -e "s|\${security_db_password}|$security_db_passwor|" -i $new_file
sed -e "s|\${aiv_base}|$aiv_base|" -i $new_file

# Replace placeholders in aiv_logback_file and write to aiv_logback_new_file
#cp $aiv_logback_file $aiv_logback_new_file
#sed -e "s|\${aiv_base}|$aiv_base|" -i $aiv_logback_new_file

# Convert backslashes to forward slashes in aiv_base (for Unix-style paths)
aiv_logs="${aiv_logs//\\//}"

# Create a temporary file for processing
temp_file1="$aiv_base/config/temp1.xml"

# Replace placeholders in the application template and write to new_file
cp $aiv_logback_file $aiv_logback_new_file
sed -e "s|\${aiv_logs}|$aiv_logs|" -i $aiv_logback_new_file

echo "Variables replaced and written to $new_file and $aiv_logback_new_file"
