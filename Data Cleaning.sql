--Cleaning Dta in SQL Querie

SELECT *
FROM [Portfolio Project].dbo.[Nashville Housing]


-- Standardize Date Format

SELECT SaleDateConverted, CONVERT(Date, Saledate)
FROM [Portfolio Project].dbo.[Nashville Housing]

UPDATE [Portfolio Project].dbo.[Nashville Housing]
Set Saledate = CONVERT(Date, Saledate)

ALTER Table [Portfolio Project].dbo.[Nashville Housing]
ADD SaleDateConverted Date;

UPDATE [Portfolio Project].dbo.[Nashville Housing]
Set SaleDateConverted = CONVERT(Date, Saledate)


--Populate the proprty address data

SELECT *
FROM [Portfolio Project].dbo.[Nashville Housing]
--where PropertyAddress is null
order by ParcelID


SELECT a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM [Portfolio Project].dbo.[Nashville Housing] a
JOIN [Portfolio Project].dbo.[Nashville Housing] b
		on a.ParcelID = b.ParcelID
		AND a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

UPDATE a
set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM [Portfolio Project].dbo.[Nashville Housing] a
JOIN [Portfolio Project].dbo.[Nashville Housing] b
		on a.ParcelID = b.ParcelID
		AND a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


--Breaking out address into individual columns(Address,City,State)

SELECT PropertyAddress
FROM [Portfolio Project].dbo.[Nashville Housing]

SELECT 
SUBSTRING(PropertyAddress,1, CHARINDEX(',',PropertyAddress) -1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress)) as Address
FROM [Portfolio Project].dbo.[Nashville Housing]

ALTER Table [Portfolio Project].dbo.[Nashville Housing]
ADD PropertySplitAddress Nvarchar(255);

UPDATE [Portfolio Project].dbo.[Nashville Housing]
Set PropertySplitAddress = SUBSTRING(PropertyAddress,1, CHARINDEX(',',PropertyAddress) -1)

ALTER Table [Portfolio Project].dbo.[Nashville Housing]
ADD PropertySplitCity Nvarchar(255);

UPDATE [Portfolio Project].dbo.[Nashville Housing]
Set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress))

SELECT *
FROM [Portfolio Project].dbo.[Nashville Housing]

SELECT OwnerAddress
FROM [Portfolio Project].dbo.[Nashville Housing]

SELECT 
PARSENAME(REPLACE(OwnerAddress,',','.'),3),
PARSENAME(REPLACE(OwnerAddress,',','.'),2),
PARSENAME(REPLACE(OwnerAddress,',','.'),1)
FROM [Portfolio Project].dbo.[Nashville Housing]



ALTER Table [Portfolio Project].dbo.[Nashville Housing]
ADD OwnerSplitAddress Nvarchar(255);

UPDATE [Portfolio Project].dbo.[Nashville Housing]
Set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

ALTER Table [Portfolio Project].dbo.[Nashville Housing]
ADD OwnerSplitCity Nvarchar(255);

UPDATE [Portfolio Project].dbo.[Nashville Housing]
Set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

ALTER Table [Portfolio Project].dbo.[Nashville Housing]
ADD OwnerSplitState Nvarchar(255);

UPDATE [Portfolio Project].dbo.[Nashville Housing]
Set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'),1)

SELECT *
FROM [Portfolio Project].dbo.[Nashville Housing]


-- Replace Y and N to Yes and No in 'Sold as Vacant' field

Select Distinct(SoldAsVacant), COUNT(SoldAsVacant)
FROM [Portfolio Project].dbo.[Nashville Housing]
Group by SoldAsVacant
order by 2


Select SoldAsVacant,
CASE when SoldAsVacant = 'Y' THEN 'Yes'
     when SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END
FROM [Portfolio Project].dbo.[Nashville Housing]


UPDATE [Portfolio Project].dbo.[Nashville Housing]
SET SoldAsVacant = CASE when SoldAsVacant = 'Y' THEN 'Yes'
     when SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END



--Remove Duplicates


WITH RowNumCTE As(
Select *,
        ROW_NUMBER() over (
		PARTITION BY ParcelID,
		             PropertyAddress,
					 SalePrice,
					 SaleDate,
					 LegalReference
					 ORDER BY 
					       UniqueID
						   ) row_num
FROM [Portfolio Project].dbo.[Nashville Housing]
)
DELETE
From RowNumCTE
where row_num >1
--Order by PropertyAddress

--Drop Unused columns

Select *
FROM [Portfolio Project].dbo.[Nashville Housing]

ALTER TABLE [Portfolio Project].dbo.[Nashville Housing]
Drop column OwnerAddress, Taxdistrict, PropertyAddress

ALTER TABLE [Portfolio Project].dbo.[Nashville Housing]
Drop column SaleDate