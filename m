Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011010.outbound.protection.outlook.com [40.93.194.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE0E272E5A
	for <sched-ext@lists.linux.dev>; Tue, 23 Sep 2025 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758653167; cv=fail; b=fo+mpt+XRuUIlSLvNTgHhf4XZ5Q5X4ARzy45suZTznKq3XIdHPNY7n38ci9/klih7q3x4Aeic7F+KjgBCxoPRomdh/p+b5p4dwUqsauyKrqQ7q0HTrRF4Xwr4HXbeNz8njHSxzZdjp8e+3ymIgOxZ7UI1uCr6dvGFvtsjFJCUPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758653167; c=relaxed/simple;
	bh=Rz/aeBIiBFDW888Z/GkZuotNZ9aRY47ldRgvUf9kRrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ki1LGEnUHXucXBMDFWU9pwy0rEZEGnJvGMcQjAuHVXy6QXKzRkj0D+BN+nQkOUItTg/N+EtmcjM1QTlkoBNlDlS+Yqwi/2gcpHYj4HR0KLSnOmbH5//zjDUUvee1uh8HrPpBJy4uDLD+WZldY1lKRejzpTxTesBGEYF+y5mfftk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QofJlYlM; arc=fail smtp.client-ip=40.93.194.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QofJlYlM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkylM8UlO/QQkx+afxWz0C13Ofb4hVzk0CXMYFXIp8I3bkVdV+4iGkHt6rpcGq6UhPkdW44LIyjZUxfxY49f0xNu//JWu6Lb/kTh2aZaU7hRpBoTDRBMRcla01KsCjFenIYBZzFcMHlKgLTaUj5J5InNJumEAOw0YqJ8poDghmeepQiOcuBCcW2TWKLV692KkZScXwdcTgebMs/hIpibL6milOOQKBGcnifJilzYZq3IYvvPfLZU8yqmouTZLrdGTFtH1AGwgXMZDF3EDgi+JxGMqNo5yE3vrAv5nljCJLfTadmlWSfrTuX2TfeylZOPUnkevTfRXioRZJbeXiQSBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=381lXs8w/iQtErAaHQX+sID5IUCgyWaWqK0izhIdVQA=;
 b=ORshdSJc7oL0tzUVeoDVffflfhS+H9F1rZ55GhsJnA5w8p3twu0PRgk4MT5LAmwm2BVoACJ8aSzDHJaIcTjQgPmpyLpDP1nPWnjpgpthKLnECsaaKlVyVSk4imhzu+RCtvLqHkl/d+jrPMzDyFm7KO2By3dlWdM2N7oSUKu5nyAI2zFwkD8qBxfP+2OfRS9aT1dQLd5oc9QlJoE9kSX7OIdFbta4IL6OWhlV4AtIQcxNTXX/GJ/6AY1v2eI2yD6ai78Cf1P5S4Txm5gl2qlBlsP4VpfLgRIk65eiJ0/1908K9z3G24G6D/OyD0EoaZa+Uhp//OlZ39MB8C6KCIH7lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=381lXs8w/iQtErAaHQX+sID5IUCgyWaWqK0izhIdVQA=;
 b=QofJlYlMNo8Xjc5KsnF61jRC5J8FI53Bj34GyLO312oeNq5/1EFQTk2KcEa3O9IlSNcmhJfHhDjq116Suy/5+0SYh+oxhFsNg1mvwBAdklRe45+PlIP3Fhrp5KSxPKgbIPyYbV0fnqntdE83gL+3KC5TkAoSzfEunL1G2CFH0Cw1hjH77QVIsSfMUrXT3wcin2/Kdr1N+mHW4ThfktyHDiC2iG9eydsq0XyLrnevpC/4Vjhu2RZQDkQTa8fHLXHUMPgr1+jEX5tADEY500cFWKoTaIfv4gUR8546QiX/LgEiVz37xOSus7ilyQBOOq23d1w2K8eoPMK3FdOdC51xNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.21; Tue, 23 Sep
 2025 18:45:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 18:45:56 +0000
Date: Tue, 23 Sep 2025 20:45:53 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 4/7] sched_ext: Use bitfields for boolean warning flags
Message-ID: <aNLq4VAjKtsaE6Kc@gpd4>
References: <20250922013246.275031-1-tj@kernel.org>
 <20250922013246.275031-4-tj@kernel.org>
 <aNLRnjsWRQt4WjRM@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNLRnjsWRQt4WjRM@slm.duckdns.org>
X-ClientProxiedBy: PA7P264CA0163.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36c::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 112c2a58-9302-4adb-42cb-08ddfad16e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yYsG0L/sO6VU6cg+b7IHR5Zy5ufEfl+ppJzNna/0DhbOPElotL0pDBv7rIow?=
 =?us-ascii?Q?NgvSg0vclUmhthu+cCZOBvAG+erisoe+a5PyLMm6ZnYheC/7xfye2CIcIJNk?=
 =?us-ascii?Q?cFxqLNpdzukOL/ZK8dkeM5KrEK2hAl9grvUiYKgMJLvQVQi4MkYDyIAB6BET?=
 =?us-ascii?Q?rkGNgZt2oZk4oMQQjxW4RwStOO1Amt3U0Id6UQQnxxtt9/SDB/GUvVIMeOSO?=
 =?us-ascii?Q?/SR3KWas/QFTs7TiqZSxxNOB+WXPqPm+vPT/P7ABKHaxH5HmK35m3JE6obNs?=
 =?us-ascii?Q?SFEtot54kE3CMDCrIbX/7Q0tTukPvuxfCYAKDv/E/OQGsZrLO4zwBKsNvQbs?=
 =?us-ascii?Q?50v4iVcfOp7F4/x4IXYvN+mZf0TN/sTQP6A41xLBY5azZfzmuYbaVIGA4EcW?=
 =?us-ascii?Q?gt+j7kBbZ1Kuv12jI7MdIdSak747yQBv1YF+gAoTg9iNQF0YDXjY7G3SlVf9?=
 =?us-ascii?Q?W2cEwsa9fNN4/iQAiXG4gALxM5xy3qPtscQEWscjsCp/4rB4zzFVUrwRYOxy?=
 =?us-ascii?Q?KwoXUMS9kTW1QhcNlcWQXTa5O/yj9o1tZNhrrMOwXacMYQr/V6QDEw6YU7HD?=
 =?us-ascii?Q?hAvWvy2kTgT92I+YvZ0e2nK3uFz8MlR5mDqWfU+DeFKSrEmA4LpE754Cgb19?=
 =?us-ascii?Q?RSy4B/klaPo8o+r3tJ8Z7xwVS21CM1Qzl08J3pFnnANWo73jV4givPFIxA6O?=
 =?us-ascii?Q?HIswgEVLH0s2NipJneUnaz3HY7iKoPPrsiQ4gOnwxIBsbfRiPt1W9EReWc14?=
 =?us-ascii?Q?6PT/Zdwgf/e7zS8QbdZmOncxCzcWZe7p+VVcGcuNilzBj1253KJLu8I1msPj?=
 =?us-ascii?Q?ul9iiBl3/blJOMODgXaqFDZEZi+i/Wz6ifjaiuoIAXlkQWN9hfcHsEmetJZF?=
 =?us-ascii?Q?Y1EJbsgBg9HvWquLKpQs7fLfAoiyV17CRUyfymn4h/rc1VuK1XZxt4KTkVun?=
 =?us-ascii?Q?Q2/3gQYVI7ZbEBvU/oU0FSiUoV2KfnoQ0q1b+xXvx7cCBDbmayDlyyIQADJz?=
 =?us-ascii?Q?O3KEwknAfwXE5QwbolVDqq7HrpwI8eKXAl80R25L1ls2q8/1UpbWiAavxvof?=
 =?us-ascii?Q?LoQHT6iWckpN8W+lvXE5ds/enbvPEDTzrX8rWkkjkQLv4VcRAeUNIfJTaZ9x?=
 =?us-ascii?Q?gnOYVsKXXWHwywOPfILRStvmiE8smTS8u9WGL8YWRxfQRxvgFNuRqJfEaxRL?=
 =?us-ascii?Q?J2XuHT7nfuFbtTz/sQ9LGpy5xO+0aA3OY4Cg2n2615/Skx0yavRw6xWMmgxO?=
 =?us-ascii?Q?QOnnOr5w+qZhyuiAMG6Zzn23qO9QUQ7X8E5npesv2QztbC2A+opFeO15m38/?=
 =?us-ascii?Q?mB0wgBCCpyZ88X48AKHi/wvcc8OdRxEKDRGLSLYBEqYU0B4sEKZdDKGpdcRS?=
 =?us-ascii?Q?ZHG6Fzb8qxH0/u2mB2LwMj+Lm3+dAyGZjgeq1M7gSwammdllYhRVU1OSvv+p?=
 =?us-ascii?Q?KhvD5pZDHI0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NQlRCYaKoEvgVlOZkpzj2Ki5jfPUZ6l2uULEFg0zJNcruekZm7r/fQY4SD0Z?=
 =?us-ascii?Q?XiFoomwAM5Ayib7j1gAQD77g6WXuXYOlY0eY8BcENQDc7ssmBmtivCLHqjG2?=
 =?us-ascii?Q?D0OM08Vm5fjto4CyufDYbhNLvDzxQCVHzpkTrZvdatLOV4Esq3rtdoBEjR8D?=
 =?us-ascii?Q?KrRGjIUHzxbxgjZhwp+SoQhiEGQbPXbZLE2EAScqLnBNfIPR7TrJnAJz9ck+?=
 =?us-ascii?Q?Srbjh4m8G+IL3u/FkeibFy4HBAn3mo2AY0HTQ6pN2uRNidwAS7wwzzHO/40/?=
 =?us-ascii?Q?20D/KecFwbOwGoG361Qn0Hk0lr81rIgxXxVz7Cy6mgtiXd8faGF/95tXlrdE?=
 =?us-ascii?Q?kq5edExWhlzwOwEg7n6dlA0oQzwg/xI4yphKtza6Q3MwtexHem165kFbOIAl?=
 =?us-ascii?Q?lTOBlVXmw9+WPNB/TBzsu08PvZVpF6yritkx7qvTffydpt9/SOKraKI3Tafq?=
 =?us-ascii?Q?qV/VT+lrXbrBpmXoKg5Hi2IgdULKDbazYYgJ+rc86fmzRNqaZKdqkuIkc2+g?=
 =?us-ascii?Q?GC/i/FS1TmvI2YKD9yiD7kYVtLSHrp1BTLTNqc9liIyqoRREW45sleH5L1DT?=
 =?us-ascii?Q?f6Qjz7cUTvCQVEPjSR7NoUTaqCNRCXx0c0ufpx6dpji+EJW2Rx1erCINWClJ?=
 =?us-ascii?Q?s2OeatxPQWxIMQxoNHMJN+LvR1y79on4V/WxVCHnEhBM9P3pkf7Edu2wiC2Y?=
 =?us-ascii?Q?lOEaMd6sOGS1Ap4Pt9fPl7gMaPZucBowstp7RdW1a1dWc2f/07owPMN3Dy5M?=
 =?us-ascii?Q?1n/M3iGFVRhZCH3dRI9Hby8CvO7IJpV+M3HH6sGeuFrAPCtqV+PdWHrDUQTV?=
 =?us-ascii?Q?zdwmhrkS7/d812dHP2b0szGUELxxp4hKUpL5kJCUCCpdfBuAzw3iwoywcToQ?=
 =?us-ascii?Q?bmwv6EEDXeTZsUQd2Hz1EZZV8mng6jV3M4r0DkjWxHFh6mzuWWlMaC/VlBrA?=
 =?us-ascii?Q?bUCh5fkLZDB/i6rhzXTi2Qtmp8eHCneWRdFccq308cucRMNZ65rFXW+bkg9R?=
 =?us-ascii?Q?UkQNJkfzpyKgucjgJeMmuEJwC5NAhz50wGGMz4fJTc80Y5/gPxLXjd2riffd?=
 =?us-ascii?Q?f0Fa3Od5lVbBNy2QR6ZBUnN7g7OCW2wuEqgOb5OwvfGoEiNfBEBbPB7o5OSI?=
 =?us-ascii?Q?trwkEXAO5RsVgtqhhb3ta6WsdLxUmPOW0v2+RyyRowemCIeIAr16sONyts8O?=
 =?us-ascii?Q?vaq4IygBchIc19zXAoMsYn2CnvDJcIqoaj9RqKHQeJGflNrBOB0jo66Nyiui?=
 =?us-ascii?Q?IlFR8KbEsV2FZClJTfQgjK27oysykPAHb/TwrdFuAk0+K7tAWQuQyXM1JoTj?=
 =?us-ascii?Q?j3OHbPvXXgw94MsUYkupr7JnoYbdRaVwUBLIMmOvBF4CHl/4X2/T2X17bPQd?=
 =?us-ascii?Q?WvefiT14JpN1tvmgSNjPRruZSE54s5G72xBDYYsfuZIPidTonTbDFeIi+aKi?=
 =?us-ascii?Q?cYfZ4X49ImscksQqE2KfEGS8ImkKv2s9MAkpHuG4iae4yioRGRJZ2VGO8fKM?=
 =?us-ascii?Q?qlCU+JsPKFHBHmVGAQvqY3u5lNL8aPPP8w62Wlja9KMk/Nqp173MFkM5B3V/?=
 =?us-ascii?Q?ZiQGmy7KMO4ZTkknsbQjEbsqDYFe30phr+0yvjWv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112c2a58-9302-4adb-42cb-08ddfad16e45
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 18:45:56.3193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkTqIkEv4ADRfcW38EDDafbP92ZmWJa0VKJJ9cLoxX/qQAuZfcRPEElfUw59rF1AUUJE2CVPZWOCynV4btyFKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632

On Tue, Sep 23, 2025 at 06:58:06AM -1000, Tejun Heo wrote:
> Convert warned_zero_slice and warned_deprecated_rq in scx_sched struct to
> single-bit bitfields. While this doesn't reduce struct size immediately,
> it prepares for future bitfield additions.
> 
> v2: Update patch description.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext_internal.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -871,8 +871,8 @@ struct scx_sched {
>  	struct scx_dispatch_q	**global_dsqs;
>  	struct scx_sched_pcpu __percpu *pcpu;
>  
> -	bool			warned_zero_slice;
> -	bool			warned_deprecated_rq;
> +	bool			warned_zero_slice:1;
> +	bool			warned_deprecated_rq:1;
>  
>  	atomic_t		exit_kind;
>  	struct scx_exit_info	*exit_info;
