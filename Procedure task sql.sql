Create Table Authors(
Id int primary key identity,
Name nvarchar(50),
Surname nvarchar(50),
)


Create Table Books(
Id int  identity,
Name nvarchar(100)Check(Len(Name) >= 2),
PageCount int Check(PageCount>=10),
AuthorId int Foreign key references Authors(Id)
)



Insert into Authors 
Values ('Viktor','Hugo'),
('Dante','Alighieri'),
('Jack','London'),
('Sabahattin','Ali')

Insert into Books
Values ('Martin Eden',464,3),
('Kurk Mantolu Madonna',177,4),
('Sefiller',1232,1),
('Ilahi Koomediya',798,2)

Create view Get_Info
AS
Select Books.Id,Books.Name,Books.PageCount ,Authors.Name +' '+ Authors.Surname  as[Author FullName] from Books 
join Authors
on Books.AuthorId =Authors.Id 

Select * from Get_Info 

Create procedure Get_Info_with_Name
@Name nvarchar(50)
As
Select Books.Id,Books.Name,Books.PageCount ,Authors.Name +' '+ Authors.Surname  as[Author FullName] from Books 
join Authors
on Books .AuthorId =Authors.Id
where Authors.Name=@Name
drop procedure Get_Info_with_Name 

Exec Get_Info_with_Name  @Name='Viktor'


Create procedure Insert_Author 
@Name nvarchar(50),
@SurName nvarchar(50)
As
Declare @AuthorsId int
Select @AuthorsId =MAX (AuthorId)+1 from Books
Insert into Authors 
Values(@Name,@SurName )

Exec Insert_Author @Name='Sema',@SurName='Ismayilzade'

Create procedure Update_Author
@AuthorId int,
@Name nvarchar(50),
@SurName nvarchar(50)
AS

Update Authors 
Set Authors.Name=@Name ,Authors.Surname =@SurName 
where Authors.Id=@AuthorId 

Exec Update_Author @AuthorId=5,@Name=Ames,@SurName =Edazliyamsi

Create procedure Delete_Author
@AuthorId int
As
Delete from Authors
where Authors.Id=@AuthorId 

Exec Delete_Author @AuthorId=5


Create view Get_Info_About_Authors
As
Select Authors.Id , Authors.Name +' '+Authors.Surname as[Authors FullName],
Count(Books.Id) as [BooksCount],Max(Books.PageCount ) as [MaxPageCount] from Authors
join Books
on Authors.Id=Books.AuthorId 
Group By
Authors .Id ,Authors .Name ,Authors .Surname 

select * from Get_Info_About_Authors 