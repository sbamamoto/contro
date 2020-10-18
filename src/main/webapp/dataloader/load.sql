insert into processor (id,version,name,description,type,processing_script) values (0,0,'ArduControl','Arduino Gateway Switching','SCRIPT','def groovy');
insert into processor (id,version,name,description,type,processing_script) values (1,0,'ArduWifi','"Arduino WLAN Switching"','SCRIPT','def groovy');
insert into processor (id,version,name,description,type,processing_script) values (2,0,'HomeMatic','"Homematic Bridge Interface"','SCRIPT','def groovy');

insert into ability (id,version,name,description,type,read_only, processor_id) values (0,0,'WifiControl','Arduino Gateway Switch','DIRECT',false, 0);
insert into ability (id,version,name,description,type,read_only, processor_id) values (1,0,'Switch ArduControl','Arduino WLAN Switch','DIRECT',false, 1);
insert into ability (id,version,name,description,type,read_only, processor_id) values (2,0,'HomematicThermostat','Homematic Bridge Thermostat Control','DIRECT',false, 2);

insert into device_type (id,version,name,description) values (0,0,'Thermostat (HMCIP)','Homematic IP Thermostat');
insert into device_type (id,version,name,description) values (1,0,'Singleswitch','ArduControl 433MHz Schalter');
insert into device_type (id,version,name,description) values (2,0,'Multiswitch','ArduWifi Schalter mit Kanalwahl');

insert into setting (id,version, setting, value) values (0,0,'partymode', 'OFF');
