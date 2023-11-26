# MTD-DS: An SLA-aware Decision Support Benchmark for Multi-tenant Parallel DBMSs
Authors: Shaoyi Yin *, Franck Morvan *, Jorge Martinez-Gil **, Abdelkader Hameurlain *
* Paul Sabatier University, Toulouse, France
** Software Competence Center Hagenberg GmbH, Hagenberg, Austria
  
## Inroduction
The MTD-DS benchmark is an SLA-aware Decision Support benchmark for multi-tenant parallel DBMSs. It extends TPC-DS by adding: (1) a multi-tenant query workload generator, (2) a performance SLO (Service Level Objective, an important component in an SLA) generator which defines a performance SLO for each query in the workload, (3) configurable DBaaS pricing models, and (4) new metrics to measure the potential capability of the multi-tenant parallel DBMS in obtaining the best trade-off between the provider’s benefit and the tenants’ satisfaction.

## Who may use it ?
We expect to make our proposal as an evaluation tool for the following use cases: (1) a current DBaaS provider would like to evaluate its system and test new ideas (e.g., new query optimization methods) in order to increase its economic benefit without hurting the tenants’ interests, and (2) a future DBaaS provider would like to choose a DBMS product and a corresponding deployment strategy. Our target users also include non-profitable DBaaS providers whose objective is to self-finance the offered services. Governments who hold the data of all public hospitals and federations of multiple financially autonomous organizations are potential examples. In case of a private Cloud deployment (e.g., inside a single organization), the tenants often use the services for free, but pricing models remain interesting: the provider can generate virtual bills such that the tenants will be aware of what they have consumed and thus pay attention to their future utilization.

## What is included in the GitHub projet ?
In this GitHub projet, we share the source code (written in JAVA) and the necessary files to run the MTD-DS benchmark.
In order to generate bills and compute various scores related to the benchmark metrics, we use a SQLite database to register the intermediate results. Therefore, the following libraries should be downloaded and included in the JAVA project.
(1) SQLite JDBC driver (https://github.com/xerial/sqlite-jdbc#download). In our experiments, we used the version 3.43.2.1 ( sqlite-jdbc-3.43.2.1.jar).
(2) SLF4J-API (https://www.slf4j.org/api/). In our experiments, we used the version 1.7.36 (slf4j-api-1.7.36.jar).
(3) SLF4J-simple (https://mvnrepository.com/artifact/org.slf4j/slf4j-simple). In our experiments, we used the version 1.7.36 (slf4j-simple-1.7.36.jar).

The source code structure is shown below.
--src
----core
--------Metrics.java: to compute the final scores of the benchmark metrics 
--------PerfSLOGenerator.java: to generate the performance SLOs
--------PricingModelCommon.java: common functions used by all pricing models
--------PricingModelQLSA.java: an instantiation of the QLSA pricing model
--------PricingModelRCB.java: an instantiation of the RCB pricing model
--------TenantQueriesGenerator.java: to generate queries for each tenant
--------TenantsGenerator.java: to generate the metedata of multiple tenants
----tools
--------DBInitialization.java: to initialize the internal SQLite database
--------ExecutionTraceTransformer.java: to transform the execution traces into another format
--------InputFilesLoader.java: to load the input paramters' values into the internal database
--------PerfSLOsPertenant.java: to deduce the performance SLOs for each tenant according to their priority and database size
--------TenantsLoader.java: to load the tenants' information into the internal database
----example (code used to prepare an example benchmarking run, but code to execute on the SUTS are in the "files" folder)
--------AddExplain.java: to add EXPLAIN ANALYZE before each query in order to print the query execution plans
--------DataForFigures.java: to extract relevant data for visualization
--------ExecTimeExtractor.java: to extract the execution times from the execution plan files
--------MTTestsScriptWriter.java: to automatically generate scripts for the multi-tenant workload tests
--------splitQueries.java: to split a file containg many SQL queries into separate files with one query in each
----reproducibility
--------Reproduce.java: to replay the example benchmarking run

The "files" folder contains various files used and produced by the benchmarking process. There is a README file inside the folder with more explications. The comments in "Reproduce.java" can also help to understand the meaning and usage of each file.

## Main steps for a benchmarking run:
Step 1: Data and queries generation
Step 2: Databases load
Step 3: Power tests
Step 4: Performance SLO generation
Step 5: Multi-tenant query workload generation
Step 6: Multi-tenant query workload tests
(Step 7: PO_Metric 1 and PO_Metric 2 measurement
AND/OR
Step 8: PO_Metric 1 Bis and PO_Metric 2 Bis measurement)
Step 9: Final scores computation

## About the reproducibility
The duration of the complete run is controled to be reasonable (less than 24 hours). However, the difficulty to reproduce all our (intermediate and final) experimental results is not the benchmarking run itself, but the deployment and configuration of the SUTs. It is very time consuming, and what's more, since the hardware used will be anyway different, the gathered numbers will also be different. However, these numbers are only the input of the core MTD-DS benchmark proposal. Therefore, we provide them directly in dedicated sub-folders in the "files" folder, so that the steps of the core benchmark proposal can be replayed. All these "directly provided" intemediate materials are in plain text format, so they can be easily visualized and checked, if necessary. 
