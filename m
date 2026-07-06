Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011054.outbound.protection.outlook.com [40.93.194.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40BE3B443F
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328723; cv=fail; b=cMdjMxDnuyQHI4v3WTzyKJChO/QGwl75rpmCtoQodH9SVWPwxes+u3xvncrLzSPtEKgX1oNBUNZwbtRT+3i9JWNEA9lb5xGh5M51BQ2BiBQet5OBJzAyGeqYZ+Q0kUywTQotWy5rniGHaSz6KdcSyYndDgru0iGvjktEngjH8Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328723; c=relaxed/simple;
	bh=2DpbXLJzZILE88JixwuMbaeI25Zj1WBIXTqbyFeRJ10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YCzaU24I1xXMKoiao7VKI/sxkRsbqGcs6nrv4wQBetfXP6DCXxayeuHFaaF1fCV9jeiCzqh1vUVjOHcKQBvS3lUOFmfzNWKReGp1KeqSxyY5/MKGDbyjilJQE29q7on0fMRGfovw2R5ukxR063cswAfJQ7C8CP9hmQXi8+eOFqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fIEz3zO7; arc=fail smtp.client-ip=40.93.194.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fIEz3zO7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQ+aNFyYHHNqVmDULHCM83lTYwwEeNH5BBMrzNImJ3nQ+k1U0Lcv5LbdyrgI6mUorS3rIU9ONRcWuYznB2TWRkteeOTMU63+V6LlEQnp5/expNx2Vdqjt87tmZ817YH6u1nh5SZs6maHdLr/pRZOZXRzKylqe+t7KkbC2JQ6AU0wf4XdRFvrEeES64Ua0egJSCiOIezLUAieBFIrtz0eriZ36FrDNrH3hAWrhJVmkUn1AWrSm3ti5dXvK+0zxE9lRSNEKmqCpn7RNSbNGdV6TWgkomxAX1VstGjpkrK2WXgjsq1zQVmFJYCBNZvgEE5PyPX3rSFvGz3/S1jRz17HKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KLTf/4l9qWy/YxoEFEiLe3LI85SIWsnukzClG3wk4A=;
 b=GY0K+b+fVi3hloEezoz1G69OGXK/z4BCHopEpyGNBruCwEl92ZgORfWSzkhiYjqEqvP5r1Qmw6BzaueRgV1CZRzQhm0kTqixI9U6+rhBWV4cpLewHOocNvW9y4Uvs/rrwZzUkZIOxDYbqsssmleW/UYh2ncN/y1Pq0deExu9guc6f4GzvPrUbd44bjMwe9dua/E1GmF7ZyqTXXu5f6DC6rizP0EHwF2uLPMzarz5ojmM3ngLS7bU8dcQcQeqIL1Jr3/S7BEIKLnmEYa+vBqgaKP1pFfvwxGY8qcK33qLizS5exS4aIWwXPmrMgSILzQ/odf2ptruiocmN+D4gmDecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KLTf/4l9qWy/YxoEFEiLe3LI85SIWsnukzClG3wk4A=;
 b=fIEz3zO7fPci6aylkLSh3/J54LiawDlCUpLRqX1ZgABj6PSEjgvgeIaetp81lBQfSo3/+aBf83j/JXgtIRPXMMG1bues9kfAH1ghm7fAtqh69LXCmlM3HmEDUmF7/CxsBpXUhEUouQuy0FcFeG1tIRf6qmv9HjxcY0u179A+URZ3jKliRhtgaAo51aXcA77o9OUx+jAU4pSHVaZCgxQL/i+S6hSO3s+U4FHS1rcj4huX5acqD8lLFsH8M6hWF79lcbAeN0uBNuWHKTfUUbAFgYxnHaTQnhwCOcQRh5dhfFUPKkcoHgcaeltMJCRkBJGiTkEdDj9sr1Hz1dNA4mh7MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH1PR12MB9600.namprd12.prod.outlook.com (2603:10b6:610:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 09:05:10 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 09:05:10 +0000
Date: Mon, 6 Jul 2026 11:04:56 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3 15/36] sched_ext: Add scx_cmask_ref
 for validated arena cmask access
Message-ID: <aktvuGHVDEKnLlu5@gpd4>
References: <20260706014058.439853-1-tj@kernel.org>
 <20260706014058.439853-16-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706014058.439853-16-tj@kernel.org>
X-ClientProxiedBy: MI2PEPF00000B80.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::417) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH1PR12MB9600:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5327c5-b7d5-4ce8-ac87-08dedb3dae7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|3023799007|56012099006|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	SLInWgDTQAkWp2h/nNbvxZyCUtKPutZ0GeE62QxVZW5vniZYgaNIsCJGZIjb76niBfl5vINbMJJzpuFDJTR0LUHxF7DSG4Xynyo4wyuOxmpUWLnJGsjnQQ8ZrK1+WkErwvndLVwH0O27TkGK/recqYjhT21znF+kAcUlykcc7coTzSJ2pLsSMofoSJMjTH6Zyw841oNUTaY89D9nBQOPjGAgdRecNrRc1CireNofUKqZnZU3AWVPO4lstzo4THSjV8eXaJUOBPOsFTC9nGJdBnQKGw19sOLdUg6PJO5x/FVpnWRq+gpSSOXzD11yVAAbGM9+T1Izx0KRHAH/AUqM+GZYnOQVaznZQ+4xxEPM+vBAlCwvaHXU9GsQujjMF97sOy6zYtD0AqtzB3UixiGzaKLY4DNgU6RXdz91PM7qq5C7XUc2V73pOV1Chx8p1p2D8xidjTx8srU/5SkJyeD0FBNtMAqomWIfJW8eM/RANH+i8BBRLQ13AoGcdn7SL7Xe7D0NLPeFvGggGSCJPq6aWA8g3WF5iO9XNvWjJKE4q4fse2LWE3NHgSj2k/y+lXQInexJAq97FcBZuECwYEWkmbb3nHHg0W3uMv4dn00GYB3qprBnQ969VNQqG5alnBadXe6E4bkmjHM4LgGVsiZVhNEsUsagB3GmNe5tVN+GGoU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(3023799007)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kJUEZeWBt3D4CO0lzfyIzKfTuMZkbKXDQ63iz7gZpgxhaHRWpapJKmU1J9Fe?=
 =?us-ascii?Q?4rIC1LnLIdUkaiyvGnQGKvkT8oqWQX8Rd34wZdMrjVmLhY+Ib4ps0B9eeDDb?=
 =?us-ascii?Q?lYHHaXxfSH6w78a3fjpVwIVwWCd347g09gFL4m+McnDAm6e0TODUaJ/6VmFl?=
 =?us-ascii?Q?eQVPWSwISVMgyGi3fUe3QgyyT/xbIZWWLCyPZCibEe8VhVhEwfeutl2xbVpH?=
 =?us-ascii?Q?JfYAqewgb5OLpAH4dNRBXojG6Lp8BiLusCtMyjR2MHOSUIV/x2kByXAAlYb2?=
 =?us-ascii?Q?1e18PQay6n8d/mwmq/B+9KVEXz0lXqZtswBprdlajtmOY50ju9evCyU82Q5M?=
 =?us-ascii?Q?C/RpPR6e056iirKSCwZ+iz9QRt08a46JG0GV93/ShJg4XKUBJWgg4IhhwuQy?=
 =?us-ascii?Q?xPeRmW79Gc5Obo8fDBPd/N8m1ZwDQtK6dCOzdJ16Lao1FLiT8jT7jq8mEaJi?=
 =?us-ascii?Q?0PamxmvjQB2kXuIkMZXt342PjFKbQAPk0dSk8BtNlLaqSCZi8XGTXXdLa3is?=
 =?us-ascii?Q?nhO3YRueziBajCtP/oWb99MwVE81mgRNuYbU2p1MjjiQ9FO8Wmp2ya5IfV95?=
 =?us-ascii?Q?vu4oeQio1O/QiA6PMM7Fw10maU51Red3NfrOBJaWsszdMs5DS/FQ6b9lgQnn?=
 =?us-ascii?Q?J8vr/7hoprwPdcnVCuuRjoOFHAzW1r78gn1nCBVAXqpM/KOPDZIi25I92SA2?=
 =?us-ascii?Q?nLUrLytcO0PKoBbxVb1mftuOU3WmABiKnuyseuiyr8zo3pEWUhnHX6NQFaUK?=
 =?us-ascii?Q?oH5+jJYYVcLM2hq6+hgttJLrlFGEUj7X6QXC5z+ICOtSlnqLkl3+6K8KYwlT?=
 =?us-ascii?Q?geMjiDFSjjGWsUdt/U/90GdeW3tNbiY1d6mY2w0WUXDSuoc8KSxJ9qu2EfAU?=
 =?us-ascii?Q?nNSTrL+2EfZjrpAKhx8pM/ukQCPgWFIai2crNJUV1x3pk5ekJ0m04qvEef5m?=
 =?us-ascii?Q?Djb4tyuiBWYlq1Z/JI18oalATJBRlyW4/ndZT02MWU2enWo2MqFy+IdTXuCK?=
 =?us-ascii?Q?vVDrFqOXFWvXFhG8zcBuIOjhMfc/ElmOUikAKkFMiLAw6ix58/xW3VMNcLwg?=
 =?us-ascii?Q?4iPEb/0YTpKMuPP0HCh4PfoGNtdQo0Fb+D8+JDfQvq6YWRV5AQLmHK+iXord?=
 =?us-ascii?Q?TO66E+/g7bKozmzViRowN+eyr5GuDYeGZ5ZuHtlV9ClBvA/0Gs6/hLz5AT7s?=
 =?us-ascii?Q?crckyGnldwjBnz66HbAoLSnppKO+6bts3wqexfQLiETj9jjzYBKHm3FItlux?=
 =?us-ascii?Q?jhINbbJJd0ieF4pNwGn4e//P8FCZYHaO8RBEalJsBa+YvRMeiONixUCEx+TC?=
 =?us-ascii?Q?XbbCEZu0jYaSEQR6fmB5ZmLSjgMtBgVnlGqSrhAXUwfqC+EdupUmoqzG/I2i?=
 =?us-ascii?Q?uIsV02UFX0iCdsL21FjlVyzM4K1OuzNqE/ceX62+stpX3Bbgsd9CNcvmOU6V?=
 =?us-ascii?Q?QRayBRVv3gkATENdC3+5+HMaOBVD2K1eD82sQrm36nK8O7y43hOgpyEw+82c?=
 =?us-ascii?Q?Soxa4n0xupfQ5RhZer0mNKe+aRxvMMwCHN+hhg+ozX3gyo3udMJ3umY0WaTq?=
 =?us-ascii?Q?7hGaz0EQvrn2cblC/xgS1wkfJD11LWx5pXWfyJ0R8oH2emjpUGx9jd4UnFqf?=
 =?us-ascii?Q?Ot9PJXHUfMI8FCZzlwIzmUcocQyrLvRy/3TXeWSuk3dbKwBvc7Rcn2Bpxopz?=
 =?us-ascii?Q?1PuVT3pBZYapFj/mPwP8LF+h6mgo7gTAb1oNyIoIVaHYBJtH1B2GIEpz2Jjj?=
 =?us-ascii?Q?nvpXfeQ1ow=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5327c5-b7d5-4ce8-ac87-08dedb3dae7a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 09:05:10.1844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68zlo1j6B8VwmFBKzS9MSdz7kqFZwCW9sB3uSxVDyI2XDkDCzm7EZOwltjzzC6Cs6hpz3B0lw7fnGCfPEIYG+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9600

Hi Tejun,

On Sun, Jul 05, 2026 at 03:40:37PM -1000, Tejun Heo wrote:
> kfuncs taking struct scx_cmask * from BPF arena memory have two problems.
> The pointer can be any value the BPF prog hands in, and the header (@base
> and @nr_cids) can be mutated by the prog concurrently with kernel access.
> 
> Add scx_cmask_ref, a validated handle. _init() normalizes the input pointer
> into the arena's kern_vm range via scx_arena_to_kaddr() and snapshots
> @base/@nr_cids; downstream sizing uses the snapshot, not the live header.
> _shard() reads slices, _or() / _copy() write back; all bounded by the
> snapshot. No callers yet.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

...

> + * scx_cmask_ref_init - Bind a scx_cmask_ref to a BPF-arena cmask
> + * @sch: scheduler whose arena hosts @src
> + * @src: BPF-supplied cmask pointer
> + * @ref: output ref
> + *
> + * Snapshot @src's @base and @nr_cids. The snapshot is necessary because BPF may
> + * mutate the live header asynchronously.
> + *
> + * Return 0 on success, -EINVAL if the snapshotted header is malformed.
> + */
> +int scx_cmask_ref_init(struct scx_sched *sch, const struct scx_cmask *src,
> +		       struct scx_cmask_ref *ref)
> +{
> +	struct scx_cmask *kern_src = scx_arena_to_kaddr(sch, src);
> +	u32 base, nr_cids, npossible = num_possible_cpus();
> +
> +	base = READ_ONCE(kern_src->base);
> +	nr_cids = READ_ONCE(kern_src->nr_cids);
> +
> +	if (unlikely(base >= npossible || nr_cids > npossible - base))
> +		return -EINVAL;

We validate the requested CID range, but not whether the cmask declares enough
bits[] capacity for that range, unless I'm missing something. For example,
nr_cids can require multiple words while alloc_words is one. Does the ref also
need to account for the storage capacity described by alloc_words?

Thanks,
-Andrea

> +
> +	ref->sch = sch;
> +	ref->src = kern_src;
> +	ref->base = base;
> +	ref->nr_cids = nr_cids;
> +
> +	ref->shard_first = scx_cid_to_shard[base];
> +	if (likely(nr_cids))
> +		ref->shard_end = scx_cid_to_shard[base + nr_cids - 1] + 1;
> +	else
> +		ref->shard_end = ref->shard_first;
> +
> +	return 0;
> +}
