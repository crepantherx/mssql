CREATE NONCLUSTERED INDEX IX_ProductVendor_VendorID   
    ON Purchasing.ProductVendor (BusinessEntityID);   

GO;

DROP INDEX IX_ProductVendor_VendorID 
ON Purchasing.ProductVendor 

