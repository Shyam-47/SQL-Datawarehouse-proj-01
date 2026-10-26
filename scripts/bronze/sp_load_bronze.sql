/*
=======================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
=======================================================
Script Purpose:
This stored procedutydoads data into the 'bronze' schema from external CSV files.
It performs the follduing actions:
- Truncates the bronze tables before loading data.
- Uses the BULK INSERT' command to load data from csv Files to bronze tables.

Parameters:

None.

This stored procedure does not accept any parameters or return any values.

Usage Example:
EXEC bronze.load_bronze;

*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	BEGIN TRY
	DECLARE @start_time DATETIME,@end_time DATETIME,@batch_st_time DATETIME,@batch_ed_time DATETIME; --Declare variables to capture te start and endtime of executions
	    SET @batch_st_time=GETDATE();
		PRINT'===================================';
		PRINT'Inserting Bronze layer';
		PRINT'===================================';

		PRINT'-----------------------------------';
		PRINT'Starting CRM files load';
		PRINT'-----------------------------------';
		SET @start_time=GETDATE();
		PRINT'>>Truncating crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT'>>Commencing Insertion to crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\sql\dwh_project\01_datasets\source_crm\cust_info.csv'
		WITH
		(
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT'>>Load duration'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' Seconds';

		SET @start_time=GETDATE();
		PRINT'>>Tructating crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info
		PRINT'>>Commencing Insertion to crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\sql\dwh_project\01_datasets\source_crm\prd_info.csv'
		WITH
		(
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT'>>Load duration'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' Seconds';

		SET @start_time=GETDATE();
		PRINT'>>Tructating crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details
		PRINT'>>Commencing Insertion to crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\sql\dwh_project\01_datasets\source_crm\sales_details.csv'
		WITH
		(
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT'>>Load duration'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' Seconds';


		PRINT'-----------------------------------';
		PRINT'Starting ERP files load';
		PRINT'-----------------------------------';

		SET @start_time=GETDATE();
		PRINT'>>Tructating erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12
		PRINT'>>Commencing Insertion to erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\sql\dwh_project\01_datasets\source_erp\cust_az12.csv'
		WITH
		(
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT'>>Load duration'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' Seconds';

		SET @start_time=GETDATE();
		PRINT'>>Tructating erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101
		PRINT'>>Commencing Insertion to erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\sql\dwh_project\01_datasets\source_erp\loc_a101.csv'
		WITH
		(
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT'>>Load duration'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' Seconds';

		SET @start_time=GETDATE();
		PRINT'>>Tructating erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2
		PRINT'>>Commencing Insertion to erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\sql\dwh_project\01_datasets\source_erp\px_cat_g1v2.csv'
		WITH
		(
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT'>>Load duration'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' Seconds';

		SET @batch_ed_time=GETDATE();
		PRINT'==============================================='
		PRINT'Loading Bronze layer is completed'
		PRINT'Total duration of load '+ CAST(DATEDIFF(second,@batch_st_time,@batch_ed_time) AS NVARCHAR)+' Seconds';		
	END TRY
	BEGIN CATCH
		PRINT'========================================='
		PRINT'Error while loading Bronze layer'
		PRINT'========================================='
		PRINT'Error message'+ ERROR_MESSAGE();
		PRINT'Error Number'+ CAST(ERROR_MESSAGE() AS VARCHAR);
		PRINT'Error state'+ CAST(ERROR_STATE() AS VARCHAR);
	END CATCH
END

