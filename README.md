# MTD-DS: an SLA-aware Decision Support Benchmark for Multi-tenant Parallel DBMSs
Authors: Shaoyi Yin <sup>1</sup>, Franck Morvan <sup>1</sup>, Jorge Martinez-Gil <sup>2</sup>, Abdelkader Hameurlain <sup>1</sup>
- <sup>1</sup> Paul Sabatier University, Toulouse, France
- <sup>2</sup> Software Competence Center Hagenberg GmbH, Hagenberg, Austria
  
## Inroduction
The MTD-DS benchmark is an SLA-aware Decision Support benchmark for multi-tenant parallel DBMSs. It extends TPC-DS by adding: (1) a multi-tenant query workload generator, (2) a performance SLO (Service Level Objective, an important component in an SLA) generator which defines a performance SLO for each query in the workload, (3) configurable DBaaS pricing models, and (4) new metrics to measure the potential capability of the multi-tenant parallel DBMS in obtaining the best trade-off between the provider’s benefit and the tenants’ satisfaction.

## Who may use it?
We expect to make our benchmark as an evaluation tool for the following use cases: (1) a new DBaaS provider would like to choose a DBMS product and a corresponding deployment strategy, (2) an existing DBaaS provider would like to evaluate its system and test new ideas (e.g., new query optimization methods) in order to increase its economic benefit without hurting the tenants’ interests, and (3) though not being the main design purpose, MTD-DS can also be used to adjust the pricing policy. In the second use case, the DBaaS solution may be already mature, e.g., the SLO negotiation and pricing policies have been fixed since long time, and real historical workloads are available. However, if the provider would like to launch a benchmarking process after every system update to assure that no regression is produced, they could adopt MTD-DS by replacing or finely customizing some modules.
Our target users also include non-profitable DBaaS providers whose objective is to self-finance the offered services. Governments who hold the data of all public hospitals and federations of multiple financially autonomous organizations are potential examples. In case of a private cloud deployment (e.g., inside a single organization), the tenants often use the services for free, but pricing models remain interesting: the provider can generate virtual bills such that the tenants will be aware of what they have consumed and thus pay attention to their future utilization.

## What is included in this GitHub projet?
In this GitHub projet, we share the source code (written in JAVA) and the necessary files to run the MTD-DS benchmark.
In order to generate bills and compute various scores related to the benchmark metrics, we use a SQLite database to register the intermediate results. Therefore, the following libraries should be downloaded and included in the JAVA project.
- SQLite JDBC driver (https://github.com/xerial/sqlite-jdbc#download). In our experiments, we used the version 3.43.2.1 ( sqlite-jdbc-3.43.2.1.jar).
- SLF4J-API (https://www.slf4j.org/api/). In our experiments, we used the version 1.7.36 (slf4j-api-1.7.36.jar).
- SLF4J-simple (https://mvnrepository.com/artifact/org.slf4j/slf4j-simple). In our experiments, we used the version 1.7.36 (slf4j-simple-1.7.36.jar).

The source code structure is shown below.
- src
- ----core
- --------Metrics.java: _to compute the final scores of the benchmark metrics_
- --------PerfSLOGenerator.java: _to generate the performance SLOs_
- --------PricingModelCommon.java: _common functions used by all pricing models_
- --------PricingModelIDS.java: _a template for instantiating the IDS pricing model_
- --------PricingModelQLSA.java: _an instantiation of the QLSA pricing model_
- --------PricingModelRCB.java: _an instantiation of the RCB pricing model_
- --------PricingModlSTB.java: _a template for instantiating the STB pricing model_
- --------TenantQueriesGenerator.java: _to generate queries for each tenant_
- --------TenantsGenerator.java: _to generate the metedata of multiple tenants_
- ----tools
- --------DBInitialization.java: _to initialize the internal SQLite database_
- --------ExecutionTraceTransformer.java: _to transform the execution traces into another format_
- --------InputFilesLoader.java: _to load the input paramters' values into the internal database_
- --------PerfSLOsPertenant.java: _to deduce the performance SLOs for each tenant according to their priority and database size_
- --------TenantsLoader.java: _to load the tenants' information into the internal database_
- ----example _(code used to prepare an example benchmarking run, but code to execute on the SUTS are in the "files" folder)_
- --------AddExplain.java: _to add EXPLAIN ANALYZE before each query in order to print the query execution plans_
- --------DataForFigures.java: _to extract relevant data for visualization_
- --------EnableNLforExists.java: _to set enable_nestloop = on for several queries_
- --------ErrorCorrectionForPG.java: _fix several syntax errors with respect to PostgreSQL_
- --------ExecTimeExtractor.java: _to extract the execution times from the execution plan files_
- --------ExecTimeExtractor2.java: _to extract the execution times from the execution plan files of 3 repeated runs_
- --------MTTestsScriptWriter.java: _to automatically generate scripts for the multi-tenant workload tests_
- --------RewriteQueries_1_6_10_30_35_81.java: _to rewrite six queries (q1, q6, q10, q30, q35, q81) so that Postgres-XL could execute them faster_
- --------splitQueries.java: _to split a file containg many SQL queries into separate files with one query in each_
- ----reproducibility
- --------Reproduce.java: _to replay the example benchmarking run_
- --------CABTracesProcessing.java: _to merge the execution traces of all tenants during a CAB run into a single file_

The "files" folder contains various files used and produced by the benchmarking process. There is a README file inside the folder with more explications. The comments in "Reproduce.java" can also help to understand the meaning and usage of each file.

## Main steps for a benchmarking run:
- Step 1: Data and queries generation
- Step 2: Performance SLO generation
- Step 3: Multi-tenant query workload generation
- Step 4: Multi-tenant query workload tests
- (Step 5: PO_Metric 1 and PO_Metric 2 measurement
AND/OR
Step 6: PO_Metric 1 Bis and PO_Metric 2 Bis measurement)
- Step 7: Final scores computation

## About the reproducibility
The duration of the complete run is controled to be reasonable (less than 72 hours). However, the difficulty for reproducing all our (intermediate and final) experimental results is not to run the benchmark itself, but to deploy and configure the SUTs. It is very time consuming, and what's more, since the hardware used will be anyway different, the gathered numbers will also be different. However, these numbers are only the input of the core MTD-DS benchmark proposal. Therefore, we provide them directly in dedicated sub-folders in the "files" folder, so that the steps of the core benchmark proposal can be replayed (by using the program in ***src/reproducibility/Reproduce.java***). All these "directly provided" intemediate materials are in plain text format, so they can be easily visualized and checked, if necessary. We have conducted some preliminary experiments by using the CAB benchmark (https://github.com/alexandervanrenen/cab), in order to show the difference between MTD-DS and CAB on scope of application.

The code in the "src" folder has been tested in ***Windows 10***, while the code in the "files" folder was run in Linux (Ubuntu). ***If you use other platforms, you may need to change a small part of the code***.


