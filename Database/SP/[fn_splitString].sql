USE [GarudaIndonesia]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_splitString]    Script Date: 4/16/2020 11:18:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER function [dbo].[fn_splitString](
	@input as varchar(max)
)
returns @output table(Result varchar(max), [Index] int)
as
begin
	declare @WhileFlag as varchar(4) = 'true';
	declare @Index int = 1;
	while (@WhileFlag = 'true')
	begin
		insert into @output values(SUBSTRING(@input, 0, charindex(';', @input, 0)), @Index);
		set @input = SUBSTRING(@input, (charindex(';', @input, 0)+1), (LEN(@input)-LEN(SUBSTRING(@input, 0, charindex(';', @input, 0)))));
		set @Index +=1;

		if(CHARINDEX(';', @input, 0) < 1)
		begin
			set @WhileFlag = 'false';
		end
	end

	return
end
--select * from [dbo].[fn_splitString]('a;b;c;')