 terraform {
   backend "s3" {
     bucket = "terrabuckpranithreddy"  
     key="staterules" 
     region = "ap-south-1"
   }
 }
