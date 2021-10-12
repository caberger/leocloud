UPDATE hibernate_sequence set next_val = 1000;

INSERT INTO School(id, name, street) values
    (1, 'HTL-Leonding', 'Limesstrasse 8-12'),
    (2, 'HTL-Perg', 'Machlandstr. 48');
INSERT INTO Course(id, name, school_id) values(1, '4BHIF', 1);

INSERT INTO Person(id, LastName, FirstName, MatNr, course_id) values
    (1, 'Doe', 'John', '1234', 1),
    (2, 'Roe', 'Jane', '5678', 1),
    (3, 'Sixpack', 'Joe', '9012', 1);

insert into db.Bill(bill_id, number) values (1, 'R0123435');
insert into db.Line(bill_id, row_id, amount) values (1, 1, 60);