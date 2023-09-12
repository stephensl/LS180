# One-to-Many Relationships

If we had a table that kept track of calls made by an individual...![calls](https://da77jsbdz4r05.cloudfront.net/images/one_to_many/step1.png)

AND we add more phone calls, some by the same person...![more calls](https://da77jsbdz4r05.cloudfront.net/images/one_to_many/step2.png)


We would end up with duplicate data in the table. Thus, if the phone number changed, we would need to update each and every record. This can lead to problems with data consistency as the table grows. This is an **update anomaly**. 

Update Anomalies
  - when an update to one record in a database causes need to update multiple other records. May lead to inconsistent data.

Insertion Anomalies
  - when unable to insert particular attributes pertaining to a record without also inserting other attributes that may or may not be relevant or available at time of insertion. 

Deletion Anomalies
  - when deleting a particular record removes more data than desired. 

**These anomalies are indicative of a lack of normalization.**

Normalization is the process of designing schema to avoid these anomalies by separating data between multiple tables and using foreign keys to connect associated data. 


#

