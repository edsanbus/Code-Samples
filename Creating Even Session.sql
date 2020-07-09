CREATE EVENT SESSION [TK461CH14] ON SERVER 
ADD EVENT sqlserver.sql_statement_completed(
    WHERE ([sqlserver].[database_name]=N'TSQL2012' AND [sqlserver].[like_i_sql_unicode_string]([sqlserver].[sql_text],N'SELECT C.custid, C.companyname%'))) 
ADD TARGET package0.ring_buffer
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO


