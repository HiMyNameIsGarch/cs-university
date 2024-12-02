use passman; 
go

-- before 
select * from Tags where UserID = 5;


-- Insert this to delete after
INSERT INTO Tags (UserID, TagName)
VALUES
(5, 'custom password');

-- after insert
select * from Tags where UserID = 5;

-- delete the tag
delete from Tags
where UserID = 5 and TagName like '%custom%';

-- after
select * from Tags where UserID = 5;
