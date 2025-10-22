Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FB5296BB2
	for <sched-ext@lists.linux.dev>; Wed, 22 Oct 2025 21:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167899; cv=fail; b=PcVrlVAOb9u3FoOASKD4iYH+Eo6ywePKok+iXN2djC2US2or0XHxHnY+qeDos5IV5dpHxEcZwsaLXorQ20bCvH/6lWLCZaXnw7L3zVIifM1ifft//6RBCDrrISSkGdN3ToRMsKd3spmZ43CxQ0DmssEMXVHoBwTPvx97/lcp3Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167899; c=relaxed/simple;
	bh=DuFCEGCV8+TBYkFzEiqZ0KVgWSmLCNqzVYHw6AnNWlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K7eWPtBirWp2x18GW5QOnlbexxnu2Xs7kh2LeHCyq+I8zWY2SZAdpuu//1xrCHH8AFwxTqzUig6TUPQlWPCx4z00Yr1j1BA2EbxjSvBvoF5hPZQH4ivwK2vvvtJA40/A53gsGSRRL/1A4j22jp/lFqaRfoDozNd7927ylhYkf3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WiwJaZb6; arc=fail smtp.client-ip=52.101.62.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WiwJaZb6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N98WJ7QDQzmI8+tMfZ4WFfndN/l3oy88hdeWk54YIkYOaZaCDL2fyS+bHEoPzoGqwwqnj4/I0RO+hlX4mEnDGX8fF4COQ/YUY8UCbPyHePFus7CTlfbB2JArKyMZqsRyjoWBvbt9hB8VrcoD9PnOpXtrosaan4e6KXpK58iCBuTezBA+mDWuItvQGhTQ9pzKQCH5CUudXQ1yOdxfUe+Yte+TyK2EbZS87cq4pdiJlggYs+1W/NJ0lED83ZJrppoy6fph6P2HawPC2N+oRFFFLzr5l+bVB74b/n9tgYDPPdiZhVD/wcjkOs/0cVsLEiJX26s8LtsvF+rP0vvzbjgzUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laFUD77wr03XbsCVi6T31ij0CEwCeAPnnQ9+NLfyAE8=;
 b=pp9O45IWFw5LvRl2QIQxQA9s3Iadvlll31VNPY+aUG6z0tzzgiY2P1WAqXlroRDvx27VVffh6Taw9aEtZTNfcbFRs3vTsb+PueskckSn0BiTDlVwT+/IoeCRFWpEYl4Ds9TfJYiE/9RdNNj7ZSdideshLFZp3WuHApu9POTjj/1bS2AWTLxtF833mj03f1/Bduagc19B/32Z7nic5rOUoEsIwOtIh53BfuUmbK6ZNwcT71jYoJWBtzHulyTBol8PrB3BDdkNkr2RRx/tJFxsGrhH+/9G1IGqQJw0UpWqjY7LJPK66ZOUayO3kkdDAeF/5oF0XsWBgUjxiZvA914+sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laFUD77wr03XbsCVi6T31ij0CEwCeAPnnQ9+NLfyAE8=;
 b=WiwJaZb6fJhzRoduUJz9eeqbFON/+2088lQEpERYZAFstZicZMoqIKL9vg2C3EuxARMpSPyI99KSMuR4s1/27maA0usIZzJozqGpO0j0Y7cS2ViSQXoieix7SuAeXyHY1Xvo8sCpUNlg2MgUxouj8lvVmPJYkgLPIjOeVbq94W6WHsh3yeD7DwyB/Y/vaucZ2kMc519ADQw26pOz08jNQfuutwZjZzrup7dbSX5oK2aUSx+G0IsYqBJFnDrFfuRUM9+q/P/jOQ3Ou+sxbQxJ6GQKfQrd0KMord6MzJdq21RC5vlFPZvBvI9wUz7hrqgHAUQ48SOLF+RMyYOovm7oJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB7723.namprd12.prod.outlook.com (2603:10b6:208:431::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 21:18:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 21:18:13 +0000
Date: Wed, 22 Oct 2025 23:18:03 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, changwoo@igalia.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, peterz@infradead.org
Subject: Re: [PATCHSET RESEND v2 sched_ext/for-6.19] sched_ext: Fix
 SCX_KICK_WAIT reliability
Message-ID: <aPlKCzr8i0Ggow1O@gpd4>
References: <20251022205629.845930-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022205629.845930-1-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0019.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6de8e2-0655-47d2-141f-08de11b0825d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4W8TRLE63zFEgt/xBgCB2BtW5SHqUf/76U6HPII3qNPcbzGvKI/wOF9M/jrx?=
 =?us-ascii?Q?twD+rE7fMf3QgVVtvu0izE6o4AH1jWOGz/ik+JsDV5wAYYryHyoWYvsrGjwt?=
 =?us-ascii?Q?DJ+9fTOFKzTptCtfJxx05LHbBgnkhuGfhXJG23QEwlyDmEpCTzdsRHjHsh4y?=
 =?us-ascii?Q?gS0slwWs26lgNwGkKYBxVeb2b30ix7EN0oGqcmHgiLcKZh+h0gvOCtkIjChN?=
 =?us-ascii?Q?Dpdlyxiej4jPjncrw9AEXu6CsfM7+2gAVMU+HbniIm2/b3BscngbY1lh1iDY?=
 =?us-ascii?Q?LxD1L1mKaH3Typ0N/aNwKWdLN1GkDonWARdTPn0uDdKGcNkoXtwpzKE1BZC0?=
 =?us-ascii?Q?juqJHaoWvG2CkgpWdVuMNlgkI87KsRacvZE13su4pxEbfPser9UEtoI8iDML?=
 =?us-ascii?Q?ZtctU+FoIoyDVJo/aobXSW2rRv3AxLmUfSp9NFTyFVb0NReqibadL0Ic392v?=
 =?us-ascii?Q?33QKmxir+mR1e+AI8IpfImf/xgBVZttIz+r9c4gcnN49c5VlUL522czOe6Xy?=
 =?us-ascii?Q?ogkPcDUkZzDY8qvC84FZE2M4m+rBIDT67N+OdnJTMuQpgGimJn79d26yiYaA?=
 =?us-ascii?Q?QtOWiIO+wLAUKLcrrFplOuod9Uu0MrsqhywDecLNnDKj7BZ1XPpX/4/v+Hyg?=
 =?us-ascii?Q?mN+CBFb/zuP6SD8j3ayxWyVCznrODmuo75ipwvNJkTK44Ix/kauX6Y2tyOtQ?=
 =?us-ascii?Q?eHdtm0dIn8HaGONPEvRggOjKcdlVBuisHpsDVUOeXHbo+vwLxRo/V3msGr+W?=
 =?us-ascii?Q?OFNcPQ0VT4vaRtfREf9PEt6FEdaMuk/yOExPaeVBPH9RCZ8JYIGBI28XTUrH?=
 =?us-ascii?Q?9ItNtKjq15QDxxh3/TTmY5W0dPYldbjlEepZ1ZtiURqbinn/LcNadtaX3RgN?=
 =?us-ascii?Q?mu0fn9BQx/oOEE6sTlreE2zXCvw/EjPhnY4I3RG96dg+GfGPSbborh9TGERe?=
 =?us-ascii?Q?Ote+K/tppee57lsneoG0KsYkUoGeRQFKCUSHuZZgk+jltI5fVNJAan/0yMsm?=
 =?us-ascii?Q?M21pxiO9s3tyl+9sMOqrrjSzgvk32bdKlToGJgIAE8un5WPN4pWYcsiOHX1/?=
 =?us-ascii?Q?f037O+wZMEFjr/4Ofmq9TNdK2c2pJU9lJdZKBYx9bkA6Vm3GUP5qN4Bx1ZPR?=
 =?us-ascii?Q?yeJzNPWVE0fb7aVHXWhya8yPWM8pgYTpPVaCQiFqmGo0M3Bf2lBxeT1WKJRA?=
 =?us-ascii?Q?aFlhLUiQCWaG6gzZSbMjPRXE4Rr31cWcJk3u4MZJ4AwkIKIq2T4jSuam+cHt?=
 =?us-ascii?Q?R2gOpR3kE8rFuATcpg4xyKBzMdiOXvgmdLRmKc3u9pw3mwDTUWyNqR3aIAWM?=
 =?us-ascii?Q?oVRzKENTnwGPiFvZLbGHQMcuhNf2GhWIjP2z5gI+DdwWqOE9IXlgU/BDKV6i?=
 =?us-ascii?Q?cq1xZHlahNQHvYpZcuhrgKAjyArVIjb3mbNMzu6IXvb9g0u8JgFVPdL1X3Lg?=
 =?us-ascii?Q?TPrEubywiDcKmYa0uh8XfnwVP8KDmDZ+1NlmCEluoTNyoFB3RXmrEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ASEG+wFCJr9UgPNx5WcFVPo/eVU1OwyxNBO3WEbYF+1snfCo7RnV2B8iTaLY?=
 =?us-ascii?Q?HAcpnfpmn9XdRG8REisJgQDCe89NTkbbM/7J61+jSaU5ZP8Fei8bBO9BAFkz?=
 =?us-ascii?Q?AI8wZuBbTcdkq9PmTRkFQmUFYOe1fE5B+UsKk4bUIe83a7OVaoSPi8t6oGzN?=
 =?us-ascii?Q?Kk2hcxYb4zt5BzgsVbD5Mhjm1Df1+sSpJr8z2vDboa8knAISUzxEyljrcwg5?=
 =?us-ascii?Q?Av5BMwXu/TqJGfRYD0WBi6H9Mdzfy/0HJo+Nz1F5Qpi+4qUrFgfqyNJJYg3V?=
 =?us-ascii?Q?vaNLgn/ZLA8O9W+Zhj7MWEnxs7dKYHNCWxE0C9slDddpX8nA95ho13Oq1nq0?=
 =?us-ascii?Q?TKVZUto+Skkp7+ygPd4IqXYBi05h12N5LMSlYLuEtUzVGL3cEL7Ra8Ejzulh?=
 =?us-ascii?Q?+aKSilyRgR6PVMZ5s02eUDIvkWzev9lrFgStsProTUSQ+8hKCyDQc6VHxer2?=
 =?us-ascii?Q?MiKMHLdz/rEqKseDlcV0f5zqP3DIUCCdowrxTbgyv2JIQldlQc1ir7IbKgda?=
 =?us-ascii?Q?4Ngz3yiQkue6vPaERrSohz1txemkfhe68QkaE6Rs5zu+OjXBqQMBkAYhT72O?=
 =?us-ascii?Q?DVbsVmsMizG+UEZL6vdVgM/TfUMlnyjn488XjahFcebvhyQ7NFMc1Chv2lH6?=
 =?us-ascii?Q?QuvW+AYFmDEik7RnTKeXNc/GLPC7kk6C9Cy0LshSwwb2In9d0RW7mra0/8ID?=
 =?us-ascii?Q?9a0jteMt6g5/rn/eiBWnopYehBJSS5mtidho9S9/qxgtwEOKC4ZqjZ+E9FUC?=
 =?us-ascii?Q?YgjerOixUiPKQQKbLSoU+DCJdL3fce8pRoR43VejLoVweFT/HBKeyJ3roH4z?=
 =?us-ascii?Q?3plhmvYvrM+BEMo0NHzqOmOy/YdkqbcuIitkwrEjHiQP8mbwMUN7kfuN6fYF?=
 =?us-ascii?Q?2BU911cgkuEFVtaHpu4Qf2apEnbEcxFHx91UUleYolysjb1xpYxzBfnrAlXR?=
 =?us-ascii?Q?yP8DK16p2cEHMu64PV36hijy1su20gdY4Siun6TkiaNugqoRmCDyliPyU7il?=
 =?us-ascii?Q?Pz82VaFNMnuWPQJK4MgOm1KqbSNgTHPleMTenyDTvO7hJJTUf3w6o1yr6Da3?=
 =?us-ascii?Q?3WxUCyLJ3LhqZMUm+5jdx7aFmnONVSFITfK1DfaCYDLeEhOwdbX7t13Y6gDK?=
 =?us-ascii?Q?KHYCbQpYxcmLnlrwMtUuS3ZAv/kwNAiVlt4qixrJiZQDXkfDe0ZBujMsYIpf?=
 =?us-ascii?Q?Aw7596FZ1Zki/UoYUwWuPhxM1OR2vYeASy5fdkma1sT92Af/YbLAt6a1RWPJ?=
 =?us-ascii?Q?ZWS5W5Nl9CyY0LJc8pzi4MSPEEJcdqmpE3xwsjZCYMzy6UvkKOlJqDACnhaO?=
 =?us-ascii?Q?iiwy40v0iDqL3swzQntIbaw2k/g21Zox8AENQWCRO+7X0LZ6BNbUdMDu0sHX?=
 =?us-ascii?Q?sgOk7c4zHcgmPm8ZJ2ACKwdEkKI8ecrfM7nQzeTH3mIzTfnNK3oIH2eX8IZ+?=
 =?us-ascii?Q?7YbHeI4HhWGecxBMZadJz/Qe0Jykn14SEk8KHwSR9Xhm9gaRXWWdtkPhgFdq?=
 =?us-ascii?Q?pcSQdcbsjAuvoy+j/MmmvnRABEgCngvjHRtwwRyvFOcYs10Y23RmJ7nVSZKG?=
 =?us-ascii?Q?vHrc9VVEpGOPw01/BdM8z5gYn11lPhSsdyo6EBi3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6de8e2-0655-47d2-141f-08de11b0825d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 21:18:13.4621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fpegtjr5qh9BdzbsH0+ohwzNYW9XNqu4Vng7ZwX0UL4moIYV/rAW9V4PQy3+msj/JYvdW131zy+TpTMnR04hqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7723

Hi Tejun,

On Wed, Oct 22, 2025 at 10:56:26AM -1000, Tejun Heo wrote:
> Resending because the original v2 posting didn't include the full recipient
> list on the individual patches due to git send-email invocation error. Sorry
> about the noise.
> 
> SCX_KICK_WAIT is used to synchronously wait for the target CPU to complete
> a reschedule and can be used to implement operations like core scheduling.
> However, recent scheduler refactorings broke its reliability. This series
> fixes the issue and improves the code clarity.
> 
> v2: - In patch #2, also increment pnt_seq in pick_task_scx() to handle
>       same-task re-selection (Andrea Righi).
>     - In patch #2, use smp_cond_load_acquire() for the busy-wait loop for
>       better architecture optimization (Peter Zijlstra).
>     - Added patch #3 to rename pnt_seq to kick_sync for clarity.
> 
> v1: http://lkml.kernel.org/r/20251021210354.89570-1-tj@kernel.org

Looks good to me!

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> Based on sched_ext/for-6.19 (2dbbdeda77a6).
> 
>  1 sched_ext: Don't kick CPUs running higher classes
>  2 sched_ext: Fix SCX_KICK_WAIT to work reliably
>  3 sched_ext: Rename pnt_seq to kick_sync
> 
> Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-fix-kick_wait
> 
>  kernel/sched/ext.c          | 129 ++++++++++++++++++++++++--------------------
>  kernel/sched/ext_internal.h |   6 ++-
>  kernel/sched/sched.h        |   2 +-
>  3 files changed, 75 insertions(+), 62 deletions(-)
> 
> --
> tejun
