Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6F33ACF0F
	for <sched-ext@lists.linux.dev>; Mon, 12 Oct 2026 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840992; cv=fail; b=ENfvT9YmsqlI5fyWezmlT89Xn3HZp3wOUjo7y84sRngzmIanwcw7GDkw4jcs2uSXxivNfOA+JsnX3j41iujzw2NOH0DJq9+TDLf6tXg1dCT/FcOqszNXkKJWmqGPHK4KTpqPb/ZN14O6p+c2NdAnjgaDZynmVr2/UzPJYL+TqzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840992; c=relaxed/simple;
	bh=Zah1ehE+PnzllGn+cxu6tkadZoZhzCuQmw5A4cKEhpM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GIASdcoW5VIYLC1oq4MKuFoK8BdJ9NOxiRarP0Qcr1PVTnaaik4STZ7Lc1j8CMwYFLFCKB4uUayfwug3U0zuaiiVaKfjCEq/ILLIyGt7JidtQsuzVuUqxZ6TtNnWyd57wtRhW+chh+GKTisahx7wrqSgd5YKfoRThmaW5tG70mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UUuNGeIw; arc=fail smtp.client-ip=52.101.46.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UUuNGeIw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEsMtVALwNpDFvS0zUHp0GX4AXn6lc+orB0vLWqgHWnAV3KCCobafwza3gsmJOqk4bSYVfWZ/QINjDjTTHC7DjpeTHnBjvIQ8dXoGmzeFntSl0PvtK4fuRGXF1LZwXg+NJ9Z7Uwis84KKQgaNPGYwTbX3VUFPuFQ4KF0k+iBysSPba5gTuPIxCgHLZ4W4AYj5xR+hYuvYZbg1rwY5c9CyjWmnXqajFOAEKrSAxiFgZHQoB3n77XysoMX6daaQdNQYhDxvYwAJ2aBHt3E8+4mY+YuJ83wIID9XI8x4IHagj21n5vB3gst9FkFh418u1u+Temuk2DuBtfjM1gsUnPT4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zah1ehE+PnzllGn+cxu6tkadZoZhzCuQmw5A4cKEhpM=;
 b=e4PRuhiIchQ7oLAqKUKEffNhAMVCprRg1S/F0b+n5pDw8BmBB5re8D8nCA3NmuHSr2aB/qA9OWOwvnkroUNB/PEURXM2e2CQnhQlKlJaYRKtX3GAx+HtP3Y5qV7/Mzdul3N1dLOv0VYPlEanCM/ALOTLPEjOJfbEk0ZTMaPPfvqAhn+8s4IJpUt5N9iaZYFyGr8SukpNBnqHqLiR/zxRTDa74b0XsFXnL1zaog068Br6hjAqLRZ38SqBZUvQ1TRNXASZa4unLDCG4ysgpNbHv6l7myXip3jLqoYDeGbaSayNmNtIBVWFx2h3wgjVf6GTu45pkbubnGuO8gY29WAmBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zah1ehE+PnzllGn+cxu6tkadZoZhzCuQmw5A4cKEhpM=;
 b=UUuNGeIwUaPPT7Oj11dXQhNm0uFpDx5NwAZ924h6N0omS6Y3LH28+NZjo9XXURLW2YS1qw1pyms8xSq/39taPz0c6dFnqYohpCUMnnFZ/g9FYyImXFDYQBeRJVAksal88wyv8ihCLjInHpADDVaTxX2dmSAdx+Eq4kbe/lvauh4ocQMF5DzOKvOEzKzKjP7mcrxr76IVJ5r1q8Xmlwe1NMpqzRoKywsKSed2JQm8tJ62Zrjm+JaY882yiHrJNKJiA3j5eaJJc7JiL55R5y3USpNK4gGFTNzbvNmJdgcUr2f+2P9nRMyB9DdjNpD2tkq6Jp12WN9pPZ1RfzyRU7hiJw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 21:35:51 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 21:35:51 +0000
Date: Mon, 12 Oct 2026 23:35:45 +0200
Message-ID: <998ed8ab4d1e0f869d8af35a327bf634@nvidia.com>
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, fangqiurong <fangqiurong@kylinos.cn>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.3-fixes] sched_ext: Wait for SCX_OPSS_DISPATCHING on DSQ consume and move paths
In-Reply-To: <20261012210749.2955291-1-jpiecuch@google.com>
References: <20261012210749.2955291-1-jpiecuch@google.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: ZR2P278CA0021.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::17) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 61fe2268-8fb8-4347-d76d-08df28a8c9c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eMM+gI/ef9vaq+bxwo4gIRNw0B/+s7hViod/chQanAXRfwRC6B+Yfky1gBKRlY4YeYuzK0pH03xjyvr+sCmqMTRe4dTOWhDpQ1NVq9XMYxNMqnKPejdRqy/j6xWeLyddBEK+l4BHR8K+K2uDCn63qz71mZ7wQVpDubpO1bJ3bKzLQrA9HExz4TSfk3YXOd3gNxPKL4JRVZB0rAiGMS82NtyDxyedrU0NhQO6Vd9KxLG3u3u6khaq1TWQarVxibUNYrKXxXW0euk5LaAPatKkzCRyFAkwdq/Azx771A9PJs1krfyzREIg7dW3zuFo7QlXTfI8KF1KpRelQgdQMt7jHyaPJcgonC+oxXn7xeo/YImRPxtV+SKVZvzCgUl3vtTB/KKTM2nRTS1owY3zXHPuy6Gc7HYTa4DQvsDNeAwGgPbfZgIjT0SjowOk/15raB7eP8ggBctUvXz0YKSJKZXeZ/2MvbmqFFQjJEfqzVrXw0NeFScbNpbSxbKZoGjFg9K7WuzcVnyf8ZSmSPLNg8CAxjMCDeew585lfVKw9XG45434LCzri4TQu5L1iaYZ5W21n1LalaqvmMXfAxSAt/CoMK8U+HzrwfSaZdRK3mi99H8b0zEOl0svdWWbpyPEVwUhoL8DUzFANh3hTJgQw2DGmn0W9pHJJfKZ3qbrSqyg50w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFlhZFYzVHMxZnVXMG5xRjM5WEdMK0YzcmlrckVIWTFRQ0ZqYUxpcGY3M1Ni?=
 =?utf-8?B?dUtXWmkyRG5VQVdwbVNJMXpYbnU5OXlxM25JdzYyYkxKMG9xc0hFMjVaNWFq?=
 =?utf-8?B?c3JhN1c5M2g3SEg0bHloMWlWaTZoWnVVNkJBTXhqdzN2SmxCdzgydlI0d0lw?=
 =?utf-8?B?R2hDRG5USCt3Y3daRmx1RzlXZVFlWDJxWU5EbTVKQUkwNlJIcXVVU2Fwc0dD?=
 =?utf-8?B?aytXZ2dIMC9WaFJIeFdTZVFVcFZMK1RHZHZHYzFsMnZvV2Z6dFVlWFAzb3NY?=
 =?utf-8?B?WEpmZ241MXdpNXNrOXNOQ1hRODFSZXVCUTFlZHdjMHR0QXlVeld6SHM0dVdT?=
 =?utf-8?B?bURwbDFrd3EvVmdPMlQ4U3lBSWthUlZBZjRUeFJDMzFuSTlrVUpJc045WDNa?=
 =?utf-8?B?UjN1WXpXK2tSdm9qNTIzOFhkZGRBZkQ1WEpud2Mzc2hWYWI1RmVQc3JlK25i?=
 =?utf-8?B?T0dOcDI4bmFocGpZWTF4Q0doRDlxNXRjc3d0MS9LcVpiaTIyRWJlc0pvY3h0?=
 =?utf-8?B?Y2RvUFp1ZHNjM1BoaENTdG9qbnMxTFZMZnkyOUtsbGQwRGZwbUEyS2RoR2p4?=
 =?utf-8?B?SEduOStmRCs0Z21reENmaW96OXpidWpMdHhWeXdnQm1CaXViaFFlVm1OTC9M?=
 =?utf-8?B?R2RzMmx0dlZXcWdvVlhKbmJod2NhUkVHY2I5RGFXK2RaQTBVaGlLZnJBYlJG?=
 =?utf-8?B?Sk91RUZ4a1pPbkFqaU9pZ3ZHNFRGZ1NlZE5xUUorRzN6SjBYTi9nMjdDMFZu?=
 =?utf-8?B?Z2JMMFR5RXFUYW9sSEVTb1QzNVBwVHIwNitZYWJSVTFxbGR1cjVMSzJCU2Iw?=
 =?utf-8?B?bEJuVmFacktzUGN2U2VtY2pDQ0tzVzRtZHJ1ZTJJVTlJcm5vUHhJTGVzR3ZZ?=
 =?utf-8?B?c3liZ1ZzcitLcXErcjJZT2txU000RlV2eFFJSmRweXZtbFVTdEF5bm5RZnJ2?=
 =?utf-8?B?SE9BS3ZHejhENGRMMXRqaUwzREJCelB5NG1DcGxqSWI5N3Z1dVR3c0h0TEw0?=
 =?utf-8?B?TUd2dnpBYnBqZW1NTGdTVmhHQm1LUGQzWlhOQVVDWG5mNG5ERnJ4SFd5T0FS?=
 =?utf-8?B?Qm1zMnFXc0N0QWFMZGFidjFPSGpvU3NHL25Nb1FLQUhPdm5OWGlHeUtXSi9R?=
 =?utf-8?B?SXZ4QXdwRE9kNWI4UWw2RXd0bkt5K0g1ODFqME9wVXREWUVMUThwSjc2TTNT?=
 =?utf-8?B?dmVVeGw5bEpNZWdrSU5nZ3pWcGVXSXJCeGc5WWFqWkJYMmdzOEgySDNSNTdF?=
 =?utf-8?B?K2VlaDJ4dEpDcmNGaXhiZGp0Y29pZGE0VUZIbUFoSCs2SW9QY2FKSW5TY1pM?=
 =?utf-8?B?SDRkV3d4aFlsNjk0TFBPam1YYmcxWWF1VDRHTDhTV01EbldybHBMcytKWktl?=
 =?utf-8?B?cUswa05KRUF3SXYrTVhsM29BYkNJQjA1WWdFSUhBV2tVZ0hSUFY0dkdTUTZM?=
 =?utf-8?B?UzJYQS9qa1M0MjdnazFReTUwVHFuQ1ZrSkVvR2JGMXN0emVYdVdkSlJUanly?=
 =?utf-8?B?eWxHRzNFd05zZjdwVWJ0eG5vUmRZVHVOQXFXVEFrRHlaOWlHUm1BWlMwMHZZ?=
 =?utf-8?B?MFNNbG13R2lRa3JDb3lqZisvZ2txZko3OGFFK1lJV0sya3R1N0gzeUR0anBn?=
 =?utf-8?B?SXdtbHRMUDd2TDlFejJBaEJhVXVUdDFBZzRzVS9TT0xtL0NGS2cyYjBiOWx5?=
 =?utf-8?B?aHNQR3M1TDFHMTY4RUdYb3BDUDZKNzNnd1QrR1J1MUJveVQzQnlSK0VnY0J1?=
 =?utf-8?B?MDB1MWpyb0dEYXBTOGxQMzA1TTFKdnptSituay9ENW53L1gxSGpXNGhWWkRF?=
 =?utf-8?B?ZjluaTVXZCtiOUV2ZTNEcnZVWURXbFd0VEFQZFhBOURNZnFqV1BQM3JHc2du?=
 =?utf-8?B?dmNsZTBnajhjSjkwWFozeTkyc0tXZ0dPUk5sMU5aZUYyZmtLNmhEZlNTNDdN?=
 =?utf-8?B?NTg3Y0R2TGdUMmcyamYyTFByUThFamFSbXNnNXpvK0RtOFFNL2NhaTZqV0o2?=
 =?utf-8?B?d3d3TE9JbmFlWDVYL1FsczJJSzcwREt6T0ZCRExMN001d3l1TzBCV3k5Kzkw?=
 =?utf-8?B?U2dVenBQZ2FkQXRmcjdzdXVqdjZ5ZGJWWDJlSHNLVHJDbTFWb0NHKzkxQWVu?=
 =?utf-8?B?K090QlRZUFA0RXF6ejh2N3NnR0dJMndzelRzQVlEY0FXb3Fxc0xSQzZhTno5?=
 =?utf-8?B?Qmt0T0V5RDZ3S3VJSjdzNWJHVUsxY1VMN3hqTWVXL3FYWjIvSHpRT2o4eVNS?=
 =?utf-8?B?WkoxRzVSSkVuMWR2VVJ2Nlc3bEhUQjF1cDBBQlg0NVRXMjBuMjIvRHdiWGJh?=
 =?utf-8?Q?/yxUdIa+PLw6l4cPkN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fe2268-8fb8-4347-d76d-08df28a8c9c7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 21:35:51.6190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jO/lch/Th85PreQVK67nrYFVACCoKjbwNIfVA32QAE5gLZKgcHXCACMMHwFkhipAX+m2SVj+t7XBYAvsS5cORw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594

On Mon, Oct 12, 2026 at 09:07:44PM +0000, Kuba Piecuch wrote:
> The DSQ consume and move paths still don't wait:

Thanks Kuba. The race is real, and the new waits cover the affected
consume and move paths. I don't see any regressions from this series.

For both patches:

Reviewed-by: Andrea Righi <arighi@nvidia.com>
