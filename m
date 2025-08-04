Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3E625A35E
	for <sched-ext@lists.linux.dev>; Mon,  4 Aug 2025 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311290; cv=fail; b=jDhw1Kru2IG2ayuUtsEoY5n2Qr99rfJP4IGWmJ0zPh2CBPrl1u+YyXfWd9gcWCY2DPdpbCbuiU8qGFVy8k3MhgFgN1S1eBaA2IrmW/CNhKSW72OWuPuUr/ZmZmhHBhnKni0s5vN6tBPAdmqkmRXgcNWrH8zJwpmTLMGtQj+/d2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311290; c=relaxed/simple;
	bh=SF6pXS/0fRpF41kzJDh8SZEleox1zW6jNwncWMRWD4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VPwfR7HRmZ8ny2UGvu/q9rstTEFW1Zhns3JD3o39suBsfcF4YHm8lbiXmgtlrbFQk78rVfgftLbQ9tq5uKf2PjBqMx3bGGovvllezD1rq8uFuhT/x1Vk/hSaFPdhAvmntVSbk1O6Oc1Yzd+keSMV3G+OrpV6qJixSNeLc9+MnNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IVfUC+Nl; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IVfUC+Nl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZng4kVLmG2r3z74ijxupsnJYYbzWM6JlulE6mZH8zbjNvCt7ne2TwOvCGgiGQUxDHlbXkNaZR9KVhv0Hxrzv+cf62E3fnrYVJYkbLsTW4XxDKdjY3SHGkBkcwdgjs301CXE+yRHjUehOVebE/FsZhK+MhWbT2Xxb611f6UesXBWMtBowntVIENQSLZ4bYAmHg0Enbp/uz8xCGUqHwzOkwEZ8LTa0dxMivs/3uy5k61ugAFIpPEHdSIPOBwsHbaKh/Hm59xMoegTwyPbQjZHni9N2F/ZhcY5pcJ7WCiN1xCaOsCVEeo8RDj749MfKDogmYreFwM1TRRCdDcyrKlVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hhe9Uj7ZGt3gWDx0MmWXsFWbnPWL0c5DfAOqIsD6mTU=;
 b=NjoRKIiKntqjRACTsTrHY14dYKCWCtrsG5yh1ebT4uSyJ/xOVodX3vQ2RJSw/RiVCkXyy04oDNNpQeK895Y1qXTMd3RR39HEcrQ1wNWuBS/4iDXgckNmO5py2nSefboKDQl9SwZQ/+KypCb2Y8x/XSghpqeTXvBRn4KWYJKbLMIj6YtlRY2uN9wpRXjh1Y/KU5xQZTZF9ZCWgJZm19xoW5u+JMJChSLTlGTvSDsv0m34Cp0N58cCRZ7ZXSkoYdyHUlxy36ePpmjlfC2mia8ep9QyJSvWLm5tuV5Q0I+cp3cUCBrnmL+3CcyTwGNVlVKE8BSXBoiSkFHeF8zyJoHguA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hhe9Uj7ZGt3gWDx0MmWXsFWbnPWL0c5DfAOqIsD6mTU=;
 b=IVfUC+NljD6BxkkOisTxUT1sdvtMLnUK5DMdtkAULC9ntSikfK/FKgDCbjAAPXawm6rwy7sQb1q41mgPgawHXU8eV0RLpK2za7qwta0FeUfxiQKQVx4acwxKaelvR4LDy7YP6NT8xEkN8aMlYSen2WiExE0dmh2BqnJ13Y3GHwykVUkPGqgR9qTwH+jySzwLlrMcOLG+qBLGMp1JDF5TLqRvME8BaarrqUfD3N2G0axBh/IiyLdneKvpNFXzSYTBegqzscw4zjPtyz07+0vGLeJGNMYTQTp5zzN/WXMEfWxwo2+IJRKNCwIu43gOCfy44I1Rgibm1jwdCScW4J0m/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BN7PPF0D942FA9A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Mon, 4 Aug
 2025 12:41:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 12:41:23 +0000
Date: Mon, 4 Aug 2025 14:41:19 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: tj@kernel.org, void@manifault.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v2 3/3] sched_ext: Guarantee rq lock on scx_bpf_cpu_rq()
Message-ID: <aJCqb-ZI4pd15cr5@gpd4>
References: <20250804112743.711816-1-christian.loehle@arm.com>
 <20250804112743.711816-4-christian.loehle@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804112743.711816-4-christian.loehle@arm.com>
X-ClientProxiedBy: MI2P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BN7PPF0D942FA9A:EE_
X-MS-Office365-Filtering-Correlation-Id: 99bc707d-08f8-46a4-ce5b-08ddd3543865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vyukXNJgENAWSlvRkKO2i0A9UcfVCmlgYLCvtvMeI5U/D7BpPabya0YChAJA?=
 =?us-ascii?Q?mP+70/gyoaXCngiYV+rhuB2voYIyjbrfV8jZFgEZdZb6VBWBIFQnwLkrW3Ol?=
 =?us-ascii?Q?JisHjAU51HW8tcPNh5q/mv7LjSQmURkobwMfux51MeJ9aeqDeNFaPJpv/88b?=
 =?us-ascii?Q?eoQm3VCTtwetaXg/elpRfZNA1CmEVC4crlffdNgYKe13Im5kNN96C/NjKwcG?=
 =?us-ascii?Q?1rOPm7ls6/INi1NhYE1tFxd3Qel3leC9CHVX/vhwbUyfKqnroab9YjX7aIZ2?=
 =?us-ascii?Q?xqgXYxq2WkKC3j9fmZx5bnC25DOzorqZMTTPv10MgnNzOdll15aNUwBalBF2?=
 =?us-ascii?Q?8zWmbPDismqRCUrMfa2GtgvsKreRAtpgEzYD03/N8s8LA6IwOoIC3zfnfKKO?=
 =?us-ascii?Q?jspdn/OcWnbRaClQ1T1ZfcunWMImsDWHN9a3iJeMVNxuVISDSDBcWRZowVBm?=
 =?us-ascii?Q?iy+8c/YmEDrUZO4GoIJaCt3Zaeo32O5/eTz4G4ksKlZzDCPkjZyKySuCZYRz?=
 =?us-ascii?Q?wTitVbwtexhY38MKwoV1mFuG7JvxmzzFLy1AzdzdMdB8v9DRCcuuro9ZvjnE?=
 =?us-ascii?Q?AgnaHgfTORJnDadF3M467ujcEEFkQcyCnkSVjekETxcp/bUA9Vk9So1e8O7M?=
 =?us-ascii?Q?iGngH3kh7gdFTQnN0H7IGEdL+I+qfl+740vqaOxuDjSE8klFX+gZ92OJz6oJ?=
 =?us-ascii?Q?br2RYS0fJlyWIn+Q3zk8jwSna7ucYX+XCD3mr+9yAua3+6IeGKdTFQMWWeUg?=
 =?us-ascii?Q?1UtEtD/czumW4O8wZE0Coe7i5PhzMXyyZ0WWiNwuBi1yMJMb7rSQFvTiKYii?=
 =?us-ascii?Q?086mndDtQAdiH5N30+yDDAgG38880qG7ZlqfmjwOnxgwYS7OApu/HCCNNAMN?=
 =?us-ascii?Q?MSyPaj8Wy59O/O1/k9Mw3PrQfNfTYa+Q6+qD2f3fv44paTbUUY+M+83Q5WBt?=
 =?us-ascii?Q?E2zmiDeUFXM+y2f6GJ/xsszsGKEC2mTE4XeavglMQutq5K1MMOc1+A/MspjU?=
 =?us-ascii?Q?Y+TwWciV4+cqFusrbH3mg8jeG5T5NlG4javiM2OyWMP+CBL0WnFM1il2ncRe?=
 =?us-ascii?Q?MFy7JHF6XIUIsqrWgop0YEkpPY3BNwWLyLXRpn0pV3hn8fZsRHNtco/QIJOl?=
 =?us-ascii?Q?JzTUsF4MNAd2BzIhGWTHMrRSWFsxLk9dfdZm5fLdOY5JI6NJlb5VB7NM5c+b?=
 =?us-ascii?Q?SmE+tISKKhQqsiIDUv/LJbtFxPDmYXUIB1aBzkVWk8O2zlsDD1Pbf3wARiAc?=
 =?us-ascii?Q?e7/6SsYIZ9gxd2fdMBMkXeCouWArgd7WnpKTsjGRrfJEs6mlcaUJnv4XVgZg?=
 =?us-ascii?Q?UomsInsnXzpnguyqL2znEcO+Yr5Rz1jZOCou7pqeOqiLB8IBrxMfjbql2YuK?=
 =?us-ascii?Q?78Rmbmn4kzupG6PdWsUuU3Q2yZen3sgzO/J0sE4404KnIIZcCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Pks52NKCBPgzO1ZHzoJ4N7NI5nW3KAEQbvXXEATeHF0RrWQqtkCgzBzxoJs?=
 =?us-ascii?Q?iNx/5ntz0Dx5rbCSYO36OWE/fjYDy7kOEtKWI2frvw6VrwtBccboNz15PwA1?=
 =?us-ascii?Q?N+zWkSuWNu+MhyCX9XijN6MWrYY0PIOjUa1JoRZ+g5VudYATa4iC8mgw3+vC?=
 =?us-ascii?Q?a7kv/d3Zg6zsgrOKyt2tvcnH9FHYMUh/ruovtwWoifmnQnU1zX5MNigEQKKf?=
 =?us-ascii?Q?wXEg3KtFdNrcsHEMVnYhF9CUUS3GvjDuRvf7Ts917PZg/pf/Kbt9VTvcOXOn?=
 =?us-ascii?Q?SAJQ7uiVk7kfN+kMwmVqgnC3zof6yHt5YQsGGW+jG5EtMgkXvXU4DfPuC/lY?=
 =?us-ascii?Q?U8BLTUhaJzPvGPsagd72jGKPkvyqitM7KMnKKyv4a4sE8Hup4WkKWHTaRrS7?=
 =?us-ascii?Q?ntR+FbY9TL/fo28up65JeTVHKmoxz6ITkhHCa5ftAAqC4kmmN+2hdb7Svhij?=
 =?us-ascii?Q?onSAt+kdEqXASXkgMH2XxU6NVWoOh0QTQk21Swd9ehOcJJv8LlYN8Q9jw6PV?=
 =?us-ascii?Q?/DQGEc6ukDWenBujh22Wqg5XC9uW1bbuI5/e9S/Gfnvcf81gpGjlMG3LGp4Y?=
 =?us-ascii?Q?IqpkR9C/kh66CtQcCCuzkwlpOiP9eHqL8QnDvD8Orbe8jqpJlVNxuL0I+XjH?=
 =?us-ascii?Q?76WCglV3L+O3gXyv78r223peeSdB02zr+sT4+79udNT8T73W4lEHVfZuVFhh?=
 =?us-ascii?Q?m9vhQ+Y+MlL1bPjnCd76dq7J8FbMslAqh83hz8MH4De4wUq8ZNJYX4vVtW1S?=
 =?us-ascii?Q?+tYlsPiMOr45iWFfdckfyV6OvnJ5yTKnOGufuWiZuWJHDfatDAF2ShQk6hWa?=
 =?us-ascii?Q?nxcQ76cGfMGVmvslJ2rp9XhJWJ8bQxGW58//YPsgu4SoEmpDsoxlsILy/nG7?=
 =?us-ascii?Q?U9LTI0yrocjWu73LQ3OIfKPXsTJrlCSY3+YI9ILv/hF/gKokqnew2aYmBUEM?=
 =?us-ascii?Q?oe/I7ScMFl9qJ0n+x6z6Okt6Wth4hVhngPWxTsplRJwAsIiCOTZGMz/WBUWn?=
 =?us-ascii?Q?1SSnLe/DwnTikc+L4rGrVmoz90xbk6hSrVoFPDbnK5ulRKVY6k/T4y9Nt5Kd?=
 =?us-ascii?Q?4g4/Gm1Qrb0h9i3L2nXOC7EjNd/9Xi7Z9c4WLl47VpHvDz8VVKQdSUTBRbGy?=
 =?us-ascii?Q?s9xf4B5RDw1n2uzbOaD2WsMHfMtQcaAQe2WY+mm0bzJ0BebkvjDE1L6lpRwk?=
 =?us-ascii?Q?Dv8M6yuU6g0WgkXBFa6KB+z5+GZOKS0/FvL/rLFAsEIruyMQbeuh53P2S43F?=
 =?us-ascii?Q?Z1aKw8/x08YH1Kg0pVx4A9178fnOJtLqIaOuI/yo+Lm12ke1pxqRoQQ1+700?=
 =?us-ascii?Q?GI78I1h6Gz6OzVi40imE3vfOEsTm7/38Su6oA7NAEA4JVm4j5973NIV3oZY6?=
 =?us-ascii?Q?yT8sM0R5OTRc0SRfT/bsqdxijdXfAgxSaBfat+Js85lCFVeNRiWV3FJFI1qv?=
 =?us-ascii?Q?zWXHtvp4QQJvZ7qMSVGLanIgc80oyi0D6Cmb46+L2pO+NTRCiga70xmrf2bS?=
 =?us-ascii?Q?QNPOK3OEgziXJyCig5a6EPjfxsrRfe1xFfzJAuAN1w6DgQcmv9a+BknuvjHm?=
 =?us-ascii?Q?g3lZjxA0+m9aXn4U1Ks5IoMU503GWp2MBHEyLzDl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bc707d-08f8-46a4-ce5b-08ddd3543865
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 12:41:23.5658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlZfTzFKaiUMmxEDnO5byzgdtZGf//owO9Krm2poUECw8nf2YiRjlZ0CZm+TFN3fwU32zj5Rs6g+wBdrTxrVTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D942FA9A

On Mon, Aug 04, 2025 at 12:27:43PM +0100, Christian Loehle wrote:
> Most fields in scx_bpf_cpu_rq() assume that its rq_lock is held.
> Furthermore they become meaningless without rq lock, too.
> Only return scx_bpf_cpu_rq() if we hold rq lock of that rq.
> 
> All upstream scx schedulers can be converted into the new
> scx_bpf_remote_curr() instead.
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  kernel/sched/ext.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 1d9d9cbed0aa..0b05ddc1f100 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -7420,10 +7420,18 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
>   */
>  __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
>  {
> +	struct rq *rq;
> +
>  	if (!kf_cpu_valid(cpu, NULL))
>  		return NULL;
>  
> -	return cpu_rq(cpu);
> +	rq = cpu_rq(cpu);
> +	if (rq != scx_locked_rq_state) {

I think you want to check rq != scx_locked_rq(), since scx_locked_rq_state
is a per-CPU variable.

We may also want to add a preempt_disable/enable() for consistency. How
about something like this?

	preempt_disable();
	rq = cpu_rq(cpu);
	if (rq != scx_locked_rq()) {
		scx_kf_error("Accessing CPU%d rq from CPU%d without holding its lock",
			     cpu, smp_processor_id());
		rq = NULL;
	}
	preempt_enable();

Thanks,
-Andrea

> +		scx_kf_error("Accessing not locked rq %d", cpu);
> +		return NULL;
> +	}
> +
> +	return rq;
>  }
>  
>  struct task_struct *bpf_task_acquire(struct task_struct *p);
> -- 
> 2.34.1
> 
