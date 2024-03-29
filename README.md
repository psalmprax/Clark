# Coding Challenge - Data Engineer
## Coding Challenge - Data Engineer
## Goal
-	Give Business users insight into the behavior of our customers
-	Create reports from an Event Stream
-	Process a Stream of domain events in your favorite programming language
## Tasks
#### Implement a data pipeline, that consumes the given Events (events.json) and generates Entities suitable for providing reports
-	The architecture data pipeline should be scalable enough to handle a hypothetical throughput of >= 50000 events per second when running on production hardware.

-	Your project should outline the steps and changes required to deploy the data pipeline on the cloud. If you would like to make your examples more concrete, we use AWS, although you are free to keep the project cloud-agnostic.

-	Good software engineering practices, like version control and sufficient test coverage, are expected.

####	Document any known bugs and potential improvements your data pipeline would require under realistic assumptions.
####	Create reports that answer the following questions:
-	How long do orders need to be fulfilled?
-	How many orders are open at specific times?
-	How high is the probability of a cancelled order depending on the age?


Some sample scripts to provide infrastructure for an ETL and Analytics deployment solution. Below is a set up of a local 
instance of apache airflow 2.0 by building a custom docker image with the provided docker file and 
using this inside the docker compose setup specified by the given docker-compose file.


So it would be good, if you ensure that the following commands were executed on your local system and make sure you
have `docker` and `docker-compose` install your system
`docker build -t local-airflow:2.0.0 .`

followed by 

`docker-compose up`

after that, check if you can login to a local airflow instance by opening this url in your browser.

Airflow UI: http://localhost:8080/login/

pgadmin UI: http://localhost:5050/

The username is `admin` and the password is `admin`

setting up the database connection

Once you are logged in, go to the `Admin` menu, then click the `Connections` dropdown 

Then click the `+` button next to `Actions` to create a connection string details

Use below information to fill the connection details

### Connection Details on Aiflow UI 
- `Conn Id`: `connections`
- `Conn Type`: `Postgres`
- `Host`: `postgres`
- `Schema`: `airflow`
- `Login`: `airflow`
- `Password`: `airflow`
- `Port`: `5432`


### Connection Details on pgadmin
- `Email/Username`: `samuelolle@yahoo.com`
- `password`: `leicester`


### Connection Details on Postgres
- `Host`: `postgres`
- `Schema`: `airflow`
- `Login`: `airflow`
- `Password`: `airflow`
- `Port`: `5432`

Execute the dag with a dag id `Ingest`
