SET   IDENTITY_INSERT   Sys_SerialBase   ON
--set   nocount   on   select   'insert   Sys_SerialBase(R_ID,B_Group,B_Object,B_Prefix,B_IDLen,B_Base,B_Date)   values('as   '--',R_ID,',',''''+B_Group+'''',',',''''+B_Object+'''',',',''''+B_Prefix+'''',',',B_IDLen,',',B_Base,',',''''+convert(char(23),B_Date,121)+'''',')'   from   Sys_SerialBase
--                                                                                      R_ID                                                                                                             B_IDLen          B_Base                                     
--------------------------------------------------------------------------------------- ----------- ---- ----------------- ---- ---------------------------------- ---- --------------------------- ---- ----------- ---- ----------- ---- ------------------------- ----
insert   Sys_SerialBase(R_ID,B_Group,B_Object,B_Prefix,B_IDLen,B_Base,B_Date)   values( 1           ,    'BusFunction'     ,    'Bus_Bill'                         ,    'TH'                        ,    11          ,    0           ,    '2014-09-30 21:56:27.533' )
insert   Sys_SerialBase(R_ID,B_Group,B_Object,B_Prefix,B_IDLen,B_Base,B_Date)   values( 2           ,    'BusFunction'     ,    'Bus_Pound'                        ,    'PB'                        ,    11          ,    0           ,    '2014-09-30 21:59:15.000' )
SET   IDENTITY_INSERT   Sys_SerialBase   OFF
