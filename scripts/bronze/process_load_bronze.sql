CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @total_start DATETIME ,@total_end DATETIME;
	DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY
		PRINT 'BULK INSERT INTO THE BORNZE LAYER HAS STARTED';
		PRINT '================================================================'

		PRINT 'LOADING CRM TABLES';
		PRINT '--------------------------------------------------------------'
		SET @total_start = GETDATE();
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\cust_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		


		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\prd_info.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ','
		);

		TRUNCATE TABLE bronze.crm_sales_details;
		BULK  INSERT  bronze.crm_sales_details
		FROM 'C:\sales_details.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'TOTAL TIME TAKEN TO LOAD THE CRM TABLE ELEMENT IS ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +' SECONDS'

		PRINT 'LOADING ERP TABLES';
		PRINT '--------------------------------------------------------------'
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;
		BULK  INSERT  bronze.erp_cust_az12
		FROM 'C:\CUST_AZ12.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);


		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK  INSERT  bronze.erp_loc_a101
		FROM 'C:\LOC_A101.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);

		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		BULK  INSERT  bronze.erp_px_cat_g1v2
		FROM 'C:\PX_CAT_G1V2.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		PRINT 'FINISHED LOADING DATA INTO BRONZE LAYER'
		SET @end_time = GETDATE();
		SET @total_end = GETDATE();
		PRINT '====================================================================================================='
		PRINT 'TOTAL TIME TAKEN TO LOAD THE ERP TABLE ELEMENT IS ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +' SECONDS'
		PRINT '====================================================================================================='
		PRINT 'TOTAL TIME TAKEN TO LOAD THE bronze LAYER ELEMENTS IS ' + CAST(DATEDIFF(second,@total_start,@total_end) AS NVARCHAR) +' SECONDS'

	END TRY
	BEGIN CATCH
		PRINT '========================================================';
		PRINT 'OOPS!! ERROR OCCURED ON LOADING THE BRONZE LAYER';
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR NUMBER' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT '========================================================';
	END CATCH
END
