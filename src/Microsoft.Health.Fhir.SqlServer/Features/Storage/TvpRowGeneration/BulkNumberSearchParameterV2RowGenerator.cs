﻿// -------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License (MIT). See LICENSE in the repo root for license information.
// -------------------------------------------------------------------------------------------------

using Microsoft.Health.Fhir.Core.Features.Search.SearchValues;
using Microsoft.Health.Fhir.SqlServer.Features.Schema.Model;

namespace Microsoft.Health.Fhir.SqlServer.Features.Storage.TvpRowGeneration
{
    internal class BulkNumberSearchParameterV2RowGenerator : BulkSearchParameterRowGenerator<NumberSearchValue, BulkNumberSearchParamTableTypeV2Row>
    {
        public BulkNumberSearchParameterV2RowGenerator(SqlServerFhirModel model, SearchParameterToSearchValueTypeMap searchParameterTypeMap)
            : base(model, searchParameterTypeMap)
        {
        }

        internal override bool TryGenerateRow(int offset, short searchParamId, NumberSearchValue searchValue, out BulkNumberSearchParamTableTypeV2Row row)
        {
            var singleValue = searchValue.Low == searchValue.High ? searchValue.Low : null;

            row = new BulkNumberSearchParamTableTypeV2Row(
                offset,
                searchParamId,
                singleValue.HasValue ? singleValue : null,
                (decimal)(singleValue.HasValue ? singleValue : searchValue.Low ?? VLatest.NumberSearchParam.LowValue.MinValue),
                (decimal)(singleValue.HasValue ? singleValue : searchValue.High ?? VLatest.NumberSearchParam.HighValue.MaxValue));

            return true;
        }
    }
}
