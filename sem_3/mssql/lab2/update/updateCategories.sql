select * from Categories where UserID = 4;

-- update the category name
update Categories
set
    CategoryName = 'Social Media'
where
    UserID = 4 and CategoryID = 1;

select * from Categories where UserID = 4;
