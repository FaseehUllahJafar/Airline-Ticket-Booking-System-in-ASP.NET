--create database AirlineSystem
use AirlineSystem
go
drop table if exists feedback
drop table if exists [user]
drop table if exists booking
drop table if exists discounts
drop table if exists seats
drop table if exists airplane
drop table if exists history
drop table if exists [admin]
drop table if exists airport
go
drop procedure if exists add_airplane
drop procedure if exists edit_discounts
drop procedure if exists edit_classprice
drop procedure if exists edit_booking
drop procedure if exists delete_booking
drop procedure if exists remove_airplane
drop procedure if exists add_booking
drop procedure if exists edit_airplane
go


--Admin: 3NF
--�	CNIC(pk)
--�	Email(not null)
--�	Name(not null)
--�	Password(not null)
create table [admin] (cnic varchar(16) primary key, email varchar(25) not null, [name] varchar(30) not null, [password] varchar(16) not null )
go
--User  3NF
--�	CNIC(pk)
--�	Email(not null)
--�	Name(not null)
--�	Password(not null)
--�	balance
create table [user] (cnic varchar(16) primary key, email varchar(25) not null, [name] varchar(30) not null, [password] varchar(16) not null,country varchar(35),city varchar(35),adress varchar(99),phone varchar(20),gender varchar(10), balance int default(50000))
go
--feedback  3NF
--�	CNIC (not null)
--�	feedback (not null)
create table feedback ( cnic varchar(16) , feedback varchar(5000) not null,
foreign key (cnic) REFERENCES [user](cnic) on delete set null on update cascade )
go
--airports: 3NF
--�	Airport Code(pk)
--�	Airport Name(Not Null)
--�	City(not null)
--�	Country(not null)
create table airport (airport_code int primary key, airport_name varchar(30),city varchar(30), country varchar(30) )
go
--Airplane  3NF
--�	Airplane id(pk) 
--�	timing and date
--�	destination airport(not null)
--�	departure airport
create table airplane (airplane_id int primary key,flight_DateTime datetime, destination_airport int,departure_airport int,
foreign key (destination_airport) REFERENCES airport(airport_code) on delete set null on update cascade )
go
--Seats:    3NF
--�	airlane id(plane.FK)  PK
--�	Class_name (not null) PK
--�	price(not null)
--�	available seats
--�	total seats (not null)
create table seats (airplane_id int, class_name varchar(15), price int not null, available_seats int, total_seats int not null, startingSeat int not null ,endingSeat int not null
primary key (airplane_id,class_name),
foreign key (airplane_id) REFERENCES airplane(airplane_id) on update cascade on delete cascade )
go
--Discounts:    3NF
--�	offer (not null) PK
--�	discount_persent (float)
--�	status (not null) 
create table discounts ( offer varchar(35)  primary key, discount_percent float not null,[status] bit not null)
go
--booking   3NF
--�	seat_number                         (pk)
--�	flight_DateTime (not null)  ->FK    (pk)
--�	cnic (not null)
--�	plane_ID (not null)  ->FK           (pk)
--�	discount_ID          ->FK
--�	class          ->FK
create table booking (seat_number int not null,flight_DateTime datetime not null, 
cnic int not null, plane_ID int not null, discount_name varchar(35), class varchar(15) not null
primary key (plane_ID, seat_number, flight_DateTime),
foreign key (plane_ID) REFERENCES airplane(airplane_id) on update no action on delete no action,
foreign key (discount_name) REFERENCES discounts(offer) on update cascade on delete set null)
go
--history   3NF
--�	seat_number                         (pk)
--�	flight_DateTime (not null)		    (pk)
--�	departure_airport (not null)
--�	cnic
--�	plane_ID							(pk)
--� destination_airport
--� offer
--� percentage
--�	class     
create table history (seat_number int,cnic int not null,flight_DateTime datetime, plane_ID int,departure_city varchar(35),destination_city varchar(35),offer varchar(35),d_percentage float, class varchar(15) ,price int
primary key (plane_ID, seat_number, flight_DateTime))
go

------------------------------------------

insert into [admin]	values ('0','admin@airlinesystem.com','Admin','123456789')
go
insert into [user]	values ('0','admin@airlinesystem.com','Admin','123456789','Pakistan','Vehari','house no 1, street no 1, town 1, vehari','0300-1234567','male', 99999)
go
insert into airport	values (234,'Airport','lahore','pakistan'),(123,'Airport','Karachi','pakistan')
go
insert into airplane values (1,'2021-12-15 00:00:00.000',123,234)
go
insert into seats values (1,'economy',9000,100,100,73,172),(1,'business',15000,24,24,1,24),(1,'exclusive',11000,48,48,25,72)
go
--insert into feedback values ('0','This is feedback from user with cnic 0')
--go
insert into discounts values('Golden Costumer',15,0),('Regular Costumer',8,0),('1st Ticket',5,0),('Vocations',2.5,0)
go
--insert into booking values (1,'2021-12-15 00:00:00.000','0',1,'EveryOne','business');
--go


------------------------------------------
--return 0 for Completion succesfully
--return 1 for Airplane already exists (failed)
--return 2 Wrong Destination (failed)
--return 3 Wrong departure (failed) 
create procedure add_airplane
	@id int,
	@flight_date_time datetime,
	@destination_airport int,
	@departure_airport int,
	@ret int output 
as begin
	declare @flag int,@check_destination int, @check_departure int
	set @flag = (select COUNT(*) from airplane where airplane_id=@id)
	set @check_departure = (select count(*) from airport where airport_code=@departure_airport)
	set @check_destination = (select count(*) from airport where airport_code=@destination_airport)
	if @flag =0	
		begin 
			if @check_departure != 0
			begin
				if @check_destination !=0
				begin
					insert into airplane (airplane_id,flight_DateTime, destination_airport, departure_airport) values (@id,@flight_date_time,@destination_airport,@departure_airport);
					insert into seats values (@id,'economy',9000,100,100,73,172),(@id,'business',15000,24,24,1,24),(@id,'exclusive',11000,48,48,25,72)
					set @ret = 0;
				end
				else 
				begin 
					set @ret = 2;
				end
			end
			else
			begin
				set @ret = 3;
			end
		end
		else
		begin 
			set @ret=1;
		end
end
go
------------------------------------------
--return 0 for Completion succesfully
--return 1 for Some Booking exists so, connot change departure
--return 2 for Some Booking exists so, connot change destination
create procedure edit_airplane
	@airplane_id int,
	@new_flight_datetime datetime,
	@new_destination_airport int,
	@new_departure_airport int,
	@ret int output
as begin
	declare @old_destinstion_airport int,@old_departure_airport int, @check_booking int,@reset_seats_airplane int,@reset_check int
	set @reset_check=(select count(*) from booking where flight_DateTime < CURRENT_TIMESTAMP)
	set @reset_seats_airplane=(select top 1 plane_id from booking where flight_DateTime < CURRENT_TIMESTAMP)
	if @reset_check != 0
	begin
		update seats 
		set
			available_seats=24
		where
			airplane_id=@reset_seats_airplane and class_name='business'
			update seats 
		set
			available_seats=48
		where
			airplane_id=@reset_seats_airplane and class_name='exclusive'
			update seats 
		set
			available_seats=100
		where
			airplane_id=@reset_seats_airplane and class_name='economy'
		delete booking where flight_DateTime < CURRENT_TIMESTAMP
	end
	set @old_destinstion_airport=(select destination_airport from airplane where airplane_id=@airplane_id)
	set @old_departure_airport=(select departure_airport from airplane where airplane_id=@airplane_id)
	set @check_booking=(select count(*) from booking where plane_ID=@airplane_id)
	
	if @check_booking =0
	begin
		update airplane 
		set
			flight_DateTime=@new_flight_datetime,
			departure_airport=@new_departure_airport,
			destination_airport= @new_destination_airport
		where 
			airplane_id=@airplane_id
		set @ret =0;
	end
	else
	begin
		if @new_departure_airport = @old_departure_airport
		begin
			if @new_destination_airport= @old_destinstion_airport
			begin
				update airplane 
				set
					flight_DateTime=@new_flight_datetime
				where 
					airplane_id=@airplane_id
				update history
				set
					flight_DateTime=@new_flight_datetime
				where 
					plane_id=@airplane_id
				update booking 
				set
					flight_DateTime=@new_flight_datetime
				where 
					plane_id=@airplane_id
				set @ret =0;
			end
			else
			begin
				set @ret=2;
			end
		end
		else
		begin
			set @ret=1
		end
	end
end
go
------------------------------------------
--return 0 for Completion succesfully
--return 1 for wrong airplane id
--return 2 for booking exists
create procedure remove_airplane 
	@airplane_ID int,
	@ret int output
as begin
	declare @flag int, @flag2 int,@reset_seats_airplane int,@reset_check int
	set @reset_check=(select count(*) from booking where flight_DateTime < CURRENT_TIMESTAMP)
	set @reset_seats_airplane=(select top 1 plane_id from booking where flight_DateTime < CURRENT_TIMESTAMP)
	if @reset_check != 0
	begin
		update seats 
		set
			available_seats=24
		where
			airplane_id=@reset_seats_airplane and class_name='business'
			update seats 
		set
			available_seats=48
		where
			airplane_id=@reset_seats_airplane and class_name='exclusive'
			update seats 
		set
			available_seats=100
		where
			airplane_id=@reset_seats_airplane and class_name='economy'
		delete booking where flight_DateTime < CURRENT_TIMESTAMP
	end
	set @flag = (select COUNT(*) from airplane where airplane_id=@airplane_ID)
	set @flag2= (select count(*) from booking where plane_ID= @airplane_ID)
	if @flag2 !=0
	begin
		set @ret = 2;
	end
	else 
	begin
		if @flag != 0
		begin
			delete from airplane where airplane_id=@airplane_ID;
			set @ret=0;
		end
		else
		begin 
			set @ret=1;
		end
	end
end
go
------------------------------------------
--return 0 for Completion succesfully
--return 1 for Wrong discount name
create procedure edit_discounts 
	@status bit,
	@name varchar(15),
	@percent float ,
	@ret int output 
as begin
	declare @flag int
	set @flag = (select count(*) from discounts where offer=@name)
	if @flag !=0
	begin
		update discounts 
		set [status]=@status , 
			discount_percent = @percent 
		where 
			offer=@name 
		set @ret=0
	end
	else 
	begin
		set @ret=1
	end
	
end
go
------------------------------------------
--return 0 for Completion succesfully
--return 1 for Wrong Class Name
create procedure edit_classprice 
	@airplane_id int,
	@class_name varchar(15),
	@money int,
	@ret int output 
as begin
	declare @flag int
	set @flag = (select count(*) from seats where class_name =@class_name and airplane_id=@airplane_id)
	if @flag !=0
	begin
		update seats 
	set price = @money 
	where class_name=@class_name and airplane_id=@airplane_id
	set @ret=0;
	end
	else 
	begin
		set @ret=1
	end
end
go
------------------------------------------
--return 0 for Completion succesfully
--return 1 for failure (given data is not not available in booking table)
create procedure delete_booking 
	@seat_number int, 
	@flight_datetime datetime, 
	@cnic varchar(16), 
	@ret int output 
as begin
	declare @flag int,@reset_seats_airplane int,@reset_check int,@seat_class varchar(30),@plane_id int
	set @reset_check=(select count(*) from booking where flight_DateTime < CURRENT_TIMESTAMP)
	set @reset_seats_airplane=(select top 1 plane_id from booking where flight_DateTime < CURRENT_TIMESTAMP)
	set @seat_class=(select class from booking where  seat_number=@seat_number and flight_DateTime=@flight_datetime and cnic=@cnic)
	set @plane_id=(select plane_ID from booking where  seat_number=@seat_number and flight_DateTime=@flight_datetime and cnic=@cnic)
	if @reset_check != 0
	begin
		update seats 
		set
			available_seats=24
		where
			airplane_id=@reset_seats_airplane and class_name='business'
			update seats 
		set
			available_seats=48
		where
			airplane_id=@reset_seats_airplane and class_name='exclusive'
			update seats 
		set
			available_seats=100
		where
			airplane_id=@reset_seats_airplane and class_name='economy'
		delete booking where flight_DateTime < CURRENT_TIMESTAMP
	end
	set @flag = (select count(*) from booking where seat_number=@seat_number and flight_DateTime=@flight_datetime and cnic=@cnic );
	if @flag !=0
	begin
 		delete from booking 
		where 
			seat_number=@seat_number and flight_DateTime=@flight_datetime and cnic=@cnic;
		update seats 
		set
			available_seats=available_seats+1
		where
			airplane_id=@plane_id and class_name=@seat_class
		set @ret=0;
	end
	else 
	begin 
		set @ret=1;
	end
end
go
------------------------------------------
--return 0 for successful completion
--return 1 for same destination same departure
--return 2 for no seats available in current time and destination
--return 3 for no plane available for given time and destination
--return 4 for wrong information provided
create procedure edit_booking 
	@seat_number int, 
	@old_flight_datetime datetime, 
	@cnic varchar(16),
		@new_flight_datetime datetime,
		@new_destination int,
		@new_departure int,
		@new_seat_class varchar(15), 
	@ret int output 
as begin
	declare @old_destination int, @plane_avail int, @seat_avil int, @new_planeID int, @new_seat_no int, @available_seats int, @total_seats int,@checek_data int,@old_plane int, @old_class_name varchar(15),@reset_seats_airplane int,@reset_check int
	set @reset_check=(select count(*) from booking where flight_DateTime < CURRENT_TIMESTAMP)
	set @reset_seats_airplane=(select top 1 plane_id from booking where flight_DateTime < CURRENT_TIMESTAMP)
	if @reset_check != 0
	begin
		update seats 
		set
			available_seats=24
		where
			airplane_id=@reset_seats_airplane and class_name='business'
			update seats 
		set
			available_seats=48
		where
			airplane_id=@reset_seats_airplane and class_name='exclusive'
			update seats 
		set
			available_seats=100
		where
			airplane_id=@reset_seats_airplane and class_name='economy'
		delete booking where flight_DateTime < CURRENT_TIMESTAMP
	end
	set @old_destination = (select destination_airport from airplane where airplane_id =(select plane_id from booking where seat_number=@seat_number and flight_DateTime=@old_flight_datetime and cnic=@cnic));
	set @old_plane = (select plane_id from booking where seat_number=@seat_number and flight_DateTime=@old_flight_datetime and cnic=@cnic)
	set @old_class_name= (select class from booking where seat_number=@seat_number and flight_DateTime=@old_flight_datetime and cnic=@cnic)
	set @plane_avail = (select count(*) from airplane where destination_airport=@new_destination and flight_DateTime=@new_flight_datetime and departure_airport= @new_departure);
	set @seat_avil = (select count(*) from seats where available_seats>0 and class_name=@new_seat_class and airplane_id in (select airplane_id from airplane where destination_airport=@new_destination and flight_DateTime= @new_flight_datetime))
	set @new_planeID = (select airplane_id from seats where available_seats>0 and class_name= @new_seat_class and airplane_id in(	select airplane_id from airplane where departure_airport= @new_departure and destination_airport= @new_destination and flight_DateTime= @new_flight_datetime))
	set @available_seats=(select available_seats from seats where airplane_id = @new_planeID and class_name= @new_seat_class)
	set @total_seats= (select endingSeat from seats where airplane_id = @new_planeID and class_name= @new_seat_class)
	set @new_seat_no = (@total_seats-@available_seats)+1
	set @checek_data = (select count(*) from booking where seat_number=@seat_number and flight_DateTime=@old_flight_datetime and cnic=@cnic)
	--   --    --    --   --   --   --   --   --    --    --   --   --   --  
	if @checek_data != 0
	begin
			if @plane_avail != 0
			begin
				if @seat_avil >=0
				begin
					if @new_departure != @new_destination
					begin
						update booking 
							set flight_DateTime= @new_flight_datetime,
								class=@new_seat_class,
								plane_ID=@new_planeID,
								seat_number=@new_seat_no
							where
								seat_number=@seat_number and flight_DateTime=@old_flight_datetime and cnic=@cnic
						if @old_plane != @new_planeID
						begin
							update seats 
								set
									available_seats=available_seats+1
								where 
									airplane_id = @old_plane and class_name = @old_class_name
							update seats 
								set 
									available_seats = available_seats-1
								where 
									airplane_id = @new_planeID and class_name= @new_seat_class
						end
						else
						begin
							if @old_class_name != @new_seat_class
							begin
								update seats 
								set
									available_seats=available_seats+1
								where 
									airplane_id = @old_plane and class_name = @old_class_name
								update seats 
								set 
									available_seats = available_seats-1
								where 
									airplane_id = @new_planeID and class_name= @new_seat_class
							end
						end
						set @ret=0;
					end
					else
					begin
						set @ret=1;	--Same destination same Departure
					end
				end
				else
				begin
					set @ret=2;		--No Seats Available 
				end
			end
			else
			begin
				set @ret=3;	--No Airplane available
			end
	end
	else
	begin
		set @ret=4;		--Wrong information
	end
end
go
------------------------------------------
--return 0 for successful completion
--return 1 No airplane available for specific 
--return 2 Number of required seats are not available
--return 3 when flight has already left
create procedure add_booking
	@seat_class varchar(15),
	@no_of_seats int,
	@cnic varchar(16),
	@flight_dateTime datetime,
	@destination_city int,
	@departure_city int,
	@ret int output
as begin
	declare @plane_id int, @destination_airport_city varchar(35), @departure_airport_city varchar(35), @discount_name1 varchar(35), @discount_name2 varchar(35),@airplane_count int,@available_seats int, @total_seats int,
						   @seat_no int ,@count_ticketBought int,@discount varchar(35), @discount_name3 varchar(35), @discount_name4 varchar(35),@check_all_seats int,@discount_percent float, @while_check int,@s1 int,
						   @s2 int,@s3 int,@s4 int, @price int,@discount_price int,@reset_seats_airplane int,@reset_check int--,@s1_percent float,@s2_percent float,@s3_percent float,@s4_percent float
	set @reset_check=(select count(*) from booking where flight_DateTime < CURRENT_TIMESTAMP)
	set @reset_seats_airplane=(select top 1 plane_id from booking where flight_DateTime < CURRENT_TIMESTAMP)
	if @reset_check != 0
	begin
		update seats 
		set
			available_seats=24
		where
			airplane_id=@reset_seats_airplane and class_name='business'
			update seats 
		set
			available_seats=48
		where
			airplane_id=@reset_seats_airplane and class_name='exclusive'
			update seats 
		set
			available_seats=100
		where
			airplane_id=@reset_seats_airplane and class_name='economy'
		delete booking where flight_DateTime < CURRENT_TIMESTAMP
	end
	set @destination_airport_city=(select city from airport where airport_code=@destination_city)
	set @departure_airport_city = (select city from airport where airport_code=@departure_city)
	set @while_check=0
	set @airplane_count = (select count(*) from airplane where destination_airport=@destination_city and departure_airport= @departure_city and flight_DateTime= @flight_dateTime);
	set @plane_id= (select airplane_id from airplane where destination_airport=@destination_city and departure_airport= @departure_city and flight_DateTime= @flight_dateTime);
	set @available_seats = (select available_seats from seats where class_name= @seat_class and airplane_id=@plane_id)
	set @check_all_seats = @available_seats-@no_of_seats;
	set @total_seats =  (select endingSeat from seats where class_name= @seat_class and airplane_id=@plane_id)
	set @seat_no= (@total_seats-@available_seats)+1;
	set @price= (select price from seats where airplane_id=@plane_id and class_name=@seat_class)
	set @discount=(select top 1 offer from discounts where [status]=1 order by discount_percent desc)
	set @discount_percent=(select discount_percent from discounts where offer=@discount)
	--set @discount_name1= (select offer from(select offer,row_number() over(order by offer) as 'row'  from discounts)as temp where row=1)--1st Ticket
	--set @s1= (select [status] from(select [status],row_number() over(order by offer) as 'row'  from discounts)as temp where row=1)
	--set @s1_percent= (select discount_percent from(select discount_percent,row_number() over(order by offer) as 'row'  from discounts)as temp where row=1)
	--set @discount_name2= (select offer from(select offer,row_number() over(order by offer) as 'row'  from discounts)as temp where row=2)--Golden Costumer
	--set @s2=(select [status] from(select [status],row_number() over(order by offer) as 'row'  from discounts)as temp where row=2)
	--set @s2_percent= (select discount_percent from(select discount_percent,row_number() over(order by offer) as 'row'  from discounts)as temp where row=2)
	--set @discount_name3= (select offer from(select offer,row_number() over(order by offer) as 'row'  from discounts)as temp where row=3)--Regular Costumer
	--set @s3=(select [status] from(select [status],row_number() over(order by offer) as 'row'  from discounts)as temp where row=3)
	--set @s3_percent= (select discount_percent from(select discount_percent,row_number() over(order by offer) as 'row'  from discounts)as temp where row=3)
	--set @discount_name4= (select offer from(select offer,row_number() over(order by offer) as 'row'  from discounts)as temp where row=4)--Vocations
	--set @s4=(select [status] from(select [status],row_number() over(order by offer) as 'row'  from discounts)as temp where row=4)
	--set @s4_percent= (select discount_percent from(select discount_percent,row_number() over(order by offer) as 'row'  from discounts)as temp where row=4)
--######################################################################################################
	--if @s1 !=0
	--begin
	--	if @discount_percent<@s1_percent
	--	begin
	--		set @discount=@discount_name1
	--		set @discount_percent=@s1_percent
	--	end
	--end
	--if @s2 !=0
	--begin
	--	if @discount_percent<@s2_percent
	--	begin
	--		set @discount=@discount_name2
	--		set @discount_percent=@s2_percent
	--	end
	--end
	--if @s3 !=0
	--begin
	--	if @discount_percent<@s3_percent
	--	begin
	--		set @discount=@discount_name3
	--		set @discount_percent=@s3_percent
	--	end
	--end
	--if @s4 !=0
	--begin
	--	if @discount_percent<@s4_percent
	--	begin
	--		set @discount=@discount_name4
	--		set @discount_percent=@s4_percent
	--	end
	--end
--######################################################################################################
	--set @count_ticketBought = (select count(*) from history where cnic=@cnic)
	--if @count_ticketBought >10
	--begin
	--	if @s2 !=0
	--	begin
	--		set @discount=@discount_name2;
	--	end
	--end
	--else
	--begin
	--	if @count_ticketBought >= 5
	--	begin
	--		if @s3 !=0
	--		begin
	--			set @discount=@discount_name3;
	--		end
	--	end
	--	else
	--	begin
	--		if @count_ticketBought <1
	--		begin
	--			if @s1 !=0
	--			begin
	--				set @discount=@discount_name1;
	--			end
	--		end
	--	end
	--end
	--set @discount_percent = (select discount_percent from discounts where offer = @discount)
	--if ((month(getdate())>=6 and month(getdate())<=8)OR(month(getdate())=12)) 
	--begin
	--	if @s4 !=0
	--	begin
	--		declare @s4_percent float
	--		set @s4_percent=(select @discount_percent from(select [status],row_number() over(order by offer) as 'row'  from discounts)as temp where row=4)
	--		if @s4_percent > @discount_percent
	--		begin
	--			set @discount=@discount_name4
	--			set @discount_percent=@s4_percent
	--		end
	--	end
	--end
--######################################################################################################
	if @discount is not null
	begin
		set @discount_price= ((select discount_percent from discounts where offer=@discount)/100)*@price
		set @price=@price-@discount_price
	end
if @flight_dateTime > CURRENT_TIMESTAMP
begin
	if @airplane_count !=0
	begin
		if @check_all_seats >0
		begin
			while @no_of_seats >0
			begin
				insert into booking(seat_number,flight_DateTime,cnic,plane_ID,discount_name,class) values 
								   (@seat_no,@flight_dateTime,@cnic,@plane_id,@discount,@seat_class)
				update seats 
					set available_seats= available_seats-1
					where airplane_id=@plane_id and class_name=@seat_class

				insert into history (seat_number,cnic,flight_DateTime,plane_ID,departure_city,destination_city,offer,d_percentage,class,price) values
									(@seat_no,@cnic,@flight_dateTime,@plane_id,@departure_airport_city,@destination_airport_city,@discount,@discount_percent,@seat_class,@price)
				set @available_seats = (select available_seats from seats where class_name= @seat_class and airplane_id=@plane_id)
				set @seat_no= (@total_seats-@available_seats)+1;
				set @no_of_seats = @no_of_seats-1;
			end
			set @ret =0;		--Sucessful	
		end
		else 
		begin
			set @ret =2;		--Number of required seats are not available
		end
	end
	else
	begin
		set @ret = 1;		--No airplane available
	end
end
else
begin
	set @ret=3;		--Flight Time is gone
end
end
go
------------------------------------------
--Printing all tables
SELECT* FROM [ADMIN]
SELECT* FROM [USER]
SELECT* FROM AIRPORT
SELECT* FROM AIRPLANE
SELECT* FROM SEATS
SELECT* FROM BOOKING
SELECT* FROM HISTORY
SELECT* FROM FEEDBACK
SELECT* FROM DISCOUNTS
go
------------------------------------------
--declare @out1 int;
--execute add_airplane @id ='3',@flight_date_time ='2021-12-13 23:27:00.000',@destination_airport ='XYZ',@ret=@out1 OUTPUT;
--select @out1 as result
--go
------------------------------------------
--go
--declare @out int;
--execute edit_booking 
--	@seat_number  ='19', 
--	@old_flight_datetime ='2021-12-11 23:27:00.000', 
--	@cnic ='0',
--		@new_flight_datetime  ='2021-12-11 23:27:00.000',
--		@new_destination  =123,
--		@new_departure  =234,
--		@new_seat_class ='economy', 
--	@ret = @out output ;
--	select @out as result
--	select* from booking
--	select* from airplane
--	select* from seats
------------------------------------------
--go
--declare @out int
--execute remove_airplane 
--@airplane_ID= 1, 
--@ret =@out output
--select @out as result
--select* from airplane
------------------------------------------
--go
--select * from discounts
--declare @out int
--execute edit_discounts 
--	@status =1,
--	@name = 'Sasta',
--	@percent = 9.4,
--@ret =@out output
--select @out as result 
------------------------------------------
--go
--declare @out int
--execute edit_classprice 
--	@class_name ='economy',
--	@money = 10000,
--	@ret =@out output 
--	select @out as result 
--	select * from seats
------------------------------------------
--go
--declare @out int
--execute delete_booking 
--	@seat_number  ='72', 
--	@flight_datetime ='2021-12-11 23:27:00.000', 
--	@cnic ='0', 
--	@ret =@out output 
--	select @out as result 
--	select * from booking
------------------------------------------
--go
--declare @out int
--execute add_booking
--	@seat_class ='economy',
--	@no_of_seats = 3,
--	@cnic ='0',
--	@flight_dateTime ='2021-12-28 00:00:00.000',
--	@destination_city = 123,
--	@departure_city = 234,
--	@ret =@out output 
--	select @out as result 
--	select * from booking
--	select* from history
--	select* from seats
--	select*from airplane
--	select*from discounts
------------------------------------------
--go
--declare @out int
--execute edit_airplane
--	@airplane_id = 1,
--	@new_flight_datetime= '2021-12-28 00:00:00.000',
--	@new_destination_airport= 123,
--	@new_departure_airport = 234,
--	@ret =@out output 
--	select @out as result 
--	select * from booking
--	select*from airplane
--	select* from history
------------------------------------------
--Printing all tables
SELECT* FROM [ADMIN]
SELECT* FROM [USER]
SELECT* FROM AIRPORT
SELECT* FROM AIRPLANE
SELECT* FROM SEATS
SELECT* FROM BOOKING
SELECT* FROM HISTORY
SELECT* FROM FEEDBACK
SELECT* FROM DISCOUNTS
