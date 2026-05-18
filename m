Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013013.outbound.protection.outlook.com [40.93.196.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F67D3A1CF3
	for <sched-ext@lists.linux.dev>; Mon, 18 May 2026 22:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779142318; cv=fail; b=X9ctRfJbFOjgIoSi/j9FPMSWybksDdEerdEuySj0DWJ15CiJbbN5RJMEwqQUsYSI03tiU49IjL9QGSSGabUhHYAEPOYrjoZLQy6aLkT2BAU7HrQg7QUFSoKnVe3sobMsquA9eitGYKH+JA0A7RP2W0vkuPdtlSfkaDT4OBFlEiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779142318; c=relaxed/simple;
	bh=jpysk/oP2r1nHhCBtgaOAdDDIafj/25qSN0J1U9BsRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=naUiyg4KohuQaQ28+KsWYSxI8Ji8QUxAUGiCQqUyUitxfsFZsQoJX5HpMtEue6BiEcMBSpu1uUDOj5OEoUusx3vXFo7ErcocidE9Syr2e72qBu6n9DfdIalhFNafAmct4SXmSJI3hkWrN+mD6m/waW/YZHzmaduls3y2JaRpXD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B3JXjE5d; arc=fail smtp.client-ip=40.93.196.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B3JXjE5d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qhoji2tHJVo4QPU3jKAFLuZBog0taXRpU5WvmmvFU07soaDq3k9TztLPrQN3S2F+cakHOThqEWSLFPWlFUSO2T4zUa2O3orFPQGhpRp0tC8nsTguWmGNdK2Us5XLBWvXcnSjnCiqaX67OPoeEmOq9vfbFuDwbTkK4iv16xnJs5oC/zUuqzNIOlH2Q8jgkyeCJT+cv6iFq14u02kdVWMkzSNO0nEIO35/e0QD9LeodUNtLJkD8oXE6d9Qck3PpL4x48SP7frpu9HZAGpcQ6h4g6nlQbG7h8+T30QHt3+Uls52JPC5nudqFRWceArt/Eazlie3RzFx4JcggkdH7avl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fb3CVaQh7xjHOnCIzT+vn4W5PbL3f5ygFueXMS17wNc=;
 b=Ici2miPs/dupRc6g6yzeI7CO+E/m9Y9IaiX8iGNrFGstS04PdCCTIEMjK6BhOEzTRuGAbY3K/iz0UmR7Id8cftI9a58plWE/fUXoMmkKWwFLAefExjY1Xeds5gJ0KkvlDRTtiMtQ6IDHVbtxXZ9CG+42cAoNQNBLUBwN8xf9wDGFLK0aVsaM4PZMibpanpgaW34elmIF0e+OJrDI9JrScXAHgjHKTNE4Jsnps5aQq+Eb4hr97YGjUUQYcR0Cvk2ngamapmkIIMztYOW0E8AD0mQ5HBhXRpX66/Ec3lxwc388fULDnxkLPKQUgpKfrHJeckAzsyhuLRkDfnGG9DErcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb3CVaQh7xjHOnCIzT+vn4W5PbL3f5ygFueXMS17wNc=;
 b=B3JXjE5dgPJXxtb4htEp4oOY1bjKpg9ydjB7Ejhsy2WyOTHScSrQLH06VQZ1raslLyjelmynBzz1IbDM9ua3+uT8s0xrvwNstxOtS0MA/SOMMmJbC/Q6DJOwGhpyzFpVAVhBRvb4H55aY1VVjfct112hBBWxx90lE6Yo/byjxVrX5GL2jpLAzuAt0Vgu/lf6PgIRZjmZJMzKAtOLMA0prc1dAansJ3KVMtVFicyOt9Uw2EHgaxBehpogUW3lMqMD7vW1ttNG9zKh5SrsaCDdiq7LO82uMlYsUY5+nAuN0GB7uiXsh8wDoMfb2DaH539QsMPHZiTC2bFlAnKzGc86dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 22:11:53 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 22:11:53 +0000
Date: Tue, 19 May 2026 00:11:35 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] sched_ext: Track bits[] storage size in struct
 scx_cmask
Message-ID: <aguOlyk581-y_Ru4@gpd4>
References: <20260517183614.1191534-3-tj@kernel.org>
 <20260517192930.1368685-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517192930.1368685-1-tj@kernel.org>
X-ClientProxiedBy: MI0P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::10) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW3PR12MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd31ce9-2c70-4f02-f3a1-08deb52a728e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003|3023799003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	BfKu+OQH+30K92CV/PJleFMn5Mw3lGw0pFMa708Xf+c3qhdLyzCkxdrqZEaiOd3+Xl+SVnRCklTPG+Ylr48Bf+84SL4p3pa2p9fTl6iS8inh5Nr/deUoXAfxtTmyBLK8w40mkrAXHFmETr0iPxfjHCB+pzpkXt4eIF9xNIdSylqwnAFzHgB0SsRK7+G0Qk0YtFZMi0bQ+IaSHxHKNOnFBadw2vl79xaZlw9wL+wK2Z4Mdh4YzQN3d9Bcv1eUMKO+EPy7wddOHrqOp493FW0g1ll0ZZIAuYfXxeTCS3CRSIidrWsSEaklTDVKyo/61O446nkKTBt6jlHAHYynd2bLtLK6VsTsDpWOmuEg76VFZrpCqzYRaZPtDVm5vwvTfhJRYJHOHIEodey5uyGgP+apiFm3zECHI0Pkm8tLAxcAFoniz+W9QGnxzhoJgGPPEF02VYRDylib+zLgjwrPwFvGjIv845q+2FxUH9GbABXaLvEKWLrQ6A0VPMi2cJetXYzXPS2HtRRdMN1k4A363Pvk9QshUbD1Z1vWRh+d2QsY4WzXA0w5vaWJPDzFYqzKQkfSTwDtzaa9Jwv73pNDFL4R0pWnCuO7rbLhYm7CLa21l1F555Tw8j9FE6Ov6n0F60BAaNME/hlnVxZon/meSuww9tD0e4sspnopU97xxk/ArtRDzxvgBUTJavUqvbF7YA+k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(3023799003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FeYfyHjjND6pWlWhPedB0aatXHOGeOZgMs3ZV4rhL0coWqx/uEPTNVoXigNa?=
 =?us-ascii?Q?lJkyELJ+SuvuzZ0oVUdWTrNMRPeLSmEHBLvTfKFuAENrqEFSjoWoUq+eCNYx?=
 =?us-ascii?Q?RPKNHPKdtVdsjYRQ31MrIM8mpFIiS2eQikq6aDDkUSTMIxzxt/gXX4C0v5/T?=
 =?us-ascii?Q?RJdfT+f1An2aeX5ed/0VSU/d+pdeu0DPAlD2Q6J0TnpKzuAQBUheZ7Af8snm?=
 =?us-ascii?Q?Y8dHFBYJiPodf466h9fCLnzvHcz26tRYMt/1o8S8VoaJunArZB6XNmvShtsc?=
 =?us-ascii?Q?cWHU9IdBHDFDjtnX5dl96kZ0Lq93oS72/yG/sLI3aBEHLDEHBK6wNvucmxuz?=
 =?us-ascii?Q?cfk3Yz1emDC2jJc0W/eXsUfxXawmFJAXrFLPgfcGAjvUxYfd94FyWuZvagnA?=
 =?us-ascii?Q?YUttGS1gK1zyY5Jqdn5K6QXX+WcRzCSyYNNNy0Ms3DR0M2QDkiRl46jpncrf?=
 =?us-ascii?Q?WsnOGcLdbYoGmslRYpHHyTiI+jn2bjCqlYG1BNVLMvYB8DLo07Em+EZUEZ7C?=
 =?us-ascii?Q?A1fO0+MKP6IroRXV2a+CXzNjnpfwqHSA2Irf6HH6tY65pYFhznP9xkpcIx5X?=
 =?us-ascii?Q?nLnxLOrOSLga8S231J9pXQivF247LX9A7rAvetscgkNuWzO8sJXPYpJmKuBc?=
 =?us-ascii?Q?ebyL3h8xdwg2LFABsJznbJtAWfd/eS8tegoql5CpcQR14QRhFkxp4yq/gRoI?=
 =?us-ascii?Q?axE11LHHfpt0IZ1pJROPcO/7vf3xERIYzSRHwsZXCuSSU1QgwMcaY2RK2eJ3?=
 =?us-ascii?Q?ilqTQcbuoySjAq3AVlukBSjpCIAOqAYbXzKnKJHHp5Y9XZ/fGJ7Rr9jFh/wL?=
 =?us-ascii?Q?9pKGlL8Wtr6sdgSTaSwfC75o+NOLq17H9PWv1DGXPQa55TwvNeT6oO0XpssN?=
 =?us-ascii?Q?cR+qzSwqQSMNVOMMp161HJwhoHjfGbnEr6VB1Qw3hNwfka0okLTP41lvL4pD?=
 =?us-ascii?Q?Kz+4V6mOJdw4g9Ihf5xFqp0AJXX0B3Dw8VAeh0q5iyJVW8k2kWgMGPDGsRRR?=
 =?us-ascii?Q?8YSA7zUZLTarwMmSQ9vyEr6ym3Li78ORS9tRhclJvqELFkzIedWtNOWk33uw?=
 =?us-ascii?Q?yio1RK96qAXT+MiFTmKtUcweunrCWlbbJp5Mgdq3TKoKleOAZP7xXSI+1rWn?=
 =?us-ascii?Q?ju0PjUc0ACcLqdY8R1EBB0RXU6y2oGiHmPb7CVbAcz+yR4e9AwAlEuXn94pO?=
 =?us-ascii?Q?ICYYiuspoz/oQeAZFr/VrKCN8rCkg01NyHTd0xHYGPjhRhoS0B3xZfBSQEgr?=
 =?us-ascii?Q?CYXbCHV5lB9xFwZxGhD+efl5XeOF6IxQaP/VDi4C3/LkjHD7QOCvl9w/lHuW?=
 =?us-ascii?Q?a5YMtMPYzPZsv7jAMJXUMRc5YfCfdzPBv0Yo+nXsIRHT+C9BJocE/TE4l5TQ?=
 =?us-ascii?Q?JadKyxjmWkU2nmdJJ7LCz0tDtLww+1c4GrnlWyYMZI3yujGQ+cSv79pJRMS/?=
 =?us-ascii?Q?orRNG8Calf3i1j8+1jafrGYawog4e+RahinQomudYNMadfwepjrmEjTUe/L0?=
 =?us-ascii?Q?x14aV0VxHu90QINtXKKhgXSIEwNsekPk9EcFgT3ZUtl9qRVGdPtEEC+dKIm5?=
 =?us-ascii?Q?RfsEbv+wz+eUYmcQ0iLrwG1pkkgS54mzXzcKyq3csvbD//WEvlikSeL6CD/K?=
 =?us-ascii?Q?hlo7k6bmrR81lZs8jMaUVwQY683+IeccBowF/fXzOk1sUdSOFic15pinWzuv?=
 =?us-ascii?Q?rKH71aRBbGqelkljrVN+gM52RYap/SURRiT3QL2fCnQ9HuTQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd31ce9-2c70-4f02-f3a1-08deb52a728e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 22:11:53.6456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7OIs2pzFdUwqMSTxVuSz0saRfmMmn54OSW+C7vyorJcbJpHPxIKuh9ME9ZMsZBv6J61cTAFiJnrCWHP453Fmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474

Hi Tejun,

On Sun, May 17, 2026 at 09:29:30AM -1000, Tejun Heo wrote:
> scx_cmask carries @base and @nr_cids but not the bits[] allocation size, so
> helpers reshaping the active range have no way to check it fits and later
> kfuncs taking caller-provided storage can't validate it.
> 
> Add @alloc_words (u64 word count) annotated with __counted_by, and split the
> bit-range API into three helpers:
> 
> - SCX_CMASK_DEFINE() / __SCX_CMASK_DEFINE() define an on-stack cmask, the
>   latter taking an explicit capacity for oversized storage.
>   SCX_CMASK_DEFINE_SHARD() is a thin wrapper that always reserves
>   SCX_CID_SHARD_MAX_CPUS bits of storage.
> 
> - scx_cmask_init() / __scx_cmask_init() initialize a cmask, with the same
>   tight-vs-explicit split.
> 
> - scx_cmask_reframe() reshapes the active range without resizing storage.
> 
> The BPF mirror (cmask_init / __cmask_init / cmask_reframe) gets the same
> shape.
> 
> Add scx_cmask_clear() and scx_cmask_fill() to zero and set the
> active-range bits respectively. scx_cpumask_to_cmask() uses
> scx_cmask_clear(); scx_cmask_init() would otherwise re-write @alloc_words
> on every call.
> 
> A later patch uses @alloc_words in scx_cmask_ref_shard() to refuse output
> storage that can't hold the requested shard.
> 
> v2: Init per-CPU scx_set_cmask_scratch (was zero-init, emitted empty
>     cmasks). Add nr_cids/alloc_cids check in BPF __cmask_init().
>     (sashiko AI)
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

...

> +/**
> + * scx_cmask_reframe - Reshape @m's active range without resizing storage
> + * @m: cmask to reframe
> + * @base: new active range base
> + * @nr_cids: new active range length, must fit within @m->alloc_words
> + *
> + * Body bits within the new range become garbage - only the head and tail
> + * words are zeroed to keep the padding invariant.
> + */
> +static inline void scx_cmask_reframe(struct scx_cmask *m, u32 base, u32 nr_cids)
> +{
> +	if (WARN_ON_ONCE(SCX_CMASK_NR_WORDS(nr_cids) > m->alloc_words))
> +		return;

Considering that:

 #define SCX_CMASK_NR_WORDS(nr_cids)    (((nr_cids) + 63) / 64 + 1)

If we pass nr_cids == UINT_MAX here, we have:

 CMASK_NR_WORDS(UINT_MAX) = (UINT_MAX + 63)/64 + 1 = 62/64 + 1 = 1 (wraps)

Should we simply reject if it's greater than a certain reasonable upper bound?

Thanks,
-Andrea

> +
> +	if (nr_cids) {
> +		u32 last_word = ((base & 63) + nr_cids - 1) / 64;
> +
> +		m->bits[0] = 0;
> +		m->bits[last_word] = 0;
> +	}
> +
>  	m->base = base;
>  	m->nr_cids = nr_cids;
> -	memset(m->bits, 0, SCX_CMASK_NR_WORDS(nr_cids) * sizeof(u64));
>  }
