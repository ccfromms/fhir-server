﻿CREATE TABLE dbo.QuantitySearchParam
(
    ResourceTypeId smallint NOT NULL,
    ResourceSurrogateId bigint NOT NULL,
    SearchParamId smallint NOT NULL,
    SystemId int NOT NULL CONSTRAINT DF_QuantitySearchParam_SystemId DEFAULT 0,
    QuantityCodeId int NOT NULL CONSTRAINT DF_QuantitySearchParam_QuantityCodeId DEFAULT 0,
    SingleValue decimal(18,6) NULL,
    LowValue decimal(18,6) NOT NULL,
    HighValue decimal(18,6) NOT NULL,
    IsHistory bit NOT NULL,
    CONSTRAINT PK_QuantitySearchParam PRIMARY KEY NONCLUSTERED(ResourceTypeId, ResourceSurrogateId, SearchParamId, QuantityCodeId, HighValue, LowValue)
	WITH (DATA_COMPRESSION = PAGE) ON PartitionScheme_ResourceTypeId(ResourceTypeId)
)

ALTER TABLE dbo.QuantitySearchParam SET ( LOCK_ESCALATION = AUTO )

CREATE CLUSTERED INDEX IXC_QuantitySearchParam
ON dbo.QuantitySearchParam
(
    ResourceTypeId,
    ResourceSurrogateId,
    SearchParamId
)
ON PartitionScheme_ResourceTypeId(ResourceTypeId)

CREATE NONCLUSTERED INDEX IX_QuantitySearchParam_SearchParamId_QuantityCodeId_SingleValue
ON dbo.QuantitySearchParam
(
    ResourceTypeId,
    SearchParamId,
    QuantityCodeId,
    SingleValue,
    ResourceSurrogateId
)
INCLUDE
(
    SystemId
)
WHERE IsHistory = 0 AND SingleValue IS NOT NULL
ON PartitionScheme_ResourceTypeId(ResourceTypeId)

CREATE NONCLUSTERED INDEX IX_QuantitySearchParam_SearchParamId_QuantityCodeId_LowValue_HighValue
ON dbo.QuantitySearchParam
(
    ResourceTypeId,
    SearchParamId,
    QuantityCodeId,
    LowValue,
    HighValue,
    ResourceSurrogateId
)
INCLUDE
(
    SystemId
)
WHERE IsHistory = 0
ON PartitionScheme_ResourceTypeId(ResourceTypeId)

CREATE NONCLUSTERED INDEX IX_QuantitySearchParam_SearchParamId_QuantityCodeId_HighValue_LowValue
ON dbo.QuantitySearchParam
(
    ResourceTypeId,
    SearchParamId,
    QuantityCodeId,
    HighValue,
    LowValue,
    ResourceSurrogateId
)
INCLUDE
(
    SystemId
)
WHERE IsHistory = 0
ON PartitionScheme_ResourceTypeId(ResourceTypeId)
