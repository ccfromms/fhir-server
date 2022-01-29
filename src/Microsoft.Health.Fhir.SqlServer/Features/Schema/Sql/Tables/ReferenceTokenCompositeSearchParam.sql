﻿CREATE TABLE dbo.ReferenceTokenCompositeSearchParam
(
    ResourceTypeId smallint NOT NULL,
    ResourceSurrogateId bigint NOT NULL,
    SearchParamId smallint NOT NULL,
    BaseUri1 varchar(128) COLLATE Latin1_General_100_CS_AS NOT NULL CONSTRAINT DF_ReferenceTokenCompositeSearchParam_BaseUri1 DEFAULT '',   
    ReferenceResourceTypeId1 smallint NOT NULL CONSTRAINT DF_ReferenceTokenCompositeSearchParam_ReferenceResourceTypeId1 DEFAULT 0,
    ReferenceResourceId1 varchar(64) COLLATE Latin1_General_100_CS_AS NOT NULL,
    ReferenceResourceVersion1 int NULL,
    SystemId2 int NOT NULL CONSTRAINT DF_ReferenceTokenCompositeSearchParam_SystemId2 DEFAULT 0,
    Code2 varchar(128) COLLATE Latin1_General_100_CS_AS NOT NULL,
    IsHistory bit NOT NULL,
    CONSTRAINT PK_ReferenceTokenCompositeSearchParam PRIMARY KEY NONCLUSTERED (ResourceTypeId, ResourceSurrogateId, SearchParamId, BaseUri1, ReferenceResourceTypeId1, ReferenceResourceId1, SystemId2, Code2)
    WITH (DATA_COMPRESSION = PAGE) ON PartitionScheme_ResourceTypeId(ResourceTypeId)
)

ALTER TABLE dbo.ReferenceTokenCompositeSearchParam SET ( LOCK_ESCALATION = AUTO )

CREATE CLUSTERED INDEX IXC_ReferenceTokenCompositeSearchParam
ON dbo.ReferenceTokenCompositeSearchParam
(
    ResourceTypeId,
    ResourceSurrogateId,
    SearchParamId
)
WITH (DATA_COMPRESSION = PAGE)
ON PartitionScheme_ResourceTypeId(ResourceTypeId)

CREATE NONCLUSTERED INDEX IX_ReferenceTokenCompositeSearchParam_ReferenceResourceId1_Code2
ON dbo.ReferenceTokenCompositeSearchParam
(
    ResourceTypeId,
    SearchParamId,
    ReferenceResourceId1,
    Code2,
    ResourceSurrogateId
)
INCLUDE
(
    ReferenceResourceTypeId1,
    BaseUri1,
    SystemId2
)
WHERE IsHistory = 0
WITH (DATA_COMPRESSION = PAGE)
ON PartitionScheme_ResourceTypeId(ResourceTypeId)
