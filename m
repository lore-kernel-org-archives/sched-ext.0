Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010056.outbound.protection.outlook.com [52.101.193.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD472264A3
	for <sched-ext@lists.linux.dev>; Mon, 29 Dec 2025 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767028635; cv=fail; b=cVXJjqCQba+6LdqxB1dIA52qEk9Qx6my7VsNY5PfGfsZ1V1gzVuPKmfqauCRKwYxvJTuG8cfdT+1mZMzycPVnm1W58ah188X41gecRAatjFlS24audd5mB2dNfXWIBH6Tb9KcIN5kTRrUM6ADS6IL0/EsTh2ISqz1Uy/eJIQJDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767028635; c=relaxed/simple;
	bh=SNREE2qQHrh5mFHi3LhZzwWKoaGan6xrM29LjN/oXYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hrBSB5HqOEMoKwkfZLnIQalukcE6l2F+soOGPIyHUGNjRaHLDw/6Su+WLxoyGrVvkP57mD1OhBAN3KpmCJun1/ewGGDfofRcGPEo5yBUFDlqgu6by3wlx3vXLfXA/LDZ9pMCjYdB2sBmcjUwMpsP0hIsx1uct8C/bxXK2qAmWgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gqm9yv4P; arc=fail smtp.client-ip=52.101.193.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gqm9yv4P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhcF0QljvN8PFrMF5+q+xzM6DRJj2fGJFO5PHY4GdnjNIsjMacMxynzxalYVAs2UnUOO0HXrztGUddp+iLEj8IcyzH2qdvDQUhIOc//JOWqb0HzgSVRKk7ziVBZX+luBKKu4O6UC5aHM8OInTtmudxpTDSg+dMDrz4T65D7ynobh9EIaR4+HQyO55xaQENDubJP4bG7IUYzjhCyYDmC1VQJFUN2VtxmZEOgLanddKLqELQwbkSqgAKjO+u6Uokv2/9hm3Mrdh4na7o9OzuyxxRHC5LffWH9IF7Hx6rhO2x9h0bR0uilYix7r0vq21TGgwHSbiQEbLunKejDjsvPBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvXR3/2xP0BO3Gv3FXpvs/RIsd9YNUIdWn1a9qVl9Rg=;
 b=JF7t1QJcwyUXOmcDnjvRC16IKU/DCWVcAtvPTAHvIBpRQc0tBXZlEyC/r5HlZVjeXTXDI8fr8WwJIUcPNFgAftbx7GvB+c6MWQVSDaIHJo8/eE4YnxGJMom2GPyMUqpSXxawSpjDX642oQQBs0mYApfDKUtZ7zBCKdLw/QmZglcU2uHhm2XbXoY9On+AmCdZrx2dnd9ernS/Bh36ij2366x0Wac4QACdlmMFLz4/PBxGZTXCSPFXueFcWmuwf7zzvI31Xed1yXHEUlSXW8LqrVykRmbNqA5K49Sn/Jh5kdMNwPTqJ++MvJiHFS0TbMVhcnKfhTJTpHfoD4vJGkyg0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvXR3/2xP0BO3Gv3FXpvs/RIsd9YNUIdWn1a9qVl9Rg=;
 b=Gqm9yv4Pmnmdfc8hN6YRqRuyED9vR9DJg0IwHuMvTGMBiRY5UXssry8oQA5h8PkylJ6DzrQV/YOiLD+Tn+3KsUW0IZl+fJFcdfmoCO5SmsUpjvlXbblPGdh5wSbJc/Je7w7okwsWkO/oskxUs+0Eudjm3eTA9GaLI76WBAFAiCc+FZH9zmzBYxhAMerquT7oFfgC5vBdjRaJkH0Z99/9vw4akU45bqVOqF5q6A9VzSvakJZU1ojo5YCw9CSzT6HKSMIg652UZmHTmi0aiYvfGzG7lYrw4o8Hk/2of/J5jiJarRrSUd/9TKpDiEy99zfQrsYfcXyPfcoUBVfNgIY+lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7851.namprd12.prod.outlook.com (2603:10b6:8:14a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 17:17:10 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 17:17:10 +0000
Date: Mon, 29 Dec 2025 18:17:08 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aVK3lEn-x6EA86Qo@gpd4>
References: <20251219224450.2537941-1-arighi@nvidia.com>
 <20251219224450.2537941-2-arighi@nvidia.com>
 <aVHAZNbIJLLBHEXY@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVHAZNbIJLLBHEXY@slm.duckdns.org>
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce64624-0ddd-4153-21b2-08de46fe1a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UJmtzcNL0N3bqqBgxGmUqH8TOR0BsM1CmQKWCtUYEMhOdCqYZrln/xcx4lVX?=
 =?us-ascii?Q?AbfLE4fclMSFEVUzkJ/0Z/Wxs7Ba679RLevZqUGmqyFTDrOdVLpH9oS50QyQ?=
 =?us-ascii?Q?mMIZ5cItgpOx2A8Tjpp9PKqJR4po+Eglh3QSCriMEUdtLYyyrBQw0RJLqaJw?=
 =?us-ascii?Q?0n1KYqWmnJ+IeqmwlDxPx6qtccziycyzh9iPzESg9PikSp6uU8m6IFJQQpf+?=
 =?us-ascii?Q?FIwkLDfBsSiiuZg/yXXxMMC0JbamBLukIKsLNCC+TUDae8HNBubB4iw6VwOH?=
 =?us-ascii?Q?uWNeu4/H+G9K6FVrEeCg3OTPD1YxUvFL+p8ONI4kWbwIPunaWJmFMLWdWztP?=
 =?us-ascii?Q?e3s3sN+yoRKYHHk3ZUBOYKaUmkhxn3Rx5pOEybrxL9paMdTRH/ggPQcJcsGo?=
 =?us-ascii?Q?5jFgRGO8yOB2JUAZBJBcQvMMm2ftVHsnAgkNaPo1VicELyhTJZYu4O0Zt3QT?=
 =?us-ascii?Q?sGEG/pptdo9qtgqlGWLyRSu/xmPLG5UoFfQhEUZ5Vsky2kdNp39BhXFV4jxS?=
 =?us-ascii?Q?gLtR0fTRAbiDR+y3sCvZ6XNtxfo/Dl/HDtppUgrTTP7rllzjGAJ2h2jTz36t?=
 =?us-ascii?Q?Nh4ufI+0NuswqFPqUOe7rCNdaylg8xowplBAhd085iG/PXbLNttkNPGh75ik?=
 =?us-ascii?Q?+HlaZRKhbj6EeNzPb6eJynVJTc7a8933gwZbJWxg/fcRhgEF6RADvIklPWR4?=
 =?us-ascii?Q?z+n1V6Vde/C5Q8hVUs1oL/sNZwNqwjVxDq3yTFHsPG5oFc4Ntn/7ZWJFQtEI?=
 =?us-ascii?Q?IsduxjxebQFyl2EQFsjYoVaq6FECBMjj8YIUYQS5+EsKfMgHPUEv94lUCL8D?=
 =?us-ascii?Q?1ZWQAQTDgVITx5n+xtShAvRFT+NmgBVRPQLpdh7VINVpmk9c9HKgNv7MQxL6?=
 =?us-ascii?Q?4EVIaXWwnMDCaYQks7MjC7Ax1AviK1yirkJXflmi9bI8ve8x0Sj3lp0rLVJl?=
 =?us-ascii?Q?fahwbp5I7lavIDz4zwW880BfxjmRD/U8v0j8WjhR4dEA6E2TZk0NIZlPImwD?=
 =?us-ascii?Q?3LBqoe/ko59vNxap2ahMdjwv5o/60JWHceCwaUQzHLds1kThnbAcoeEqDICi?=
 =?us-ascii?Q?8YO2mQAFTkjSm+nxrnW01qw0/7ve169x5yQlfDUmUwhJPAWJsDP7iQwkNt8S?=
 =?us-ascii?Q?CjkTdsZtLjLQl2RJuge0T1dexX44d/PBkf9wvywcimG5daMeGwi7KVCdyCoG?=
 =?us-ascii?Q?+sIVUGCjvWybFnerZhKn8aGwPhmpQu4jhCVp/1xF0d0XN3NLxCRRBpJT/IsZ?=
 =?us-ascii?Q?kFLb1qwDjFwl5A/GwszbohecRIW0luQTZ7I4S81SWKazjKnoPMLep5DkbiIJ?=
 =?us-ascii?Q?W9O/LuQtt7ejBMsoa8sxrenUOuDWiGK3GqLC1F63OzxSvAxWn8UyEiDTVkcA?=
 =?us-ascii?Q?LhgmGc3INe/JFYtLA5lVVoBqxFmWKXPzh5nAvItPm+Ta0jj9ydZsSx5N2lTp?=
 =?us-ascii?Q?2HpMUvpD8XygUTi3TJ0IRs6zYGBqa4ce?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IlWqG3FMNrrvwjmaePPosWasJN3qdYfC+T+6xjz4ZEEXg/mn7TGvXSNUdL65?=
 =?us-ascii?Q?KVTSEXjb/YZWcR4VaJvHb1r4PY38bOYoabVR52do1smdI6lODaVcZwVN+G58?=
 =?us-ascii?Q?NPSU10KqW6ioCWTawthZJ+RxdJb2lKBfNCkL7zZhjO0luPnyRp4zOBadBgJB?=
 =?us-ascii?Q?gfm8FGo4o5eAfMvMK4nMF3JmdpH2ahSYlUl3yBXJ1UkJlTR2JCa7jskGldVz?=
 =?us-ascii?Q?r/lSkAIsCM+VXvQLpMvtVOUEh1jMJk01yCbuGWcJS3Q+Tc4uJw/OTxP4jUEl?=
 =?us-ascii?Q?Ud/uC0TD9eYX49BUSbzwltejBPiD8SaIDjf3HE1ejUfbqoUPChtI6rLHLuR5?=
 =?us-ascii?Q?Ihs5Bm3AQlwMDWnX/4wOYFxuWrcwYlosEcpUOLOeXGQ24gY0DMNJ/wWLCKaH?=
 =?us-ascii?Q?oiJtJglmkbZxMI+Vv9ZI+u2sQU2RKspNjOLfdKuTV5jS9megxxtxE8VNkhAD?=
 =?us-ascii?Q?zqax4fcJIDXpOGMk5nulkXXlzmnQ/6tqfM1NfIYRn/aHkj2YeVYaZihJhQTi?=
 =?us-ascii?Q?kIsUUWxpqZc+A49v0GpdzCd7RGmu0w1/O+zAk+AS1n1sIQsZtNvt6yEAHCTP?=
 =?us-ascii?Q?XLpV/sL8p2R9JkT8RrWEfaCj8elycGbj7vBP7l6kOM6dDlrL6l4J+YTgXw06?=
 =?us-ascii?Q?g4eolY23nOjcwVZGGM3z9JramLfWeUsrWVTcx7NWfMhNzjSuO3p5s9e4+3XM?=
 =?us-ascii?Q?PtL7WhtdBiqWEzEpjRBJjs7BL2/MEaY8TdlTlrcFnDG+tGFAUUWkPP1EHHgr?=
 =?us-ascii?Q?OelNIRntwauLfAuAuBHXHykTHVhTOLgCr3pWy4KhDiPOe8ms/0zXkNjEjEx5?=
 =?us-ascii?Q?7h5EErJvw5ppxjeCKcnicNrSmwtVdqgn/pPDFYvQSKbdF7c7haE6OONhq0Qp?=
 =?us-ascii?Q?le+diX/NDvu0gJ++GNriKuLdUSpsaKVV2S/+K0Txm3fRD1VbMc0swpk1eW2h?=
 =?us-ascii?Q?XYKjF6s8LEOeA6KKT4TDSXKN3QWi90bxjekbnu9+ap7BehZCIvDNGf8MycQk?=
 =?us-ascii?Q?JEeYgdNUnendDHEQF2Ap1wnaI52AKzLZMN7YfHp8S03bw0g25yyZ+YwGsTh3?=
 =?us-ascii?Q?IKflBr1DmSlVqrdycW+6wD8dq4XSchy74r55lUB1NLzWBZDVahMHcT5XvcDC?=
 =?us-ascii?Q?BN9+DhlFk0GOneD5BwH/+zrcCbsMFAgIhH/n6GAyI/qkNSKvyUB6ehNem4g6?=
 =?us-ascii?Q?2mo/O1KwgeKv3A204CSrRbtvpXvvB+YSWlXvfQrfRmoURW2M74B4DkFmROXL?=
 =?us-ascii?Q?zbd09bL3NnzHbrpaggLFtHzxBM8MLERO6az+akw/Gy/SOt0El801/B+JN7Qy?=
 =?us-ascii?Q?Wi/wi8+by2s6b26lF6VEMPjrVtOAJB2/Oqb72KN4p5FxjmnRiyoA+SbFALpi?=
 =?us-ascii?Q?aL+qBM3v6tQJqnM3kN3iBi0taJS1hMv79lsfaHoG3IGLI7v5y6LckFx3gu4m?=
 =?us-ascii?Q?F2aqfNO36JsW8t2DEHX0q6GFQn2Ps/nbYNTIML2AGupfb2FM10KlW6obcWaW?=
 =?us-ascii?Q?EDt6VHEVGZujZRTfdF5z1a0QWRTk7PAHncAb93tExtunh2KsySVLYcpSz/Q3?=
 =?us-ascii?Q?pDWvCJxBs9a22D6r+sdmO2+xZUp09vsnnB3qJ5e+pZtwe+in1fewLYJvIAq+?=
 =?us-ascii?Q?rnAVDc7bOXCwsByjXxmfX0krmyeYtHYxQTOisJU/JWTR8CJqjaBRyClJI415?=
 =?us-ascii?Q?EdiKpJeGTpo+A1MBzmeBoTCDqQnsU8bEsu+Kr4CcrtOpOChScgMT+cixCbFF?=
 =?us-ascii?Q?2IaWwJ1t3Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce64624-0ddd-4153-21b2-08de46fe1a1c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 17:17:10.8136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hX4+ooq6j+VGTbaXQ+Eq9fv4asOSpecEBLg5W8tSpxSrPMfP5rJLpPDIE0bzx8TLDfdpJ4sRccZWxFVYskZwdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7851

Hi,

On Sun, Dec 28, 2025 at 01:42:28PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Dec 19, 2025 at 11:43:14PM +0100, Andrea Righi wrote:
> > +   Once ``ops.enqueue()`` is called, the task is considered "enqueued" and
> > +   is owned by the BPF scheduler. Ownership is retained until the task is
> 
> Can we avoid using "ownership" for this? From user's POV, this is fine but
> kernel side internally uses the word for different purposes - e.g. we say
> the BPF side owns the task if the task's SCX_OPSS_QUEUED is set (ie. it's on
> BPF data structure, not on a DSQ). Here, the ownership encompasses both
> kernel-side and BPF-side queueing, so the term becomes rather confusing.
> Maybe we can stick with "queued" or "enqueued"?

Agreed. I can't find a better term to describe this phase of the lifecycle,
where ops.enqueue() has been called and the task remains in that state
until the corresponding ops.dequeue() occurs (either due to a "dispatch"
dequeue or "real" dequeue).

So maybe we should stick with "enqueued" and clarify exactly what this
state means.

Thanks,
-Andrea
