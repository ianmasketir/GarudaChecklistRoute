USE [InternalMemorandum]
GO
/****** Object:  StoredProcedure [dbo].[Sp_GetNoIM]    Script Date: 4/16/2020 11:17:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Sp_GetNoIM](
	@IdIM as uniqueidentifier,
	@KodeDirektoratUserLogin as varchar(50)
)
as begin
	declare @WhileFlag as varchar(4) = 'true';
	declare @NoImNew as varchar(50) = (select NoIM from Tr_IM where ID = @IdIM);

	declare @NoIndex as varchar(50);
	declare @MonthRome as varchar(50);
	declare @LastNoIM as varchar(50);
	declare @SetSearchFilterIM as varchar(50);
	--------------------------------------------------------------------------------------
	if(@NoImNew is null or @NoImNew = '')
	begin
		set @WhileFlag = 'true'
	end
	else
	begin
		set @WhileFlag = 'false'
	end

	while(@WhileFlag = 'true')
	begin
		set @MonthRome = case when MONTH(GETDATE()) = 1 then 'I'
								when MONTH(GETDATE()) = 2 then 'II'
								when MONTH(GETDATE()) = 3 then 'III'
								when MONTH(GETDATE()) = 4 then 'IV'
								when MONTH(GETDATE()) = 5 then 'V'
								when MONTH(GETDATE()) = 6 then 'VI'
								when MONTH(GETDATE()) = 7 then 'VII'
								when MONTH(GETDATE()) = 8 then 'VIII'
								when MONTH(GETDATE()) = 9 then 'IX'
								when MONTH(GETDATE()) = 10 then 'X'
								when MONTH(GETDATE()) = 11 then 'XI'
								when MONTH(GETDATE()) = 12 then 'XII'
							end

		set @SetSearchFilterIM = ('%IM-' + @KodeDirektoratUserLogin + '/' + @MonthRome + '/' + CAST(YEAR(GETDATE()) as varchar(50)));
		--------------------------------------------------------------------------------------

		if((select COUNT(ID) from Tr_IM where NoIM like @SetSearchFilterIM and NoIM is not null and NoIM <> '' and ID <> @IdIM) > 0)
		begin
			set @LastNoIM = (select top 1 NoIM from Tr_IM where NoIM like @SetSearchFilterIM order by NoIM desc);
			set @NoIndex = SUBSTRING(@LastNoIM, 0, CHARINDEX('/', @LastNoIM, 0));
			set @NoIndex = CAST(@NoIndex as int) + 1; -- cast as int untuk menghilangkan semua angka 0 di depan
			if(len(@NoIndex) = 1)
			begin
				set @NoIndex = CONCAT('00', @NoIndex);
			end
			else if(len(@NoIndex) = 2)
			begin
				set @NoIndex = CONCAT('0', @NoIndex);
			end
		end
		else
		begin
			set @NoIndex = '001';
		end

		set @NoImNew = @NoIndex + '/IM-' + @KodeDirektoratUserLogin + '/' + @MonthRome + '/' + CAST(YEAR(getdate()) as varchar(50));
		if(not exists(select ID from Tr_IM where NoIM = @NoImNew))
		begin
			set @WhileFlag = 'false';
			update T
			set T.NoIM = @NoImNew
			from Tr_IM T
			where T.ID = @IdIM
		end
	end
	--------------------------------------------------------------------------------------
	select @NoImNew as NoIM
	--delete from IMRunningNumber
	--insert into IMRunningNumber values((select NEWID()), @NoImNew, GETDATE())
	--select ID, NoIM, CreatedDate from IMRunningNumber
end