Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012045.outbound.protection.outlook.com [40.107.200.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916F72DCF58
	for <sched-ext@lists.linux.dev>; Mon, 13 Oct 2025 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760386439; cv=fail; b=UwzqgjgnM7PcJlwQYdElEIyvFjVLIGpZRCEmnQSkrMNkaBXbGooMgc6UmY1CtKd50K20Z6HWbFshg+m+bfTmkSxmCISzzf2sCIT9fbdewfeZpkyOYikwBbIBIB35C/jfS5pjsvbLeLxe3pdHqeQah1gHr7+WrBNwGVNDsP8h1Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760386439; c=relaxed/simple;
	bh=6g2HAXGh33wTzYgXNO0HvkbiQDQQ4oJ8T1k88Y96bkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HNqUv3abK6YwYed1pDl6GoYWhsAqDWk5/PC/NrHc5GKWJNW2ghAc01YEv8rDEzx3FFjxLFxQR9s9eCDAeDtDfp8zaKNqFYTm4tKSbAwirUJHmpf+F7GhhHwCGGcLwHJXF1QDzZM6XbJakrbXH2AtNEnsXdaqLrFr7TsXroicelU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ew4P43LD; arc=fail smtp.client-ip=40.107.200.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ew4P43LD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0mv4OBa6R8CJoyqcfs8VHm3AFafYLqBMHRx6oTrURAVOpHskTms5w3Ro2fMiQZB0ynrZDCDjnpDaWLm1U3EfN6HuTVrn2NNI9EX7jfplR2hQmPHvJdtxZ3OqudNsx5W5P1P2DuOy+mSxnoQPXcJ2+Yzg3yaZKj5ZxDOoJjZP9vSyGygHk6M3+jx2eq0K5NxErltlNSSJP0nDouUIN3Zx/vU4AQ6Vu2AfHoHA2H0zRDccnht6j2fUHke24OGKxee4JU9hALpf1c3SO72odPmBg4TIEjQKPqNav9xLKqqNM+fDiFPKhs+Em3gcCYonhPacp1/nCcFvWMdsNdh6QCSkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNPAQpxgFKRF37LsOG5hbvnHf8EzWhQczTEiVEromn8=;
 b=ZBMegG+9+xF36MNeXRHfs4vhFtMvE43amrnqI+d89jWz6DbT3BjJqZJQVccw8/7NbQdbCY0PJaNFdzP1UhFziSD3X5i4qySBrjUGnJ50IPlOa6BXk1pjKQGR2y478SBCmx/nz5r9ez303vQRI65eAquvsf/USmXcHNEChc6DUUIqb4gEuWBttmsgw8L6Tod2D6PBnM9kPZInGogJTTMjLdPTidxp2gCcA7SJazJjtesMLopK8hPIN9woJtWgf61vMdmH5S7/CrMobsP6XwTX47VRJXH4KNNNmkG2rtj1TRUOVvH1LVrGMNQhIfbSAS4G2AvJI1zxQLGioKMFYrbkJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNPAQpxgFKRF37LsOG5hbvnHf8EzWhQczTEiVEromn8=;
 b=ew4P43LD9N+BMmhVdRCcsb5iUJY4ew7p1s+A0JV6vVxJZV+ePu7idou4AjMKkRzgU0bQR5N2Ql9DTDXrYoFShMmQbpv55AiQnxvy7sbQum6KKDtKZEB8usJa2gqVTlduqcSyTylyraWYfJjsQDkLFA9OnVHisQABh6mQEJKnmSfqzyCxNCKm6SuP/38lO2+ZSs7ld/pjQXje07PwoEUJrQfhd/5A+GCFah5ExhcUwUb/4m1sbpsZ6FgmCYsGnBjpeTCzVZ57Mm9L9S/fMSVGZ6WGse0w27IcIVzufS/Lt6Zs6AxvEozBfUk3E95imtBo0xenas5A4AScB8lfaLThiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV8PR12MB9665.namprd12.prod.outlook.com (2603:10b6:408:297::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Mon, 13 Oct
 2025 20:13:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 20:13:54 +0000
Date: Mon, 13 Oct 2025 22:13:46 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Phil Auld <pauld@redhat.com>, Emil Tsalapatis <emil@etsalapatis.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched_ext: Allocate scx_kick_cpus_pnt_seqs lazily
 using kvzalloc()
Message-ID: <aO1dempzw2uAWxrC@gpd4>
References: <aOb3Hv0uPv9G7N33@slm.duckdns.org>
 <27ed885043e6dc3e9c2feb2e9a247658@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27ed885043e6dc3e9c2feb2e9a247658@kernel.org>
X-ClientProxiedBy: MR1P264CA0050.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV8PR12MB9665:EE_
X-MS-Office365-Filtering-Correlation-Id: 44198617-05f0-4e05-5183-08de0a950878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qsy/bnE6V4deMfcOzJfBIMkH/3IQ0BsRAyKpXh/IY3bKAPOY0a6tNYLPkmR6?=
 =?us-ascii?Q?VQ88MKzOkPvic8kOvGEZmt5ivtHqYBctk3lKdzUwY6L9jrq0a5+ZhJfkBC6R?=
 =?us-ascii?Q?f3k0gatRBRMiHtORtf7Dd4C/wGwXEmakbyo4LJzPB5vCjlDP1BnuMNt18g1A?=
 =?us-ascii?Q?2K48fFastplAYUehqSpo+zwyDBc2GYuHZR+Lq0W5GiKrORj6yRj17vbJrUui?=
 =?us-ascii?Q?O++sU9kc56uMs0uAhtqSN9Os+bQk2cuGej8S2cVLQEiyWv9L6ZUcRRyXzxZQ?=
 =?us-ascii?Q?iw4yDTRPKkGFPayRgrLPCdtA9sqFmL/+noCaacJdo5qURegzptfN5hZZ6agE?=
 =?us-ascii?Q?OVAQI6VuMmaNpeSOftMG9nKpqZSf4wTdPp6Gu3kRmiLb8usaXmfok4TfrvHi?=
 =?us-ascii?Q?oBg/pjiITAhVrStx/5nJVFmY1jnjwrTVhnfS7KfluoYM3E11DDIEECtj8yyw?=
 =?us-ascii?Q?IMvOCpyrcxnUvITqJ9Kn/bQVkqXQyoh2wYYWbPtgy1qSRNIfjE1ipTAND6fg?=
 =?us-ascii?Q?qck4NbQ3r2Id+pr1+D08OT2RidY4IoO4z2vVJ/WBud6TWn/ibhtUDEmTeFV1?=
 =?us-ascii?Q?XHSOI9gzF6V/weOSAdrpmXv78O2P6gqKXXtFw6xykDvsI10041i8pdma5tXW?=
 =?us-ascii?Q?7FGWbQ04Sy8fvuHAkXkCtydOZCgCuXFZcJqgH3WtUgRebokpf9T31uX998Py?=
 =?us-ascii?Q?A1ZVst+3xlWKQpH6DxeFwznmxmx1hTewvFjNmPGSUmSATqiitYtBmkzkDxWV?=
 =?us-ascii?Q?plUxSxRGKfH5OG1XILhRdhD9mZwSlH6AtPri01t4z/mbMIAQkvXexORC6Kca?=
 =?us-ascii?Q?Ds5F8m0ivp4RhutiwiwILwUjdZ5En7TACEAkCPbLQt3N0dNbJOcT1mYsBwPO?=
 =?us-ascii?Q?vvcrlH5hM71u6vrjqpaD6yxfXXyc4Zk+jKo6Vo8pB2anWHCMqyiccXpkQXAo?=
 =?us-ascii?Q?81lnBeCVcP8zmxN8OoLBRi+u/5YbJyGsbGyFGeiqEW26UU3WHYrtKTRfxBec?=
 =?us-ascii?Q?CsAQ65w1CjL6Kp+6mPxp6834d/sRCSlgHE+YF71teMw0pkNwluFTc2dIrJGC?=
 =?us-ascii?Q?VGj8voqrxoYJ/FYPLOdKJx+nOTL71cMfWM571yrxBnQ9/MlMbEO/ZZuRO4A3?=
 =?us-ascii?Q?83b69zGMYyLWNbYpccT1SN2zb2uKmiUPX323jtG2L28A9qii6RV2Ral8MCNv?=
 =?us-ascii?Q?68mZLeIZg1rJc8uUfbJIfrlgwpSlnRKTHCycwDI/s0CHA3wCOfOLty5AXqka?=
 =?us-ascii?Q?3fTpFawQBP/6LI7HYSFaCmOJEwqgzdJQcRoV6S8CqaJ78tpNP23rZdZWWva/?=
 =?us-ascii?Q?blcUTvrW4jt006qiOw9qcH6IYVyBf83z/BPllZzcPzWN0rpdbw5Pi99ipgqt?=
 =?us-ascii?Q?dRSxKOdjmWcSY6Ybmz14o2pbEJe7DoGiNhOBsazQoqgjrfz1LqfEJyHE47rm?=
 =?us-ascii?Q?L51AASVVVfzZorobGG+sz5mMMLOxQY9H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wFpOCdfy+0+Bfz941yJ5g7e29Im7mrby6R4Sx9yJkp9hm3/iqOPdkY/obwoP?=
 =?us-ascii?Q?4guYG5hD7oTUN0qJ6+8m11j8gJbB3TOxzsajy5MxJPyMg6vZZeNZg5XSVsv/?=
 =?us-ascii?Q?IXy9im/PWn1J6VKGoQ0X9SmlEWvyolvxgBe4oitPfruoSqq17mz7rdRInSrK?=
 =?us-ascii?Q?rZd+T7RSKWvYXiuex05lkNbWGaXYPKvvvviIC6JfGmegcUk2klFQb1Z8/23V?=
 =?us-ascii?Q?5cAGRhG2nPE0bNMtyUgbh0ubnqwVWxlppUgrKE8BRvQB42cyNprjqfX7FGkI?=
 =?us-ascii?Q?o//iR8XjLblwCrI/IpnvpwFDJ67UcZbjj8K71MhcNBSXRbZuCAv2HazFerna?=
 =?us-ascii?Q?2ySQ9eYxgnx33muIsMcK+JNXAHh1mnvAfkudizMzoG31blSq9NpqUc9Cm7xZ?=
 =?us-ascii?Q?SxL9gfdLr6SsAdbIse3elYHwh3e9AQV6ch+j6T3D59W7KvwvqI+wZanlRK2W?=
 =?us-ascii?Q?orVhhZhVXAdNiHYIe2PFXjOQ1oKeQ0xHGL6jJUFNNOORsUgoelMf34js7cxr?=
 =?us-ascii?Q?FyoQZtXMkq/4kZqcFYDfTBVwBCHEoLkZ518JRpwNfFc88wvlCnhSk7+iOZOL?=
 =?us-ascii?Q?PHwJkP9xn7ri9Gcvi1Y+Fm700Dl6+6iLLK/MgBAc8HkzLGvDR91urBLJGACd?=
 =?us-ascii?Q?3mQmZW6DJnRGE0aT4DsI1MIvP2P2f5kVCECV7VUrR9EO+oUZ9yTDlMG6RbmO?=
 =?us-ascii?Q?lc562DVXbxnKpBSoABuzMSAyulGDizncoq3i8wlIOx2YMl06wAcbRk2xSy5h?=
 =?us-ascii?Q?4GnKdoJSJbdqBaTEHEmoN8enrDxUkPYBoDMwVuPh/iJlwUwSzvwpOpHQNzhL?=
 =?us-ascii?Q?rvj2hSpMRCYimkrHbHq172t3v640ON9w55N4DFiI+vvFa6r2waTX9Zi0x3wp?=
 =?us-ascii?Q?moAgl+7/gvqF2CBP2FIfKyOWWxKd+BlL7gR3C1Io2LeXirTw3ADx3ZPnJN0Y?=
 =?us-ascii?Q?av3i5yfdMDYwIOdtR0HpO+D2B7J4Md2SNgtb3zPTh0aiEMTHwki0EQuO1MkG?=
 =?us-ascii?Q?km3Dqidxn2XEK8iHMN5pOejiZn8tuWpoohdj+qq5hKJjUZCNSRR4MM/YGrqB?=
 =?us-ascii?Q?kyPd4qyjIH24BXi3WF16tmmt76mIMl9HP8Eh1Mtlf7uownYGmHOWohhJwuZM?=
 =?us-ascii?Q?yRj772LbAILUF8jvlGzDfpVp61IhbTdw7p1SYhLA8X0Rj/zS87/1LxaBCBPZ?=
 =?us-ascii?Q?cPVGb+BM8hNq5jBRB30qrF5sLitDPNRp7i+XK3AZNbOLtFr9HQoYLxsjoY2K?=
 =?us-ascii?Q?jObe4QQyzDz82OK/NlMyYUVvTwocRLF4yis8/QSr9mihpQa4T7n6czIWO/Ph?=
 =?us-ascii?Q?/QhETIziEs9/BJTES/qA0qe8sgz2bRiyhAn2YB1YZMuZWjUiaEHV4ncqRwWV?=
 =?us-ascii?Q?7kBZNku7WER7odEmrSMVlrbbzkYxxyDaKjLWC4CruJnK2sgZiu2Bx7B7i6yU?=
 =?us-ascii?Q?vKFEaecCzmKVysv6dnw2GQ1CZoiFhlv95c2T54Smox5UZw9a14sGUTzaGYLd?=
 =?us-ascii?Q?TEE/unrwIyr1Ae3NIPx26im+P8n3fTXxUSDRnKhbvhcW8YEfc3KeIeAslNEN?=
 =?us-ascii?Q?pqZrM9WmLrH4mUMDEFQd2vcJGfwFUlvnNpA2Z5SI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44198617-05f0-4e05-5183-08de0a950878
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 20:13:54.4066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJ6KYWFBSZO1PJkeac6USavhBMBYp+soal66irceYe9n7Cf3hCmIzxWogqujmj7O3l4dQDG1JBEEsrolRdY2kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9665

On Mon, Oct 13, 2025 at 08:44:26AM -1000, Tejun Heo wrote:
> > Tejun Heo (1):
> >   sched_ext: Allocate scx_kick_cpus_pnt_seqs lazily using kvzalloc()
> 
> Applied to sched_ext/for-6.18-fixes.

Meh, too late. I just noticed a bug with this. I'll send a follow-up patch.

-Andrea

> 
> Thanks.
> 
> --
> tejun
