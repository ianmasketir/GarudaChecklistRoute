USE [InternalMemorandum]
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertApproverIM]    Script Date: 4/16/2020 11:17:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_InsertApproverIM](
	@listApprover as varchar(max),
	@idIM as uniqueidentifier,
	@type as varchar(50)
)
as begin
	if(@type = 'Preparer')
	begin
		if(CHARINDEX('Temporary', @type) < 0)
		begin
			insert into Tr_IMPreparer(ID, IDIM, PreparerUserlogin, PreparerIndex, PreparerAssignedDate, PreparerName, PreparerJobPosition)
			select NEWID(), @idIM, A.Result, A.[Index], GETDATE(), B.Nama, B.PositionName
			from(select *
			from [GarudaIndonesia].[dbo].[fn_splitString](@listApprover)) A
			left join [GarudaIndonesia].[dbo].[Ms_Users] B on B.User_Login = A.Result
		end
		else
		begin
			insert into Tr_IMPreparer_Temporary(ID, IDIM, PreparerUserlogin, PreparerIndex, PreparerAssignedDate, PreparerName, PreparerJobPosition)
			select NEWID(), @idIM, A.Result, A.[Index], GETDATE(), B.Nama, B.PositionName
			from(select *
			from [GarudaIndonesia].[dbo].[fn_splitString](@listApprover)) A
			left join [GarudaIndonesia].[dbo].[Ms_Users] B on B.User_Login = A.Result
		end
	end
	else if(@type = 'Reviewer')
	begin
		if(CHARINDEX('Temporary', @type) < 0)
		begin
			insert into Tr_IMReviewer(ID, IDIM, ReviewerUserlogin, ReviewerIndex, ReviewerAssignedDate, ReviewerName, ReviewerJobPosition)
			select NEWID(), @idIM, A.Result, A.[Index], GETDATE(), B.Nama, B.PositionName
			from(select *
			from [GarudaIndonesia].[dbo].[fn_splitString](@listApprover)) A
			left join [GarudaIndonesia].[dbo].[Ms_Users] B on B.User_Login = A.Result
		end
		else
		begin
			insert into Tr_IMReviewer_Temporary(ID, IDIM, ReviewerUserlogin, ReviewerIndex, ReviewerAssignedDate, ReviewerName, ReviewerJobPosition)
			select NEWID(), @idIM, A.Result, A.[Index], GETDATE(), B.Nama, B.PositionName
			from(select *
			from [GarudaIndonesia].[dbo].[fn_splitString](@listApprover)) A
			left join [GarudaIndonesia].[dbo].[Ms_Users] B on B.User_Login = A.Result
		end
	end
	else if(@type = 'Acknowledge')
	begin
		if(CHARINDEX('Temporary', @type) < 0)
		begin
			insert into Tr_IMAcknowledge(ID, IDIM, AcknowledgeUserlogin, AcknowledgeIndex, AcknowledgeAssignedDate, AcknowledgeName, AcknowledgeJobPosition)
			select NEWID(), @idIM, A.Result, A.[Index], GETDATE(), B.Nama, B.PositionName
			from(select *
			from [GarudaIndonesia].[dbo].[fn_splitString](@listApprover)) A
			left join [GarudaIndonesia].[dbo].[Ms_Users] B on B.User_Login = A.Result
		end
		else
		begin
			insert into Tr_IMAcknowledge_Temporary(ID, IDIM, AcknowledgeUserlogin, AcknowledgeIndex, AcknowledgeAssignedDate, AcknowledgeName, AcknowledgeJobPosition)
			select NEWID(), @idIM, A.Result, A.[Index], GETDATE(), B.Nama, B.PositionName
			from(select *
			from [GarudaIndonesia].[dbo].[fn_splitString](@listApprover)) A
			left join [GarudaIndonesia].[dbo].[Ms_Users] B on B.User_Login = A.Result
		end
	end
	else if(@type = 'Reviewer')
	begin
		if(CHARINDEX('Temporary', @type) < 0)
		begin
			insert into Tr_IMReviewer(ID, IDIM, ReviewerUserlogin, ReviewerIndex, ReviewerAssignedDate, ReviewerName, ReviewerJobPosition)
			select NEWID(), @idIM, A.Result, A.[Index], GETDATE(), B.Nama, B.PositionName
			from(select *
			from [GarudaIndonesia].[dbo].[fn_splitString](@listApprover)) A
			left join [GarudaIndonesia].[dbo].[Ms_Users] B on B.User_Login = A.Result
		end
		else
		begin
			insert into Tr_IMReviewer_Temporary(ID, IDIM, ReviewerUserlogin, ReviewerIndex, ReviewerAssignedDate, ReviewerName, ReviewerJobPosition)
			select NEWID(), @idIM, A.Result, A.[Index], GETDATE(), B.Nama, B.PositionName
			from(select *
			from [GarudaIndonesia].[dbo].[fn_splitString](@listApprover)) A
			left join [GarudaIndonesia].[dbo].[Ms_Users] B on B.User_Login = A.Result
		end
	end
	else if(@type = 'Final Approver')
	begin
		if(CHARINDEX('Temporary', @type) < 0)
		begin
			insert into Tr_IMFinalApprover(ID, IDIM, FinalApproverUserlogin, FinalApproverIndex, FinalApproverAssignedDate, FinalApproverName, FinalApproverJobPosition)
			select NEWID(), @idIM, A.Result, A.[Index], GETDATE(), B.Nama, B.PositionName
			from(select *
			from [GarudaIndonesia].[dbo].[fn_splitString](@listApprover)) A
			left join [GarudaIndonesia].[dbo].[Ms_Users] B on B.User_Login = A.Result
		end
		else
		begin
			insert into Tr_IMFinalApprover_Temporary(ID, IDIM, FinalApproverUserlogin, FinalApproverIndex, FinalApproverAssignedDate, FinalApproverName, FinalApproverJobPosition)
			select NEWID(), @idIM, A.Result, A.[Index], GETDATE(), B.Nama, B.PositionName
			from(select *
			from [GarudaIndonesia].[dbo].[fn_splitString](@listApprover)) A
			left join [GarudaIndonesia].[dbo].[Ms_Users] B on B.User_Login = A.Result
		end
	end
end