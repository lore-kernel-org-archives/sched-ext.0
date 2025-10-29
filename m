Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5F3309DCB
	for <sched-ext@lists.linux.dev>; Wed, 29 Oct 2025 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761768577; cv=fail; b=E967vAfG/txNa9oz/SccZeai3EnhS9G92s5gMphG4XHC/KSeh7VNXSTEdzF2fHcEVGTRMcRQnlH4sKd9IlzMDwQbIS/cFa18e5d5EahWQiFxaN9EHuQzMQA6lWY+SS59GT8QafMuaO5zYEbs03kdkBHEbBnNMbGJTTfPGiF7M+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761768577; c=relaxed/simple;
	bh=QJ8ntpKzt3DrF/nxX7ly+4dxgZYNo5AgmnCcbrXqeBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WpjRM3pOflkVXKDJIeWucaJTuGHtqI+o5lLTFrlSDKkmHMlmYLUx9ChsyXDQwC2Qr8d6+7oNb3d05K6FTDVh26y95EIEUv2jTh7K5Gt0A03PUOj+iyITDaLjjwonKyDIIn1DLv4mhFjNQa3N1Ft7dYXfejF8Ia5JjX2Txa/YePU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uSaDPV5U; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uSaDPV5U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZQzWQ2j1GBWotVw5uidEWoAhY1+HXAufWmzatlUrYUxjNO8ceEIunqLwKttWgoqOk7I0ckdfsnf7eQlIQvTFVuLIzFMF2hITkgomsBgNtoORd+UCVMp/tsdzOGkm4xRCd5JFO/TTbdjPfdncawoCimAiTeb3mkxByowEaAgix/u6KvJKRHQ03BQyuU6m3Ep0b2xev5D/DdIGetLpZcRt2R19qJ4qPKV04151WbU/MX76G+jjaLvz6n/K7P0ri4o5Sd5MMa+mtx6a/bMHsg7aScFzTyYofKuiBHLfdak/ymXYRV0XQmdpLKhnDvpvGEzyhxdMMoUDuAILhKlwquu/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7li9Cs7EKR6cEjAZ+8CdQZPb0HngnHG3NWoVR6Vc+s=;
 b=ZxViY8B8BnzwUdw9heCXfDviqhL/4RqsF5md9c1XYf3ziBPdgmFfzz2y1HyCSGw0hH5cGsDKiigN9deCRRMeUpher0KzYdXETPNL4sKs/Jt1H+Z2V8+MFycH3aRHWd/IeH87Tp6MDLP+r52h40llyD86DeaQNtuxWog0CZrEhwM3gCWYHqY+DtxB4fDr1N8/78/d4ET8gZZbJUcgq3AiyT2vLUs7MbStKAQXj3mlWObNMTNVfuRQgPPW41SvZemqzB5sJ3RuxulShgA4WAvVoWgk5I97V3f1ORQYoTbKZzgoUt++IuLWbghSG1cuffWDN8tADGoX724LLKoHxRSjeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7li9Cs7EKR6cEjAZ+8CdQZPb0HngnHG3NWoVR6Vc+s=;
 b=uSaDPV5Uj2PiGFOLcOASlJPyFdzsLbDGratKZbrAuCTWWYofS15JoQ6smbA3gevkqZG26AjMJLUwth/2EEkfoNUCSV7c7TEXMnItyArKGCN/LpQWNKdptkZt7gltXKQyYLzPqT8vFSgAlU7dGNuPT0RkusuHky0q3ZOQ/LHwpZfX5jFZQc29dNU6eGO73uq/r+5XN8nSHH1TLd5MZAarAXwGJSMU+XZznlaBlOWg3QPoSW/XAoV5vJnfsKT3TfPb8HXM0yhNhvlsPClxFCMeFsh0adRFounfAU4IBl8MbRU//JpFj49tmogfRI9m9dG6fOvt+Ims3Zvb23MlYEdGCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7122.namprd12.prod.outlook.com (2603:10b6:930:61::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 20:09:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 20:09:30 +0000
Date: Wed, 29 Oct 2025 21:09:20 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.19] sched_ext/tools: Restore backward
 compat with v6.12 kernels
Message-ID: <aQJ0cPxIokHuX1li@gpd4>
References: <33d319a7063f59638ae1be709f4e10e9@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33d319a7063f59638ae1be709f4e10e9@kernel.org>
X-ClientProxiedBy: MI0P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: 21db512d-03ee-4244-bc16-08de17271192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7xcO5WNZnswsK1QwgFzZb3agO2MvX3CfBlsPh6MaDma43zFD44wQPyVS9T85?=
 =?us-ascii?Q?mdwjuE5SdUyUrWKjJ2WtxX12MPWv0/52OV/n3MumDKP3qT96jHZP8SsBZ04k?=
 =?us-ascii?Q?md2/DcRE33pFqQ/xkcAwHHlb5rQovOVs2VSJMJz/19ZW+nrhM6+/7VT/EK/W?=
 =?us-ascii?Q?y78oNGKVg/PXTh0Er/u0svuKz/7U3TQvRcsnI3jqt6SHy9qlbZkE8w63cSFw?=
 =?us-ascii?Q?H+KE6OSXZneSFWk1kGAr98PAKDTCiarzCKspxAASrcMWJwxLukORF3q/VYSH?=
 =?us-ascii?Q?c/ljSwN+LkSajgGE35HM9tVoV0C0WRDmlmmTEf+rhaLlQDOGxhpfLnvf1NBn?=
 =?us-ascii?Q?gMSoDHGRJ2jP79k06RT4972IIDscJsySfzeWO3o2ppHN8zpCqLef2gzQ+h2A?=
 =?us-ascii?Q?8vLQx49z9et4FDCoAFL1glSBbons+oavYtBsteVvW104+oghiusFXwaje8U7?=
 =?us-ascii?Q?s9SudljRTMeZtfOmGySxvWIlGGlcdONk2oD3n4K4nmcSrsstKWqm/h96/f9D?=
 =?us-ascii?Q?P4SpT1jZIRCrW5VWftiRxAldA/s+sWV1xCtRcaG91+GEhmwFD/eNVhsVQC/D?=
 =?us-ascii?Q?7yLfICq+GQhi5rIBuPIewwqhrIqm+nCO+qHOF8kCqkD/oInkB5GakdL03yir?=
 =?us-ascii?Q?/x2xi91PxVb+lq08tKqOen7GH22Ae9hBDTy0cZkrDqLpHKPyNFxE3Z6PkRjn?=
 =?us-ascii?Q?EvX8JrLYMhhDWkYS0dNVsoiJ6nX+90QK4hou/5TV0BETxnxFwJ/cgHG1iRR3?=
 =?us-ascii?Q?NdGPgxOx4MI6uWU+9BErMjomnHr6SxtRTLGy2wOK+I6v3wXUXZmhj80ksVZL?=
 =?us-ascii?Q?+GgsgB2E0ACflVemF5K2ixZAxYc/Pi36oyBE0ff3g9DMil+NF1YOJKhnpeOR?=
 =?us-ascii?Q?/8IWKTProijq1vO+zBLaN8GqjZcVcxeYNePEUEvuXgd+uHZFOTyqntOe1e4x?=
 =?us-ascii?Q?lEFNY9vd3OECkFMzVUmREnCvo33aKY9dPpOg2Z9SGZsTAlG5jzsdaxdq8Cfi?=
 =?us-ascii?Q?QztmaZW2h+h9T77Hw19oAm+bnu4VJrem7C46Xg+PwtDIbwQ65kI6Fjn8gzjd?=
 =?us-ascii?Q?VfoJ2nLhc9w5bTT4xNVIsUqGnQwIAVcwsaG9KtgbEjDth3s3GCXCqAe2qXP5?=
 =?us-ascii?Q?/igXy9VpytYq/e5yd6iICsknvItCU9Y9+4DueB/WJyb68w75inp7rP6lSXbE?=
 =?us-ascii?Q?R6QRUtOJbqtQ5tlw6rX3jp3ZNcdbY+78Vmp6O5t7WscHNvGI/xsgUDrAghjo?=
 =?us-ascii?Q?P/C49z6iVEwaEYi2LlwLF3bIBjijmYyRO0qzKjzODhSllfVGxlR9vgt/+WI7?=
 =?us-ascii?Q?aHKObWNjGvFDZJ2dF1PU9oeBsx6NfQL04vSTsc7hzGJU3NnJvaeXmrPxBp+J?=
 =?us-ascii?Q?EbGQSbarbxEKTk8WDhLkM4maABD9Icm6AkFSYP/iqVOH15+ATnSoJVz9k0CX?=
 =?us-ascii?Q?HuBeVGFhwoPj+W3igt50nYDkx39knqULO0wnRNYFx/ZzZLExIBC9zA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tv7qRa6YFZ8YdGoiR78rXgrhOugbszg+ksJRRUPR0uDa0XxCnLe9P38JFNub?=
 =?us-ascii?Q?C1DSruuvdkd72RyR3kmnI3sVH6GweRgHXf7hkXv1DGHDwABzZiOiSRuZ1dBH?=
 =?us-ascii?Q?gDmrtOMNE36sREMRNYfhWxikFn+pNefGk9Kc1Dm5/gLA6pANtutwP7zCAuEF?=
 =?us-ascii?Q?xzpK7c+7k8R4K3iVtWMcCjv31e+HcciRYTRMVtTVOO+9Q/iZ8u+/A7kCMEaF?=
 =?us-ascii?Q?yis1vGeB1UWikv2gbGlnB/E/T1PQ+5KDIcP6zhXujg6+l1kUDXHtD+6wv85Z?=
 =?us-ascii?Q?x91gj9F0c7EmNg7Rn+rSC6p6CIHxK4Ppd3809Pmte4SxKF7ly8eSNUkvIxj8?=
 =?us-ascii?Q?2fu86fYPqPCxHom+XwilVZvYR4/jaeQFlzfHWYMLRUeUT8RYDo3yFmymx7Zp?=
 =?us-ascii?Q?+uJEdstKe8UeZNvwran2HkBICvLOgYvYan2BruHjOKf99l8GW8Hjwv5jjmVh?=
 =?us-ascii?Q?Sa0IzS525mirvl9Uzz+vIhkbXbu0maQNw3+JBth0kJm2j6OVyu7EaFyWRiwQ?=
 =?us-ascii?Q?0vPpqHC0rnSCWGEiB5xauVQ3Iemrv4XYd/u/zZ3WFfL4wyZcZ9WR3+yE2EIs?=
 =?us-ascii?Q?AZlxSiVry0tMDIRTVL/tVtEbUBf3J8sT7a2745EcdOEGWRulSnJRbEr/eiUp?=
 =?us-ascii?Q?DV4Vfct5eba/xeOuza9z41OlEv/1WHHJiEzGZiVQhkxYOs4eXbejF4vBr8cm?=
 =?us-ascii?Q?s8JapRRt7/ecc1U3zBP43p/5UqoI9wltBKh/M4UXd1BJtRq1ZO0qbxdD4SDK?=
 =?us-ascii?Q?AS7yeEX/UDfno87uoHm7B9H2OtPOIls40vf+YbmQ2xS3vmS8GO4hHne4ua/X?=
 =?us-ascii?Q?yXMPGACoa89CFAEBfGrl4DSKujUlaUb6++DV5eNRxw7YfPI6P83GTE6+yUEC?=
 =?us-ascii?Q?GkGb2wIZsoTcEewIcznQMpx/FILo+adG7+y2pR5faCscJ3DvvhlUoSsHx+Yb?=
 =?us-ascii?Q?oK+HA8VBTFy0emSia9aXjouuB8w0zJVjFrzc8dgLk75/793J9Ztwl9K4KdxN?=
 =?us-ascii?Q?zUTc3pPNOit2XpH4l9IZ8hDOozsp6MvWS+FdaMtxpwCbyR/9aExQzrCdQ0yn?=
 =?us-ascii?Q?nMC+Tu1Mxhe/GELoS7mC7YmmHsJtyhLmub53y9of/5DVVc3f7AdVYT1QGuMF?=
 =?us-ascii?Q?L5nVFKvoB6UuwP+O36TPo/JhJEZVnIupy0Z3ogcC1RKkGF8bYs1Y61n+OCc7?=
 =?us-ascii?Q?2//Y6NeJ7Ah1BrWDJGuDlbEskrW3SkGLvECgCzCrkt+cLC3K/aMgAiN7nG3h?=
 =?us-ascii?Q?0lbzOeVtF3ypv25FT4kBB+rfwp20EylQJLkfivGcsuL7akGULIQJj3bzke8z?=
 =?us-ascii?Q?fC0uvTJ1mI/5tlhzPa1PoXkCtpWgjYCV4qK3S9NzGCy1l13glELKoivHxeey?=
 =?us-ascii?Q?n09bFII2xgXVgY0Ze1XZIhT9Uf0vBnunh7Kmo3T6h8RbmncBryRnDd2cEl6+?=
 =?us-ascii?Q?nPswfwM4m3KKR/sMfxZMYfdIhDKnJkL7gpcrRXiRaw2+UkNAi0AhWXQRqqfC?=
 =?us-ascii?Q?HTknu84dlT1Qh+S6bm9A/heOGov/e/d7zbyvFbmFSn2qVUw9U0TMriAsWDzv?=
 =?us-ascii?Q?tAWvrHfRcnfd2Hf0XkzIthYoltdTKWu5yKIhdpPl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21db512d-03ee-4244-bc16-08de17271192
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 20:09:30.0649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0m/8W6+9dzKSMEDKBhscouXbdTlySXR5+pdtLrZ0zKI0xWzB1bsvJtlzGxYqbSyPJ14Ih6FmNYe874x0R2Yneg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7122

Hi Tejun,

On Wed, Oct 29, 2025 at 08:35:25AM -1000, Tejun Heo wrote:
> Commit 111a79800aed ("tools/sched_ext: Strip compatibility macros for
> cgroup and dispatch APIs") removed the compat layer for v6.12-v6.13 kfunc
> renaming, but v6.12 is the current LTS kernel and will remain supported
> through 2026. Restore backward compatibility so schedulers built with v6.19+
> headers can run on v6.12 kernels.
> 
> The restored compat differs from the original in two ways:
> 
> 1. Uses ___new/___old suffixes instead of ___compat for clarity. The new
>    macros check for v6.13+ names (scx_bpf_dsq_move*), fall back to v6.12
>    names (scx_bpf_dispatch_from_dsq*, scx_bpf_consume), then return safe
>    no-ops for missing symbols.
> 
> 2. Integrates with the args-struct-packing changes added in c0d630ba347c
>    ("sched_ext: Wrap kfunc args in struct to prepare for aux__prog").
>    scx_bpf_dsq_insert_vtime() now tries __scx_bpf_dsq_insert_vtime (args
>    struct), then scx_bpf_dsq_insert_vtime___compat (v6.13-v6.18), then
>    scx_bpf_dispatch_vtime___compat (pre-v6.13).
> 
> Forward compatibility is not restored - binaries built against v6.13 or
> earlier headers won't run on v6.19+ kernels, as the old kfunc names are not
> exported. This is acceptable since the priority is new binaries running on
> older kernels.
> 
> Also add missing compat checks for ops.cgroup_set_bandwidth() (added v6.17)
> and ops.cgroup_set_idle() (added v6.19). These need to be NULLed out in
> userspace on older kernels.
> 
> Reported-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Looks good to me (and tested with v6.12).

Acked-and-tested-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  tools/sched_ext/include/scx/common.bpf.h |    6 --
>  tools/sched_ext/include/scx/compat.bpf.h |   81 ++++++++++++++++++++++++++++++-
>  tools/sched_ext/include/scx/compat.h     |   14 +++++
>  3 files changed, 93 insertions(+), 8 deletions(-)
> 
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -65,11 +65,6 @@ s32 __scx_bpf_select_cpu_and(struct task
>  bool __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_dsq_insert_vtime_args *args) __ksym __weak;
>  u32 scx_bpf_dispatch_nr_slots(void) __ksym;
>  void scx_bpf_dispatch_cancel(void) __ksym;
> -bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym __weak;
> -void scx_bpf_dsq_move_set_slice(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym __weak;
> -void scx_bpf_dsq_move_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
> -bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
> -bool scx_bpf_dsq_move_vtime(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
>  void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
>  s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
>  void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
> @@ -104,7 +99,6 @@ s32 scx_bpf_task_cpu(const struct task_s
>  struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
>  struct rq *scx_bpf_locked_rq(void) __ksym;
>  struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym __weak;
> -struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
>  u64 scx_bpf_now(void) __ksym __weak;
>  void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
>  
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -15,6 +15,68 @@
>  	__ret;									\
>  })
>  
> +/* v6.12: 819513666966 ("sched_ext: Add cgroup support") */
> +struct cgroup *scx_bpf_task_cgroup___new(struct task_struct *p) __ksym __weak;
> +
> +#define scx_bpf_task_cgroup(p)							\
> +	(bpf_ksym_exists(scx_bpf_task_cgroup___new) ?				\
> +	 scx_bpf_task_cgroup___new((p)) : NULL)
> +
> +/*
> + * v6.13: The verb `dispatch` was too overloaded and confusing. kfuncs are
> + * renamed to unload the verb.
> + *
> + * Build error is triggered if old names are used. New binaries work with both
> + * new and old names. The compat macros will be removed on v6.15 release.
> + *
> + * scx_bpf_dispatch_from_dsq() and friends were added during v6.12 by
> + * 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()").
> + */
> +bool scx_bpf_dsq_move_to_local___new(u64 dsq_id) __ksym __weak;
> +void scx_bpf_dsq_move_set_slice___new(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym __weak;
> +void scx_bpf_dsq_move_set_vtime___new(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
> +bool scx_bpf_dsq_move___new(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
> +bool scx_bpf_dsq_move_vtime___new(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
> +
> +bool scx_bpf_consume___old(u64 dsq_id) __ksym __weak;
> +void scx_bpf_dispatch_from_dsq_set_slice___old(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym __weak;
> +void scx_bpf_dispatch_from_dsq_set_vtime___old(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
> +bool scx_bpf_dispatch_from_dsq___old(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
> +bool scx_bpf_dispatch_vtime_from_dsq___old(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
> +
> +#define scx_bpf_dsq_move_to_local(dsq_id)					\
> +	(bpf_ksym_exists(scx_bpf_dsq_move_to_local___new) ?			\
> +	 scx_bpf_dsq_move_to_local___new((dsq_id)) :				\
> +	 scx_bpf_consume___old((dsq_id)))
> +
> +#define scx_bpf_dsq_move_set_slice(it__iter, slice)				\
> +	(bpf_ksym_exists(scx_bpf_dsq_move_set_slice___new) ?			\
> +	 scx_bpf_dsq_move_set_slice___new((it__iter), (slice)) :		\
> +	 (bpf_ksym_exists(scx_bpf_dispatch_from_dsq_set_slice___old) ?		\
> +	  scx_bpf_dispatch_from_dsq_set_slice___old((it__iter), (slice)) :	\
> +	  (void)0))
> +
> +#define scx_bpf_dsq_move_set_vtime(it__iter, vtime)				\
> +	(bpf_ksym_exists(scx_bpf_dsq_move_set_vtime___new) ?			\
> +	 scx_bpf_dsq_move_set_vtime___new((it__iter), (vtime)) :		\
> +	 (bpf_ksym_exists(scx_bpf_dispatch_from_dsq_set_vtime___old) ?		\
> +	  scx_bpf_dispatch_from_dsq_set_vtime___old((it__iter), (vtime)) :	\
> +	  (void)0))
> +
> +#define scx_bpf_dsq_move(it__iter, p, dsq_id, enq_flags)			\
> +	(bpf_ksym_exists(scx_bpf_dsq_move___new) ?				\
> +	 scx_bpf_dsq_move___new((it__iter), (p), (dsq_id), (enq_flags)) :	\
> +	 (bpf_ksym_exists(scx_bpf_dispatch_from_dsq___old) ?			\
> +	  scx_bpf_dispatch_from_dsq___old((it__iter), (p), (dsq_id), (enq_flags)) : \
> +	  false))
> +
> +#define scx_bpf_dsq_move_vtime(it__iter, p, dsq_id, enq_flags)			\
> +	(bpf_ksym_exists(scx_bpf_dsq_move_vtime___new) ?			\
> +	 scx_bpf_dsq_move_vtime___new((it__iter), (p), (dsq_id), (enq_flags)) : \
> +	 (bpf_ksym_exists(scx_bpf_dispatch_vtime_from_dsq___old) ?		\
> +	  scx_bpf_dispatch_vtime_from_dsq___old((it__iter), (p), (dsq_id), (enq_flags)) : \
> +	  false))
> +
>  /*
>   * v6.15: 950ad93df2fc ("bpf: add kfunc for populating cpumask bits")
>   *
> @@ -166,12 +228,16 @@ static inline struct task_struct *__COMP
>   * replaced with variants that pack scalar arguments in a struct. Wrappers are
>   * provided to maintain source compatibility.
>   *
> + * v6.13: scx_bpf_dsq_insert_vtime() renaming is also handled here. See the
> + * block on dispatch renaming above for more details.
> + *
>   * The kernel will carry the compat variants until v6.23 to maintain binary
>   * compatibility. After v6.23 release, remove the compat handling and move the
>   * wrappers to common.bpf.h.
>   */
>  s32 scx_bpf_select_cpu_and___compat(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
>  				    const struct cpumask *cpus_allowed, u64 flags) __ksym __weak;
> +void scx_bpf_dispatch_vtime___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
>  void scx_bpf_dsq_insert_vtime___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
>  
>  /**
> @@ -227,10 +293,14 @@ scx_bpf_dsq_insert_vtime(struct task_str
>  		};
>  
>  		return __scx_bpf_dsq_insert_vtime(p, &args);
> -	} else {
> +	} else if (bpf_ksym_exists(scx_bpf_dsq_insert_vtime___compat)) {
>  		scx_bpf_dsq_insert_vtime___compat(p, dsq_id, slice, vtime,
>  						  enq_flags);
>  		return true;
> +	} else {
> +		scx_bpf_dispatch_vtime___compat(p, dsq_id, slice, vtime,
> +						enq_flags);
> +		return true;
>  	}
>  }
>  
> @@ -239,18 +309,25 @@ scx_bpf_dsq_insert_vtime(struct task_str
>   * scx_bpf_dsq_insert() decl to common.bpf.h and drop compat helper after v6.22.
>   * The extra ___compat suffix is to work around libbpf not ignoring __SUFFIX on
>   * kernel side. The entire suffix can be dropped later.
> + *
> + * v6.13: scx_bpf_dsq_insert() renaming is also handled here. See the block on
> + * dispatch renaming above for more details.
>   */
>  bool scx_bpf_dsq_insert___v2___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
>  void scx_bpf_dsq_insert___v1(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
> +void scx_bpf_dispatch___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
>  
>  static inline bool
>  scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags)
>  {
>  	if (bpf_ksym_exists(scx_bpf_dsq_insert___v2___compat)) {
>  		return scx_bpf_dsq_insert___v2___compat(p, dsq_id, slice, enq_flags);
> -	} else {
> +	} else if (bpf_ksym_exists(scx_bpf_dsq_insert___v1)) {
>  		scx_bpf_dsq_insert___v1(p, dsq_id, slice, enq_flags);
>  		return true;
> +	} else {
> +		scx_bpf_dispatch___compat(p, dsq_id, slice, enq_flags);
> +		return true;
>  	}
>  }
>  
> --- a/tools/sched_ext/include/scx/compat.h
> +++ b/tools/sched_ext/include/scx/compat.h
> @@ -151,6 +151,10 @@ static inline long scx_hotplug_seq(void)
>   *
>   * ec7e3b0463e1 ("implement-ops") in https://github.com/sched-ext/sched_ext is
>   * the current minimum required kernel version.
> + *
> + * COMPAT:
> + * - v6.17: ops.cgroup_set_bandwidth()
> + * - v6.19: ops.cgroup_set_idle()
>   */
>  #define SCX_OPS_OPEN(__ops_name, __scx_name) ({					\
>  	struct __scx_name *__skel;						\
> @@ -162,6 +166,16 @@ static inline long scx_hotplug_seq(void)
>  	SCX_BUG_ON(!__skel, "Could not open " #__scx_name);			\
>  	__skel->struct_ops.__ops_name->hotplug_seq = scx_hotplug_seq();		\
>  	SCX_ENUM_INIT(__skel);							\
> +	if (__skel->struct_ops.__ops_name->cgroup_set_bandwidth &&		\
> +	    !__COMPAT_struct_has_field("sched_ext_ops", "cgroup_set_bandwidth")) { \
> +		fprintf(stderr, "WARNING: kernel doesn't support ops.cgroup_set_bandwidth()\n"); \
> +		__skel->struct_ops.__ops_name->cgroup_set_bandwidth = NULL;	\
> +	}									\
> +	if (__skel->struct_ops.__ops_name->cgroup_set_idle &&			\
> +	    !__COMPAT_struct_has_field("sched_ext_ops", "cgroup_set_idle")) { \
> +		fprintf(stderr, "WARNING: kernel doesn't support ops.cgroup_set_idle()\n"); \
> +		__skel->struct_ops.__ops_name->cgroup_set_idle = NULL;	\
> +	}									\
>  	__skel; 								\
>  })
>  
